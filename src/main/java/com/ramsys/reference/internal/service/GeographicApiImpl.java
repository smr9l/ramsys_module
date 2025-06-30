package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.GeographicApi;
import com.ramsys.reference.dto.CountryDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
class GeographicApiImpl implements GeographicApi {

    private final RegionService regionService;
    private final CountryService countryService;
    private final CityService cityService;

    @Override
    public List<ReferenceDTO> getAllRegions() {
        return regionService.getAllRegionsAsReferenceDTO();
    }

    @Override
    public List<ReferenceDTO> getAllCountries() {
        return countryService.getAllCountriesAsReferenceDTO();
    }

    @Override
    public Optional<CountryDTO> getCountryById(Long id) {
        return Optional.ofNullable(countryService.getCountryById(id));
    }

    @Override
    public Optional<CountryDTO> getCountryByCode(String code) {
        return countryService.getCountryByCode(code);
    }

    @Override
    public List<ReferenceDTO> getCountriesByRegion(Long regionId) {
        return countryService.getCountriesByRegionAsReferenceDTO(regionId);
    }

    @Override
    public List<ReferenceDTO> getCitiesByCountry(Long countryId) {
        return cityService.getCitiesByCountryAsReferenceDTO(countryId);
    }

    @Override
    public List<ReferenceDTO> getCitiesByCountryCode(String countryCode) {
        return cityService.getCitiesByCountryCode(countryCode);
    }
} 