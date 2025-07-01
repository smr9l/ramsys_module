package com.ramsys.users.internal.service;

import com.ramsys.common.security.JwtUtils;
import com.ramsys.users.dto.AuthResponse;
import com.ramsys.users.dto.AuthenticatedUserDTO;
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

        Map<String, Object> claims = Map.of(
                "userId", userDto.getId(),
                "email", userDto.getEmail(),
                "authorities", authorities
        );

        String jwt = jwtUtils.generateToken(authentication.getName(), claims);

        AuthenticatedUserDTO authenticatedUser = toAuthenticatedUserDTO(userDto);

        return AuthResponse.success(jwt, jwtUtils.getJwtExpirationMs(), authenticatedUser);
    }

    public AuthResponse refreshToken(String oldToken) {
        // Remove Bearer prefix if present
        String token = oldToken != null && oldToken.startsWith("Bearer ") ? oldToken.substring(7) : oldToken;

        if (!jwtUtils.validateJwtToken(token)) {
            throw new IllegalArgumentException("Invalid JWT token");
        }

        String username = jwtUtils.getUserNameFromJwtToken(token);
        UserDTO userDto = userService.findUserByUsername(username);

        // Copy custom claims from old token (excluding standard ones)
        var oldClaims = jwtUtils.getAllClaimsFromJwtToken(token);
        Map<String, Object> claims = oldClaims.entrySet().stream()
                .filter(e -> !List.of("sub", "iat", "exp", "nbf", "jti").contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

        String newToken = jwtUtils.generateToken(username, claims);

        AuthenticatedUserDTO authenticatedUser = toAuthenticatedUserDTO(userDto);
        return AuthResponse.success(newToken, jwtUtils.getJwtExpirationMs(), authenticatedUser);
    }

    private AuthenticatedUserDTO toAuthenticatedUserDTO(UserDTO userDto) {
        return AuthenticatedUserDTO.builder()
                .userId(userDto.getId())
                .username(userDto.getUsername())
                .email(userDto.getEmail())
                .firstName(userDto.getFirstName())
                .lastName(userDto.getLastName())
                .isActive(userDto.getIsActive())
                .role(userDto.getRole())
                .location(userDto.getLocation())
                .division(userDto.getDivision())
                .manager(userDto.getManager())
                .build();
    }
} 