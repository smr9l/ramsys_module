package com.ramsys.common.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.core.DelegatingOAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2TokenValidatorResult;
import org.springframework.security.oauth2.jwt.*;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;

@Configuration
@Slf4j
public class JwtConfig {

    @Value("${app.jwt.secret:ramsysSecretKeyForJWTTokenGenerationThatNeedsToBeAtLeast256Bits}")
    private String jwtSecret;

    @Value("${app.jwt.expiration:86400}")
    private long jwtExpiration;

    @Value("${app.jwt.issuer:ramsys-reinsurance}")
    private String jwtIssuer;

    @Value("${app.jwt.audience:ramsys-api}")
    private String jwtAudience;

    @Value("${app.jwt.clock-skew:60}")
    private long clockSkewSeconds;

    /**
     * Primary JWT Decoder bean for Spring Security OAuth2 Resource Server
     * This decoder is automatically used by Spring Security for JWT validation
     */
    @Bean
    public JwtDecoder jwtDecoder() {
        // Create secret key from the configured secret
        SecretKey secretKey = new SecretKeySpec(
                jwtSecret.getBytes(StandardCharsets.UTF_8), 
                "HmacSHA256"
        );
        
        NimbusJwtDecoder decoder = NimbusJwtDecoder.withSecretKey(secretKey)
                .jwtProcessorCustomizer(customizer -> {
                    // Additional JWT processor customizations can be added here
                    log.debug("JWT processor customized for enhanced security");
                })
                .build();

        // Set custom validators
        decoder.setJwtValidator(jwtValidator());
        
        return decoder;
    }

    /**
     * Composite JWT validator that includes multiple validation rules
     */
    @Bean
    public OAuth2TokenValidator<Jwt> jwtValidator() {
        List<OAuth2TokenValidator<Jwt>> validators = List.of(
                // Standard timestamp validator (checks exp and nbf claims)
                new JwtTimestampValidator(Duration.ofSeconds(clockSkewSeconds)),
                
                // Issuer validator - validates the 'iss' claim
                new JwtIssuerValidator(jwtIssuer),
                
                // Audience validator - validates the 'aud' claim
                new JwtAudienceValidator(jwtAudience),
                
                // Custom validator for additional business rules
                customJwtValidator()
        );

        return new DelegatingOAuth2TokenValidator<>(validators);
    }

    /**
     * Custom JWT validator for business-specific validation rules
     */
    @Bean
    public OAuth2TokenValidator<Jwt> customJwtValidator() {
        return new OAuth2TokenValidator<Jwt>() {
            @Override
            public OAuth2TokenValidatorResult validate(Jwt jwt) {
                try {
                    // Custom validation logic
                    
                    // 1. Check if token has required claims
                    if (!jwt.hasClaim("sub") || !jwt.hasClaim("authorities")) {
                        log.warn("JWT missing required claims: sub or authorities");
                        return OAuth2TokenValidatorResult.failure(
                            new OAuth2Error("invalid_token", "Missing required claims", null)
                        );
                    }

                    // 2. Validate username format (optional)
                    String username = jwt.getSubject();
                    if (username == null || username.trim().isEmpty()) {
                        log.warn("JWT has invalid username: {}", username);
                        return OAuth2TokenValidatorResult.failure(
                            new OAuth2Error("invalid_token", "Invalid username", null)
                        );
                    }

                    // 3. Check if token is not from a blacklisted user (you could implement this)
                    // if (isUserBlacklisted(username)) {
                    //     return OAuth2TokenValidatorResult.failure(
                    //         new OAuth2Error("invalid_token", "User is blacklisted", null)
                    //     );
                    // }

                    // 4. Validate authorities format
                    Object authoritiesClaim = jwt.getClaim("authorities");
                    if (authoritiesClaim != null && !(authoritiesClaim instanceof List)) {
                        log.warn("JWT authorities claim has invalid format");
                        return OAuth2TokenValidatorResult.failure(
                            new OAuth2Error("invalid_token", "Invalid authorities format", null)
                        );
                    }

                    // 5. Validate essential claims exist
                    if (!jwt.hasClaim("userId") || !jwt.hasClaim("email")) {
                        log.warn("JWT missing required claims: userId or email");
                        return OAuth2TokenValidatorResult.failure(
                            new OAuth2Error("invalid_token", "Missing required claims", null)
                        );
                    }

                    log.debug("JWT validation successful for user: {}", username);
                    return OAuth2TokenValidatorResult.success();
                    
                } catch (Exception e) {
                    log.error("Error during JWT validation", e);
                    return OAuth2TokenValidatorResult.failure(
                        new OAuth2Error("invalid_token", "Validation error: " + e.getMessage(), null)
                    );
                }
            }
        };
    }
} 
