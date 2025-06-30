package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.constraints.*;
import lombok.*;

/**
 * DTO pour la création d'un partenaire
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
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
    
    // Champs optionnels
    @Size(max = 5, message = "{field.maxlength}")
    private String contactGenre;
    
    @Size(max = 32, message = "{field.maxlength}")
    private String contactName;
    
    @Size(max = 32, message = "{field.maxlength}")
    private String typeOther;

    @Builder.Default
    private Boolean isReinsurer = false;
    @Builder.Default
    private Boolean isInwards = false;
    @Builder.Default
    private Boolean isOutwards = false;
    
    private String address;
    
    @Size(max = 4, message = "{field.maxlength}")
    private String rating;
    
    @Min(value = 0, message = "{field.minvalue}")
    @Max(value = 100, message = "{field.maxvalue}")
    private Integer scoring;
    
    @Pattern(regexp = "^[+]?[0-9\\s\\-().]+$", message = "{format.phone.invalid}")
    @Size(max = 20, message = "{field.maxlength}")
    private String telephone;
    
    @Pattern(regexp = "^[+]?[0-9\\s\\-().]+$", message = "{format.fax.invalid}")
    @Size(max = 20, message = "{field.maxlength}")
    private String fax;
    
    @Size(max = 32, message = "{field.maxlength}")
    private String prefixMail;
    
    @Size(max = 32, message = "{field.maxlength}")
    private String domaine;
    
    @Size(max = 100, message = "{field.maxlength}")
    private String bankName;
    
    @Pattern(regexp = "^[A-Z]{2}[0-9]{2}[A-Z0-9]{4}[0-9]{7}([A-Z0-9]?){0,16}$", 
             message = "{format.iban.invalid}")
    private String bankIban;
    
    @Size(max = 11, message = "{field.maxlength}")
    @Pattern(regexp = "^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$", message = "{format.swift.invalid}")
    private String swift;
    
    private String comment;
    
    private Long parentPartnerId;
    


} 
