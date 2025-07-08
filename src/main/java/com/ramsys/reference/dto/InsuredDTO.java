package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ramsys.common.dto.ReferenceDTO;
import lombok.*;

/**
 * DTO pour l'affichage des informations d'un assuré
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InsuredDTO {
    
    private Long id;
    private String name;
    private String shortName;
    private String type;
    private String comment;
    private Integer numberOfLocations;
    private Boolean active;
    
    // Relations
    private ReferenceDTO occupancy;
    private ReferenceDTO region;
    private ReferenceDTO country;
    private ReferenceDTO city;
    private PartnerSummaryDto partner;
    
    // Embedded objects
    private ContactInfoDto contactInfo;
    private AddressInfoDto addressInfo;
    
    @Override
    public String toString() {
        return "InsuredDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", shortName='" + shortName + '\'' +
                ", type='" + type + '\'' +
                ", active=" + active +
                '}';
    }
} 