package com.ramsys.reference.dto;

import com.ramsys.common.dto.ReferenceDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@SuperBuilder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class ArrangementTypeDTO extends ReferenceDTO {

    private ReferenceDTO businessType;
    private ReferenceDTO contractType;
}
