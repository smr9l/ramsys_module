package com.ramsys.users.dto;

import com.ramsys.common.dto.ReferenceDTO;
import lombok.Data;

@Data
public class UserDTO {
    private Long id;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private String title;
    private Boolean isActive;
    private RoleDTO role;
    private ReferenceDTO location;
    private ReferenceDTO division;
    private UserReferenceDTO manager;

} 