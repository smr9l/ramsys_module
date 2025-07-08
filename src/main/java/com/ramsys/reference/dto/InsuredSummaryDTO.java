package com.ramsys.reference.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

/**
 * DTO résumé pour l'affichage des assurés dans les listes et dropdowns
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class InsuredSummaryDTO {
    
    private Long id;
    private String name;
    private String shortName;
    private String type;
    private String occupancyName;
    private String countryName;
    private Boolean active;
    
    public InsuredSummaryDTO(Long id, String name, String shortName) {
        this.id = id;
        this.name = name;
        this.shortName = shortName;
        this.active = true;
    }
} 