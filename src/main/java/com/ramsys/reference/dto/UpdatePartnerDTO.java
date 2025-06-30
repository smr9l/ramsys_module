package com.ramsys.reference.dto;

/**
 * DTO for Update Partner operations.
 */
public record UpdatePartnerDTO(
    String name,
    String shortName,
    String description,
    String descriptionFr,
    String descriptionEn,
    String descriptionAr,
    Long partnerTypeId,
    Long countryId,
    Long regionId,
    Long currencyId,
    Boolean isReinsurer,
    Boolean isInwards,
    Boolean isOutwards,
    String contactEmail,
    String contactPhone,
    String contactAddress,
    String website,
    String taxNumber,
    String registrationNumber
) {}
