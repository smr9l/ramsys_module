package com.ramsys.users.dto;

import lombok.Data;

@Data
public class AuthResponse {
    private String token;
    private String type = "Bearer";
    private Long expiresIn;
    private String refreshToken;

    public AuthResponse(String token, String type, Long expiresIn, String refreshToken) {
        this.token = token;
        this.type = type;
        this.expiresIn = expiresIn;
        this.refreshToken = refreshToken;
    }

    public AuthResponse() {
    }

    public static AuthResponse success(String token, Long expiresIn) {
        AuthResponse response = new AuthResponse();
        response.setToken(token);
        response.setExpiresIn(expiresIn);
        return response;
    }
}