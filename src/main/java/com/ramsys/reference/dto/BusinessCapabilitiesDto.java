package com.ramsys.reference.dto;

import jakarta.validation.constraints.Size;
import java.io.Serializable;

/**
 * DTO for {@link com.ramsys.reference.model.embedded.BusinessCapabilities}
 */
public record BusinessCapabilitiesDto(
    @Size(max = 100) String capabilityName,
    @Size(max = 255) String description
) implements Serializable {
}

