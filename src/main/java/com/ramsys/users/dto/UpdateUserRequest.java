package com.ramsys.users.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateUserRequest {
    
    @Size(min = 3, max = 50, message = "Username must be between 3 and 50 characters")
    private String username;
    
    @Size(min = 6, message = "Password must be at least 6 characters")
    private String password;
    
    @Email(message = "Email must be valid")
    private String email;
    
    private String firstName;
    
    private String lastName;
    
    private String title;
    
    private String language;
    
    private String locale;
    
    private Long roleId;
    
    private Long locationId;
    
    private Long divisionId;
    
    private Long managerId;
    
    private Boolean isActive;
} 