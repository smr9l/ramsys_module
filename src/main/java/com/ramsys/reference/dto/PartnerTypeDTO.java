package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ramsys.common.dto.ReferenceDTO;
import lombok.*;

/**
 * DTO pour l'entité PartnerType
 * Étend ReferenceDTO pour les propriétés communes (id, code, label)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PartnerTypeDTO extends ReferenceDTO {
    
    // Propriétés spécifiques à PartnerType (i18n fields)
    private String name;
    private String nameFr;
    private String nameEn;
    private String nameAr;
    private Boolean isActive;
      @Override
    public String toString() {
        return "PartnerTypeDTO{id=" + getId() + ", code='" + getCode() + "', label='" + getLabel() + 
               "', name='" + name + "', isActive=" + isActive + "}";
    }
}
