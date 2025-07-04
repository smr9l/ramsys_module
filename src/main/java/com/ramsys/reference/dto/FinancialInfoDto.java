package com.ramsys.reference.dto;

import jakarta.validation.constraints.Size;
import java.io.Serializable;

/**
 * DTO for {@link com.ramsys.reference.model.embedded.FinancialInfo}
 */
public record FinancialInfoDto(
    @Size(max = 4, message = "{field.maxlength}") String rating,
    Integer scoring,
    @Size(max = 100, message = "{field.maxlength}") String bankName,
    @Size(max = 30, message = "{field.maxlength}") String bankIban,
    @Size(max = 10, message = "{field.maxlength}") String swiftCode
) implements Serializable {
}
