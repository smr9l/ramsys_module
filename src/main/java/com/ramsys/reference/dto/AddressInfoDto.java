package com.ramsys.reference.dto;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Size;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * DTO for {@link com.ramsys.reference.model.embedded.AddressInfo}
 */
public record AddressInfoDto(
        String fullAddress,
        @Size(max = 40, message = "{field.maxlength}") String area,
        @Size(max = 40, message = "{field.maxlength}") String road,
        @Size(max = 40, message = "{field.maxlength}") String building,
        @Size(max = 40, message = "{field.maxlength}") String flat,

        @DecimalMin(value = "-90.0", message = "Latitude must be between -90 and 90")
        @DecimalMax(value = "90.0", message = "Latitude must be between -90 and 90")
        @Digits(integer = 2, fraction = 8, message = "Latitude format is invalid")
        BigDecimal latitude,

        @DecimalMin(value = "-180.0", message = "Longitude must be between -180 and 180")
        @DecimalMax(value = "180.0", message = "Longitude must be between -180 and 180")
        @Digits(integer = 3, fraction = 8, message = "Longitude format is invalid")
        BigDecimal longitude
) implements Serializable {


}
