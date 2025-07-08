package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.*;

/**
 * DTO pour la création et la mise à jour d'un assuré
 */
@Value
@Builder
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CreateInsuredDTO {

    @NotBlank(message = "{insured.name.required}")
    @Size(max = 150, message = "{insured.name.maxlength}")
    private String name;

    @NotBlank(message = "{insured.shortname.required}")
    @Size(max = 40, message = "{insured.shortname.maxlength}")
    private String shortName;

    @Size(max = 40, message = "{field.maxlength}")
    private String type;

    private String comment;

    @Min(value = 1, message = "{insured.locations.min}")
    private Integer numberOfLocations;

    @NotNull(message = "{insured.occupancy.required}")
    private Long occupancyId;

    @NotNull(message = "{insured.region.required}")
    private Long regionId;

    @NotNull(message = "{insured.country.required}")
    private Long countryId;

    private Long cityId;

    private Long partnerId;

    @Valid
    private ContactInfoDto contactInfo;

    @Valid
    private AddressInfoDto addressInfo;

    @Builder.Default
    private Boolean active = true;
} 