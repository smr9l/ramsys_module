package com.ramsys.users.web;

import com.ramsys.users.api.UserManagement;
import com.ramsys.users.dto.CreateUserRequest;
import com.ramsys.users.dto.UpdateUserRequest;
import com.ramsys.users.dto.UserDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

/**
 * REST Controller for User Management.
 * 
 * <p>This controller provides HTTP endpoints for user management operations.
 * It's part of the public web API of the Users module.</p>
 */
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@Tag(name = "User Management", description = "User management and profile endpoints")
@SecurityRequirement(name = "bearerAuth")
public class UserController {

    private final UserManagement userManagement;

    /**
     * Get a user by ID
     * 
     * @param id the user ID
     * @return the user DTO if found
     */
    @GetMapping("/{id}")
    @Operation(
        summary = "Get user by ID",
        description = "Retrieve a specific user by their unique identifier"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "User found",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = UserDTO.class)
            )
        ),
        @ApiResponse(
            responseCode = "404",
            description = "User not found"
        ),
        @ApiResponse(
            responseCode = "403",
            description = "Access denied"
        )
    })
    public ResponseEntity<UserDTO> getUserById(
        @Parameter(description = "User ID") @PathVariable Long id
    ) {
        Optional<UserDTO> user = userManagement.findUserById(id);
        return user.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    /**
     * Get all users with pagination
     * 
     * @param pageable pagination information
     * @return a page of user DTOs
     */
    @GetMapping
    @Operation(
        summary = "Get all users",
        description = "Retrieve a paginated list of all users in the system"
    )
    @ApiResponse(
        responseCode = "200",
        description = "Users retrieved successfully",
        content = @Content(
            mediaType = "application/json",
            schema = @Schema(implementation = Page.class)
        )
    )
    public Page<UserDTO> getAllUsers(
        @Parameter(description = "Pagination information") Pageable pageable
    ) {
        return userManagement.findAllUsers(pageable);
    }

    /**
     * Deactivate a user
     * 
     * @param id the user ID
     * @return no content response
     */
    @DeleteMapping("/{id}")
    @Operation(
        summary = "Deactivate user",
        description = "Deactivate a user account (soft delete)"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "204",
            description = "User deactivated successfully"
        ),
        @ApiResponse(
            responseCode = "404",
            description = "User not found"
        ),
        @ApiResponse(
            responseCode = "403",
            description = "Access denied"
        )
    })
    public ResponseEntity<Void> deactivateUser(
        @Parameter(description = "User ID") @PathVariable Long id
    ) {
        userManagement.deactivateUser(id);
        return ResponseEntity.noContent().build();
    }
}
