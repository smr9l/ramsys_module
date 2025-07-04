package com.ramsys.common.security;

import com.nimbusds.jose.crypto.RSASSASigner;
import io.jsonwebtoken.Jwts;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.interfaces.RSAPrivateKey;
import java.time.Instant;
import java.util.Date;
import java.util.Map;

@RequiredArgsConstructor
@Component
@Slf4j
public class JwtUtils {

    @Value("${app.jwt.secret:ramsysSecretKeyForJWTTokenGenerationThatNeedsToBeAtLeast256Bits}")
    private String jwtSecret;

    @Value("${app.jwt.expiration:600}") // 10 minutes en secondes
    private int jwtExpirationSeconds;

    @Value("${app.jwt.refresh-expiration:604800}") // 7 jours en secondes
    private int jwtRefreshExpirationSeconds;

    private final RSAPrivateKey rsaPrivateKey;



    public String generateToken(String subject, Map<String, Object> claims) {
        Instant now = Instant.now();
        Instant expiry = now.plusSeconds(jwtExpirationSeconds);
        return Jwts.builder()
                .claims(claims)
                .subject(subject)
                .issuedAt(Date.from(now))
                .expiration(Date.from(expiry))
                .signWith(rsaPrivateKey, io.jsonwebtoken.SignatureAlgorithm.RS256)
                .compact();
    }

    public String generateRefreshToken(String subject, Map<String, Object> claims) {
        Instant now = Instant.now();
        Instant expiry = now.plusSeconds(jwtRefreshExpirationSeconds);
        Map<String, Object> refreshClaims = new java.util.HashMap<>(claims);
        refreshClaims.put("type", "refresh");
        return Jwts.builder()
                .claims(refreshClaims)
                .subject(subject)
                .issuedAt(Date.from(now))
                .expiration(Date.from(expiry))
                .signWith(rsaPrivateKey, io.jsonwebtoken.SignatureAlgorithm.RS256)
                .compact();
    }

    public long getJwtExpirationMs() {
        return jwtExpirationSeconds * 1000L;
    }
}
