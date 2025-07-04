package com.ramsys.common.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;

/**
 * DTO générique pour toutes les entités de référence
 * Utilisé pour standardiser les réponses des services de référence
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder(toBuilder = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReferenceDTO  implements Serializable {
    
    private Long id;
    private String code;
    private String label;
    private boolean active;


    @Override
    public String toString() {
        return "ReferenceDTO{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", label='" + label + '\'' +
                '}';
    }
} 