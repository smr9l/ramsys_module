package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ramsys.common.dto.ReferenceDTO;
import lombok.Data;
import lombok.experimental.SuperBuilder;
import lombok.EqualsAndHashCode;

/**
 * DTO pour les groupes
 * Étend ReferenceDTO pour les propriétés communes (id, code, label)
 */
@Data
@SuperBuilder
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GroupDTO extends ReferenceDTO {
    // Les propriétés communes (id, code, label) sont héritées de ReferenceDTO
    // Aucune propriété spécifique n'est nécessaire pour Group
}
