package com.ramsys.reference.api;

import com.ramsys.reference.dto.OccupancyDTO;
import com.ramsys.reference.dto.OccupancyGroupDTO;

import java.util.List;

public interface OccupancyApi {

    List<OccupancyGroupDTO> getAllOccupancyGroups();

    List<OccupancyDTO> getOccupanciesByGroup(Long groupId);

    List<OccupancyDTO> getAllOccupancies();

    OccupancyDTO getOccupancyById(Long id);
} 