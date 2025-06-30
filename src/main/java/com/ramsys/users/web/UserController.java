package com.ramsys.users.web;

import com.ramsys.users.api.UserManagement;
import com.ramsys.users.dto.CreateUserRequest;
import com.ramsys.users.dto.UpdateUserRequest;
import com.ramsys.users.dto.UserDTO;
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
public class UserController {

    private final UserManagement userManagement;




    /**
     * Get a user by ID
     * 
     * @param id the user ID
     * @return the user DTO if found
     */
    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Long id) {
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
    public Page<UserDTO> getAllUsers(Pageable pageable) {
        return userManagement.findAllUsers(pageable);
    }

    /**
     * Deactivate a user
     * 
     * @param id the user ID
     * @return no content response
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deactivateUser(@PathVariable Long id) {
        userManagement.deactivateUser(id);
        return ResponseEntity.noContent().build();
    }
}
