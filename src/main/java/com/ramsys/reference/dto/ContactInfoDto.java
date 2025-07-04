package com.ramsys.reference.dto;

import jakarta.validation.constraints.Size;

import java.io.Serializable;

/**
 * DTO for {@link com.ramsys.reference.model.embedded.ContactInfo}
 */
public record ContactInfoDto(
    @Size(max = 5) String genre,
    @Size(max = 32) String name,
    @Size(max = 20) String telephone,
    @Size(max = 20) String fax,
    @Size(max = 32) String emailPrefix,
    @Size(max = 32) String emailDomain
) implements Serializable {
}