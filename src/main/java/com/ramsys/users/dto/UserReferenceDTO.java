package com.ramsys.users.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Simplified DTO for a user reference, typically for a manager.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserReferenceDTO {
    private Long id;
    private String username;
    private String fullName;
} 