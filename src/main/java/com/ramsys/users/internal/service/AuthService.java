package com.ramsys.users.internal.service;

import com.ramsys.common.security.JwtUtils;
import com.ramsys.users.dto.AuthResponse;
import com.ramsys.users.dto.LoginRequest;
import com.ramsys.users.dto.UserDTO;
import com.ramsys.users.internal.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final JwtUtils jwtUtils;
    private final UserService userService;
    private final UserMapper userMapper;

    public AuthResponse authenticate(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword())
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        UserDTO userDto = userService.findUserByUsername(loginRequest.getUsername());
        List<String> authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());

        Map<String, Object> claims = new java.util.HashMap<>();
        claims.put("userId", userDto.getId());
        if (userDto.getRole() != null) claims.put("role", userDto.getRole());
        if (userDto.getEmail() != null) claims.put("sub", userDto.getUsername());
        if (authorities != null) claims.put("authorities", authorities);
        if (userDto.getLocation() != null) claims.put("location", userDto.getLocation());

        String jwt = jwtUtils.generateToken(authentication.getName(), claims);
        String refreshToken = jwtUtils.generateRefreshToken(authentication.getName(), claims);
        AuthResponse response = AuthResponse.success(jwt, jwtUtils.getJwtExpirationMs());
        response.setRefreshToken(refreshToken);
        return response;
    }

    public AuthResponse refreshToken(String refreshToken) {
        // Le token a déjà été validé par Spring Security (Resource Server)
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        UserDTO userDto = userService.findUserByUsername(username);
        // Récupérer les claims personnalisés depuis l'Authentication si besoin
        List<String> authorities = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        Map<String, Object> claims = new java.util.HashMap<>();
        claims.put("userId", userDto.getId());
        if (userDto.getEmail() != null) claims.put("email", userDto.getEmail());
        if (authorities != null) claims.put("authorities", authorities);
        String newToken = jwtUtils.generateToken(username, claims);
        String newRefreshToken = jwtUtils.generateRefreshToken(username, claims);
        AuthResponse response = AuthResponse.success(newToken, jwtUtils.getJwtExpirationMs());
        response.setRefreshToken(newRefreshToken);
        return response;
    }

    public UserDTO getUserProfile(String username) {
        return userService.findUserByUsername(username);
    }
}
