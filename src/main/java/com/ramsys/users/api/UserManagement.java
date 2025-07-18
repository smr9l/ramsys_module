package com.ramsys.users.api;

import com.ramsys.users.dto.CreateUserRequest;
import com.ramsys.users.dto.UpdateUserRequest;
import com.ramsys.users.dto.UserDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Public API for the User Management module.
 */

public interface UserManagement {    /**

    /**
     * Finds a user by their ID.
     * @param id The user ID.
     * @return An optional containing the user DTO if found.
     */
    Optional<UserDTO> findUserById(Long id);

    /**
     * Finds all users with pagination.
     * @param pageable Pagination information.
     * @return A page of user DTOs.
     */
    Page<UserDTO> findAllUsers(Pageable pageable);

    /**
     * Deactivates a user.
     * @param id The ID of the user to deactivate.
     */
    void deactivateUser(Long id);
} 