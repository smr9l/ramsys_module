package com.ramsys.users.web;

import com.ramsys.users.dto.AuthResponse;
import com.ramsys.users.dto.LoginRequest;
import com.ramsys.users.dto.UserDTO;
import com.ramsys.users.internal.service.AuthService;
import org.json.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;
import com.ramsys.config.SecurityConfig;

@WebMvcTest(AuthController.class)
@AutoConfigureMockMvc
@Import(SecurityConfig.class)
class AuthControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private AuthService authService;

    @MockBean
    private com.ramsys.common.i18n.MessageService messageService;

    @MockBean
    private org.springframework.security.core.userdetails.UserDetailsService userDetailsService;

    @MockBean
    private com.ramsys.common.security.JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

    @Test
    void authenticateUser_success() throws Exception {
        LoginRequest loginRequest = new LoginRequest("testuser", "password");
        AuthResponse authResponse = new AuthResponse("jwtToken", "Bearer", 3600L, "refreshToken");

        when(authService.authenticate(any(LoginRequest.class))).thenReturn(authResponse);

        JSONObject requestBody = new JSONObject();
        requestBody.put("username", "testuser");
        requestBody.put("password", "password");

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(requestBody.toString())
                        .with(SecurityMockMvcRequestPostProcessors.csrf())
                        .secure(true))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.token").value("jwtToken"))
                .andExpect(jsonPath("$.type").value("Bearer"))
                .andExpect(jsonPath("$.expiresIn").value(3600L))
                .andExpect(header().string("Set-Cookie", org.hamcrest.Matchers.containsString("refresh_token=refreshToken")));
    }

    @Test
    void authenticateUser_invalidCredentials() throws Exception {
        when(authService.authenticate(any(LoginRequest.class))).thenThrow(new org.springframework.security.authentication.BadCredentialsException("Invalid credentials"));

        JSONObject requestBody = new JSONObject();
        requestBody.put("username", "wronguser");
        requestBody.put("password", "wrongpass");

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(requestBody.toString())
                        .with(SecurityMockMvcRequestPostProcessors.csrf())
                        .secure(true))
                .andExpect(status().isUnauthorized());
    }

    @Test
    void refreshToken_success() throws Exception {
        AuthResponse authResponse = new AuthResponse("newJwtToken", "Bearer", 3600L, "newRefreshToken");

        when(authService.refreshToken(any(String.class))).thenReturn(authResponse);

        mockMvc.perform(post("/api/auth/refresh")
                        .cookie(new jakarta.servlet.http.Cookie("refresh_token", "oldRefreshToken"))
                        .with(SecurityMockMvcRequestPostProcessors.csrf())
                        .secure(true))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.token").value("newJwtToken"))
                .andExpect(header().string("Set-Cookie", org.hamcrest.Matchers.containsString("refresh_token=newRefreshToken")));
    }

    @Test
    void refreshToken_noCookie() throws Exception {
        mockMvc.perform(post("/api/auth/refresh")
                        .with(SecurityMockMvcRequestPostProcessors.csrf())
                        .secure(true))
                .andExpect(status().isBadRequest());
    }

    @Test
    void getCurrentUser_success() throws Exception {
        UserDTO userDTO = new UserDTO();
        userDTO.setUsername("testuser");
        userDTO.setEmail("test@example.com");

        when(authService.getUserProfile(any(String.class))).thenReturn(userDTO);

        mockMvc.perform(get("/api/auth/me")
                        .with(SecurityMockMvcRequestPostProcessors.user("testuser"))
                        .secure(true))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.username").value("testuser"))
                .andExpect(jsonPath("$.email").value("test@example.com"));
    }
}
