package com.ramsys.users.internal.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ramsys.common.security.JwtTokenProvider;
import com.ramsys.users.dto.AuthResponse;
import com.ramsys.users.dto.AuthenticatedUserDTO;
import com.ramsys.users.dto.LoginRequest;
import com.ramsys.users.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;
    private final UserService userService;
    private final ObjectMapper objectMapper;


    public AuthResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        UserDTO userDTO = userService.findUserByUsername(loginRequest.getUsername());
        
        // Build the claims map for the JWT
        Map<String, Object> claims = buildClaims(userDTO, authentication.getAuthorities());

        String jwt = jwtTokenProvider.generateToken(authentication.getName(), claims);

        AuthenticatedUserDTO authenticatedUserDTO = AuthenticatedUserDTO.builder()
                .userId(userDTO.getId())
                .username(userDTO.getUsername())
                .email(userDTO.getEmail())
                .firstName(userDTO.getFirstName())
                .lastName(userDTO.getLastName())
                .isActive(userDTO.getIsActive())
                .role(userDTO.getRole())
                .location(userDTO.getLocation())
                .division(userDTO.getDivision())
                .manager(userDTO.getManager())
                .build();

        return AuthResponse.success(jwt, jwtTokenProvider.getExpirationMs(), authenticatedUserDTO);
    }

    private Map<String, Object> buildClaims(UserDTO user, Collection<? extends GrantedAuthority> authorities) {
        List<String> authoritiesList = authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());

        Map<String, Object> claims = objectMapper.convertValue(user, Map.class);
        claims.put("authorities", authoritiesList);
        
        // Remove sensitive or unnecessary data from claims
        claims.remove("password"); 
        claims.remove("createdAt");
        claims.remove("createdBy");
        claims.remove("updatedAt");
        claims.remove("updatedBy");

        return claims;
    }
} 