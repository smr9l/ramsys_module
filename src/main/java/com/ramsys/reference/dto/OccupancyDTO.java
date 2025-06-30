package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ramsys.common.dto.ReferenceDTO;
import lombok.*;
import lombok.experimental.SuperBuilder;

/**
 * DTO pour l'entité Occupancy
 * Étend ReferenceDTO pour les propriétés communes (id, code, label)
 */
@Getter
@Setter
@SuperBuilder
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OccupancyDTO extends ReferenceDTO {
    
    private ReferenceDTO group;

} 
