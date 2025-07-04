package com.ramsys.users.web;

import com.ramsys.users.dto.AuthResponse;
import com.ramsys.users.dto.LoginRequest;
import com.ramsys.users.dto.UserDTO;
import com.ramsys.users.internal.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Authentication", description = "Authentication and authorization endpoints")
public class AuthController {

    private final AuthService authService;

    @Value("${app.security.cookie-secure:true}")
    private boolean cookieSecure;

    @Value("${app.jwt.refresh-expiration:604800}") // 7 jours par défaut
    private int refreshTokenExpiration;

    @PostMapping("/login")
    @Operation(
        summary = "Authenticate user",
        description = "Authenticate a user with username and password, returns JWT token on success"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "Authentication successful",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = AuthResponse.class, example = "{\n  'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',\n  'type': 'Bearer',\n  'expiresIn': 3600,\n  'refreshToken': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'\n}")
            )
        ),
        @ApiResponse(
            responseCode = "401",
            description = "Invalid credentials",
            content = @Content(
                mediaType = "application/json"
            )
        ),
        @ApiResponse(
            responseCode = "400",
            description = "Invalid request format",
            content = @Content(
                mediaType = "application/json"
            )
        )
    })
    public ResponseEntity<AuthResponse> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {
        AuthResponse authResponse = authService.authenticate(loginRequest);
        // Place le refresh token dans un cookie sécurisé
        ResponseCookie refreshCookie = ResponseCookie.from("refresh_token", authResponse.getRefreshToken())
                .httpOnly(true)
                .secure(cookieSecure)
                .path("/api/auth/refresh")
                .maxAge(refreshTokenExpiration)
                .sameSite("Strict")
                .build();
        // Ne renvoie que le JWT d'accès dans le corps
        authResponse.setRefreshToken(null);
        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, refreshCookie.toString())
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + authResponse.getToken())
                .body(authResponse);
    }

    @PostMapping("/refresh")
    @Operation(
        summary = "Refresh JWT token",
        description = "Refresh the JWT token using a valid existing token"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "Token refreshed successfully",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = AuthResponse.class)
            )
        ),
        @ApiResponse(
            responseCode = "400",
            description = "Invalid token",
            content = @Content(mediaType = "application/json",
                schema = @Schema(implementation = com.ramsys.common.exception.ErrorResponse.class))
        )
    })
    public ResponseEntity<AuthResponse> refreshToken(@CookieValue(name = "refresh_token", required = false) String refreshToken) {
        if (refreshToken == null || refreshToken.isBlank()) {
            return ResponseEntity.badRequest().build();
        }
        AuthResponse authResponse = authService.refreshToken(refreshToken);
        // Rafraîchir le cookie refresh_token
        ResponseCookie refreshCookie = ResponseCookie.from("refresh_token", authResponse.getRefreshToken())
                .httpOnly(true)
                .secure(cookieSecure)
                .path("/api/auth/refresh")
                .maxAge(refreshTokenExpiration)
                .sameSite("Strict")
                .build();
        authResponse.setRefreshToken(null);
        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, refreshCookie.toString())
                .body(authResponse);
    }

    @Operation(
        summary = "Get current user profile",
        description = "Retourne le profil complet de l'utilisateur authentifié (UserDTO)"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "Profil utilisateur retourné avec succès",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = UserDTO.class)
            )
        ),
        @ApiResponse(
            responseCode = "401",
            description = "Non authentifié"
        )
    })
    @GetMapping("/me")
    public ResponseEntity<UserDTO> getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        UserDTO userDto = authService.getUserProfile(username);
        return ResponseEntity.ok(userDto);
    }
}
