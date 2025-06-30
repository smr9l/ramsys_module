package com.ramsys.users.dto;

import com.ramsys.common.dto.ReferenceDTO;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthenticatedUserDTO {
    private Long userId;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private Boolean isActive;
    
    // Enriched data
    private RoleDTO role;
    private ReferenceDTO location;
    private ReferenceDTO division;
    private UserReferenceDTO manager;
} 