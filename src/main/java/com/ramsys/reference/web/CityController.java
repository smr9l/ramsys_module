package com.ramsys.reference.web;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.GeographicApi;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference")
@RequiredArgsConstructor
public class CityController {

    private final GeographicApi geographicApi;

    @GetMapping("/countries/{countryId}/cities")
    public List<ReferenceDTO> getCitiesByCountry(@PathVariable Long countryId) {
        return geographicApi.getCitiesByCountry(countryId);
    }

    @GetMapping("/countries/code/{countryCode}/cities")
    public List<ReferenceDTO> getCitiesByCountryCode(@PathVariable String countryCode) {
        return geographicApi.getCitiesByCountryCode(countryCode);
    }
} 
