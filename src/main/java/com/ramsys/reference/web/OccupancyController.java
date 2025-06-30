package com.ramsys.reference.web;

import com.ramsys.common.i18n.MessageService;
import com.ramsys.reference.api.OccupancyApi;
import com.ramsys.reference.dto.OccupancyDTO;
import com.ramsys.reference.dto.OccupancyGroupDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference")
@RequiredArgsConstructor
public class OccupancyController {

    private final OccupancyApi occupancyApi;
    private final  MessageService messageSource;

    @GetMapping("/occupancy-groups")
    public List<OccupancyGroupDTO> getAllOccupancyGroups() {
        return occupancyApi.getAllOccupancyGroups();
    }

    @GetMapping("/occupancy-groups/{groupId}/occupancies")
    public List<OccupancyDTO> getOccupanciesByGroup(
        @PathVariable Long groupId
    ) {
        return occupancyApi.getOccupanciesByGroup(groupId);
    }

    @GetMapping("/occupancies")
    public List<OccupancyDTO> getAllOccupancies() {
        return occupancyApi.getAllOccupancies();
    }


    @GetMapping("/occupancies/{id}")
    public OccupancyDTO getOccupancy(@PathVariable Long id) {
        return occupancyApi.getOccupancyById(id);

    }
} 
