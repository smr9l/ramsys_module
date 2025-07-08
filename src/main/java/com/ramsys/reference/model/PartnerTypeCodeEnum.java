package com.ramsys.reference.model;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public enum PartnerTypeCodeEnum {
    CEDANT("C"),
    BROKER("B"),
    OTHER("T");

    private final String code;

    PartnerTypeCodeEnum(String code) {
        this.code = code;
    }

    /**
     * Get the partner type code by partner type name (case-insensitive)
     *
     * @param partnerTypeName the partner type name
     * @return the corresponding PartnerTypeCode
     * @throws IllegalArgumentException if no matching type is found
     */
    public static PartnerTypeCodeEnum fromCode(String partnerTypCode) {
        for (PartnerTypeCodeEnum type : PartnerTypeCodeEnum.values()) {
            if (type.getCode().equalsIgnoreCase(partnerTypCode)) {
                return type;
            }
        }
        log.error("No matching PartnerTypeCode found for code: {}", partnerTypCode);
        throw new IllegalArgumentException("No matching PartnerTypeCode found for code: " + partnerTypCode);
    }

    public String getCode() {
        return code;
    }
}