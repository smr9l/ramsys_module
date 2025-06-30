package com.ramsys.users.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ramsys.common.dto.ReferenceDTO;
import lombok.Data;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.experimental.SuperBuilder;

/**
 * DTO pour les rôles
 * Étend ReferenceDTO pour les propriétés communes (id, code, label)
 */
@Data
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
@EqualsAndHashCode
public class RoleDTO extends ReferenceDTO {
    
    // Les propriétés communes (id, code, label) sont héritées de ReferenceDTO
    // Aucune propriété spécifique n'est nécessaire pour Role
} 