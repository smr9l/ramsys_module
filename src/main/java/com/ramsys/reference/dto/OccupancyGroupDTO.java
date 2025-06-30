package com.ramsys.reference.dto;

import com.ramsys.common.dto.ReferenceDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;

@Data
@SuperBuilder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
public class OccupancyGroupDTO extends ReferenceDTO {
    private Long id;
    private String code;
    private String name;
    private List<OccupancyDTO> occupancies;
} 