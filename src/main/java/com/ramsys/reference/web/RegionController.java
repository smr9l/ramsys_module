package com.ramsys.reference.web;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.GeographicApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/reference")
@RequiredArgsConstructor
public class RegionController {

    private final GeographicApi geographicApi;

    @GetMapping("/regions")
    public List<ReferenceDTO> getAllRegions() {
        return geographicApi.getAllRegions();
    }
} 
