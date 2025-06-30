package com.ramsys.reference.dto;

import com.ramsys.common.dto.ReferenceDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@SuperBuilder
public class LocationDTO extends ReferenceDTO {
    private ReferenceDTO partner;

    private ReferenceDTO city;

    private ReferenceDTO currency;
    private ReferenceDTO accountingPeriod;
    private Boolean isActive;
} 