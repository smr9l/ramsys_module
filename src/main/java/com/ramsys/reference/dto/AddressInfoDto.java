package com.ramsys.reference.dto;

import jakarta.validation.constraints.Size;
import java.io.Serializable;

/**
 * DTO for {@link com.ramsys.reference.model.embedded.AddressInfo}
 */
public record AddressInfoDto(
    String fullAddress,
    @Size(max = 40, message = "{field.maxlength}") String area,
    @Size(max = 40, message = "{field.maxlength}") String road,
    @Size(max = 40, message = "{field.maxlength}") String building,
    @Size(max = 40, message = "{field.maxlength}") String flat,
    @Size(max = 12, message = "{field.maxlength}") String gpsCode
) implements Serializable {
}
