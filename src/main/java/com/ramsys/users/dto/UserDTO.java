package com.ramsys.users.dto;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.dto.LocationDTO;
import com.ramsys.reference.dto.DivisionDTO;
import lombok.Data;

import java.time.LocalDateTime;

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