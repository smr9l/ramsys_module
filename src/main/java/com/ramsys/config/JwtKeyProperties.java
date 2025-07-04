package com.ramsys.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.security.KeyFactory;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

@ConfigurationProperties("app.jwt")
@Component
public class JwtKeyProperties {
    private String privateKey;
    private String publicKey;
    private RSAPrivateKey rsaPrivateKey;
    private RSAPublicKey rsaPublicKey;

    public String getPrivateKey() {
        return privateKey;
    }
    public void setPrivateKey(String privateKey) {
        this.privateKey = privateKey;
        if (privateKey != null && !privateKey.isBlank()) {
            try {
                String key = privateKey.replaceAll("-----BEGIN (.*)-----", "")
                        .replaceAll("-----END (.*)-----", "")
                        .replaceAll("\\s", "");
                byte[] decoded = Base64.getDecoder().decode(key);
                PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(decoded);
                KeyFactory kf = KeyFactory.getInstance("RSA");
                this.rsaPrivateKey = (RSAPrivateKey) kf.generatePrivate(spec);
            } catch (Exception e) {
                throw new RuntimeException("Impossible de parser la clé privée RSA", e);
            }
        }
    }
    public RSAPrivateKey getRsaPrivateKey() {
        return rsaPrivateKey;
    }
    public String getPublicKey() {
        return publicKey;
    }
    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
        if (publicKey != null && !publicKey.isBlank()) {
            try {
                String key = publicKey.replaceAll("-----BEGIN (.*)-----", "")
                        .replaceAll("-----END (.*)-----", "")
                        .replaceAll("\\s", "");
                byte[] decoded = Base64.getDecoder().decode(key);
                X509EncodedKeySpec spec = new X509EncodedKeySpec(decoded);
                KeyFactory kf = KeyFactory.getInstance("RSA");
                this.rsaPublicKey = (RSAPublicKey) kf.generatePublic(spec);
            } catch (Exception e) {
                throw new RuntimeException("Impossible de parser la clé publique RSA", e);
            }
        }
    }
    public RSAPublicKey getRsaPublicKey() {
        return rsaPublicKey;
    }
}

