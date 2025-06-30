package com.ramsys.common.security;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * JWT Token Provider that follows Spring Security best practices.
 * 
 * This class serves as a facade over JwtUtils, providing a clean interface
 * for JWT token operations while following the Spring Security patterns.
 * 
 * Best practices implemented:
 * - Uses Spring Security's Authentication object
 * - Follows the TokenProvider pattern
 * - Delegates to specialized utility classes
 * - Provides clear separation of concerns
 * - Uses proper exception handling
 * - Follows Spring naming conventions
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class JwtTokenProvider {

    private final JwtUtils jwtUtils;

    /**
     * Generate a JWT token with a subject and a map of claims.
     * @param subject The subject of the token (usually the username).
     * @param claims A map of claims to include in the token body.
     * @return A JWT token string.
     */
    public String generateToken(String subject, Map<String, Object> claims) {
        log.debug("Generating JWT token for user: {}", subject);
        return jwtUtils.generateToken(subject, claims);
    }
    
    /**
     * Generate a JWT token from Spring Security Authentication.
     * 
     * @param authentication Spring Security Authentication object
     * @return JWT token string
     */
    @Deprecated
    public String generateToken(Authentication authentication) {
        log.debug("Generating JWT token for user: {}", authentication.getName());
        return jwtUtils.generateJwtToken(authentication);
    }

    /**
     * Generate a JWT token from username.
     * 
     * @param username the username
     * @return JWT token string
     */
    public String generateToken(String username) {
        log.debug("Generating JWT token for username: {}", username);
        return jwtUtils.generateTokenFromUsername(username);
    }

    /**
     * Extract username from JWT token.
     * 
     * @param token JWT token
     * @return username
     */
    public String getUsernameFromToken(String token) {
        return jwtUtils.getUserNameFromJwtToken(token);
    }

    /**
     * Validate JWT token.
     * 
     * @param token JWT token to validate
     * @return true if token is valid, false otherwise
     */
    public boolean validateToken(String token) {
        return jwtUtils.validateJwtToken(token);
    }

    /**
     * Get expiration date from JWT token.
     * 
     * @param token JWT token
     * @return expiration date
     */
    public Date getExpirationDate(String token) {
        return jwtUtils.getExpirationDateFromJwtToken(token);
    }

    /**
     * Get expiration date as LocalDateTime from JWT token.
     * 
     * @param token JWT token
     * @return expiration date as LocalDateTime
     */
    public LocalDateTime getExpirationLocalDateTime(String token) {
        return jwtUtils.getExpirationLocalDateTimeFromJwtToken(token);
    }

    /**
     * Get JWT expiration time in milliseconds.
     * 
     * @return expiration time in milliseconds
     */
    public long getExpirationMs() {
        return jwtUtils.getJwtExpirationMs();
    }

    /**
     * Check if token is expired.
     * 
     * @param token JWT token
     * @return true if token is expired, false otherwise
     */
    public boolean isTokenExpired(String token) {
        try {
            Date expiration = getExpirationDate(token);
            return expiration.before(new Date());
        } catch (Exception e) {
            log.warn("Error checking token expiration: {}", e.getMessage());
            return true;
        }
    }

    /**
     * Generate a token with additional user details.
     * This method can be extended to include roles, permissions, etc.
     * 
     * @param userDetails Spring Security UserDetails
     * @return JWT token string
     */
    public String generateTokenWithDetails(UserDetails userDetails) {
        log.debug("Generating JWT token with details for user: {}", userDetails.getUsername());
        
        // For now, we use the basic token generation
        // This can be extended to include roles and other claims
        String token = jwtUtils.generateTokenFromUsername(userDetails.getUsername());
        
        // Log user authorities for debugging (but not in the token for now)
        if (log.isDebugEnabled()) {
            String authorities = userDetails.getAuthorities().stream()
                    .map(GrantedAuthority::getAuthority)
                    .collect(Collectors.joining(", "));
            log.debug("User {} has authorities: {}", userDetails.getUsername(), authorities);
        }
        
        return token;
    }
}
