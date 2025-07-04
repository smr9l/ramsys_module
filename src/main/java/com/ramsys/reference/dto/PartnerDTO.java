package com.ramsys.reference.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.ramsys.common.dto.ReferenceDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * DTO pour les partenaires
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PartnerDTO {
    
    private Long id;
    private String code;
    private String name;
    private String shortName;
    private ReferenceDTO partnerType;
    private Boolean isReinsurer;
    private Boolean isInwards;
    private Boolean isOutwards;
    private ReferenceDTO region;
    private ReferenceDTO country;
    private ReferenceDTO currency;
    private String rating;
    private Boolean active;  // Changé de isActive vers active
    private String comment;
    private ContactInfoDto contactInfo;
    private AddressInfoDto addressInfo;
    private FinancialInfoDto financialInfo;
    private PartnerSummaryDto parentPartner;
     private String otherType;

    @Override
    public String toString() {
        return "PartnerDTO{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", partnerType=" + partnerType +
                ", isReinsurer=" + isReinsurer +
                '}';
    }
}
