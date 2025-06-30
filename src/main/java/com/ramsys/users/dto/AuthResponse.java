package com.ramsys.users.dto;

import lombok.Data;

@Data
public class AuthResponse {
    private String token;
    private String type = "Bearer";
    private Long expiresIn;
    private AuthenticatedUserDTO user;
    
    public static AuthResponse success(String token, Long expiresIn, AuthenticatedUserDTO user) {
        AuthResponse response = new AuthResponse();
        response.setToken(token);
        response.setExpiresIn(expiresIn);
        response.setUser(user);
        return response;
    }
} 