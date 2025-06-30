package com.ramsys.reference.web;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.GeographicApi;
import com.ramsys.reference.dto.CountryDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference")
@RequiredArgsConstructor
public class CountryController {

    private final GeographicApi geographicApi;

    @GetMapping("/countries")
    public List<ReferenceDTO> getAllCountries() {
        return geographicApi.getAllCountries();
    }
    
    @GetMapping("/countries/{id}")
    public ResponseEntity<CountryDTO> getCountryById(@PathVariable Long id) {
        return ResponseEntity.of(geographicApi.getCountryById(id));
    }

    @GetMapping("/regions/{regionId}/countries")
    public List<ReferenceDTO> getCountriesByRegion(@PathVariable Long regionId) {
        return geographicApi.getCountriesByRegion(regionId);
    }
} 
