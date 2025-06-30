package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ramsys.common.dto.ReferenceDTO;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

/**
 * DTO pour les types de fonction
 * Étend ReferenceDTO pour les propriétés communes (id, code, label)
 */
@Data
@SuperBuilder
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class FunctionTypeDTO extends ReferenceDTO {
    
    // Les propriétés communes (id, code, label) sont héritées de ReferenceDTO
    // Aucune propriété spécifique n'est nécessaire pour FunctionType
} 