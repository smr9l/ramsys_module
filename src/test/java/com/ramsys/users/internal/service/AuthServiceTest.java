package com.ramsys.users.internal.service;

import com.ramsys.common.security.JwtUtils;
import com.ramsys.users.dto.AuthResponse;
import com.ramsys.users.dto.LoginRequest;
import com.ramsys.users.dto.UserDTO;
import com.ramsys.users.internal.mapper.UserMapper;
import com.ramsys.users.internal.model.Role;
import com.ramsys.users.internal.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import com.ramsys.users.dto.RoleDTO;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyMap;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.lenient;

@ExtendWith(MockitoExtension.class)
class AuthServiceTest {

    @Mock
    private AuthenticationManager authenticationManager;

    @Mock
    private JwtUtils jwtUtils;

    @Mock
    private UserService userService;

    @Mock
    private UserMapper userMapper;

    @InjectMocks
    private AuthService authService;

    private LoginRequest loginRequest;
    private Authentication authentication;
    private UserDTO userDTO;
    private User user;

    @BeforeEach
    void setUp() {
        loginRequest = new LoginRequest("testuser", "password");

        userDTO = new UserDTO();
        userDTO.setId(1L);
        userDTO.setUsername("testuser");
        userDTO.setEmail("test@example.com");
        userDTO.setRole(RoleDTO.builder().code("ADMIN").build());

        user = new User();
        user.setId(1L);
        user.setUsername("testuser");
        user.setEmail("test@example.com");
        Role role = new Role();
        role.setCode("ADMIN");
        user.setRole(role);

        authentication = new UsernamePasswordAuthenticationToken(
                "testuser", "password", Collections.singleton(new SimpleGrantedAuthority("ROLE_ADMIN")));
    }

    @Test
    void authenticate_success() {
        lenient().when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class)))
                .thenReturn(authentication);
        when(userService.findUserByUsername(anyString())).thenReturn(userDTO);
        when(jwtUtils.generateToken(anyString(), anyMap())).thenReturn("mockJwtToken");
        when(jwtUtils.generateRefreshToken(anyString(), anyMap())).thenReturn("mockRefreshToken");
        when(jwtUtils.getJwtExpirationMs()).thenReturn(3600000L);

        AuthResponse response = authService.authenticate(loginRequest);

        assertNotNull(response);
        assertEquals("mockJwtToken", response.getToken());
        assertEquals("mockRefreshToken", response.getRefreshToken());
        assertEquals(3600000L, response.getExpiresIn());
        assertEquals("Bearer", response.getType());
    }

    @Test
    void refreshToken_success() {
        when(jwtUtils.generateToken(anyString(), anyMap())).thenReturn("newMockJwtToken");
        when(jwtUtils.generateRefreshToken(anyString(), anyMap())).thenReturn("newMockRefreshToken");
        when(jwtUtils.getJwtExpirationMs()).thenReturn(3600000L);
        when(userService.findUserByUsername(anyString())).thenReturn(userDTO);

        // Mock SecurityContextHolder for refreshToken method
        lenient().when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class)))
                .thenReturn(authentication);
        org.springframework.security.core.context.SecurityContextHolder.getContext().setAuthentication(authentication);

        AuthResponse response = authService.refreshToken("oldRefreshToken");

        assertNotNull(response);
        assertEquals("newMockJwtToken", response.getToken());
        assertEquals("newMockRefreshToken", response.getRefreshToken());
        assertEquals(3600000L, response.getExpiresIn());
        assertEquals("Bearer", response.getType());
    }

    @Test
    void getUserProfile_success() {
        when(userService.findUserByUsername(anyString())).thenReturn(userDTO);

        UserDTO result = authService.getUserProfile("testuser");

        assertNotNull(result);
        assertEquals("testuser", result.getUsername());
        assertEquals("test@example.com", result.getEmail());
    }
}
