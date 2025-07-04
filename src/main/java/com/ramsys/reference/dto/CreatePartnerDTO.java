package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.*;

/**
 * DTO pour la création d'un partenaire
 */
@Value
@Builder
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CreatePartnerDTO {

    @NotBlank(message = "{partner.name.required}")
    @Size(max = 100, message = "{partner.name.maxlength}")
    private String name;

    @NotBlank(message = "{partner.shortname.required}")
    @Size(max = 32, message = "{partner.shortname.maxlength}")
    private String shortName;

    @NotNull(message = "{partner.partnertype.required}")
    private Long partnerTypeId;

    @NotNull(message = "{partner.region.required}")
    private Long regionId;

    @NotNull(message = "{partner.country.required}")
    private Long countryId;

    @NotNull(message = "{partner.currency.required}")
    private Long currencyId;

    @Size(max = 32, message = "{field.maxlength}")
    private String typeOther;

    @Builder.Default
    private Boolean isReinsurer = false;
    @Builder.Default
    private Boolean isInwards = false;
    @Builder.Default
    private Boolean isOutwards = false;

    @Valid
    private ContactInfoDto contactInfo;

    @Valid
    private AddressInfoDto addressInfo;

    @Valid
    private FinancialInfoDto financialInfo;

    private String comment;

    private Long parentPartnerId;

    @Builder.Default
    private Boolean active = true; // Changé de isActive vers active
}
