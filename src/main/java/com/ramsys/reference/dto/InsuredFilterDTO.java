package com.ramsys.reference.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO pour filtrer la liste des assurés
 */
@Data
@NoArgsConstructor
public class InsuredFilterDTO {
    
    private String searchTerm; // For name or short name
    private String type;
    private Long occupancyId;
    private Long countryId;
    private Long regionId;
    private Long cityId;
    private Long partnerId;
    private Boolean isActive;
} 