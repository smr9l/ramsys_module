// Create new file: /ramsys-reference/src/main/java/com/ramsys/reference/dto/PartnerFilterDTO.java
package com.ramsys.reference.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PartnerFilterDTO {
    private String searchTerm; // For name or code
    private Long partnerTypeId;
    private Long countryId;
    private Long regionId;
    private Boolean isActive;
}