package com.ramsys.reference.dto;

import com.ramsys.common.dto.ReferenceDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.util.List;

/**
 * Data Transfer Object for Function.
 * Extends ReferenceDTO to include function-specific details.
 */
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class FunctionDTO extends ReferenceDTO {

    private String description;
    private FunctionTypeDTO functionType;
    private String category; // e.g., "MANDATORY", "OPTIONAL"
    private Integer sequenceInGroup;
    private ReferenceDTO requiredFunctionType;
    
    @Override
    public String toString() {
        return "FunctionDTO{" +
                "id=" + getId() +
                ", code='" + getCode() + '\'' +
                ", label='" + getLabel() + '\'' +
                ", description='" + description + '\'' +
                ", functionType=" + (functionType != null ? functionType.getCode() : "null") +
                '}';
    }
} 