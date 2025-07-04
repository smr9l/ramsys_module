package com.ramsys.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.beans.factory.annotation.Value;

import java.nio.file.Files;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

@Configuration
public class KeyConfig {
    @Value("${app.jwt.private-key.path:classpath:private-key.pem}")
    private Resource privateKeyResource;

    @Bean
    public RSAPublicKey rsaPublicKey() {
        try {
            String key = new String(Files.readAllBytes(new ClassPathResource("public-key.pem").getFile().toPath()));
            key = key.replaceAll("-----BEGIN (.*)-----", "");
            key = key.replaceAll("-----END (.*)-----", "");
            key = key.replaceAll("\\s", "");
            byte[] keyBytes = Base64.getDecoder().decode(key);
            X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
            KeyFactory kf = KeyFactory.getInstance("RSA");
            return (RSAPublicKey) kf.generatePublic(spec);
        } catch (Exception e) {
            throw new RuntimeException("Impossible de charger la clé publique RSA", e);
        }
    }

    @Bean
    public RSAPrivateKey rsaPrivateKey() {
        try {
            byte[] keyBytes = privateKeyResource.getInputStream().readAllBytes();
            String key = new String(keyBytes)
                .replaceAll("-----BEGIN (.*)-----", "")
                .replaceAll("-----END (.*)-----", "")
                .replaceAll("\\s", "");
            byte[] decoded = Base64.getDecoder().decode(key);
            PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(decoded);
            KeyFactory kf = KeyFactory.getInstance("RSA");
            return (RSAPrivateKey) kf.generatePrivate(spec);
        } catch (Exception e) {
            throw new RuntimeException("Impossible de charger la clé privée RSA", e);
        }
    }
}
