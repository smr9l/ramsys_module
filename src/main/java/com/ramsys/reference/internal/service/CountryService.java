package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.exception.ReferenceNotFoundException;
import com.ramsys.common.i18n.MessageService;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.CountryDTO;
import com.ramsys.reference.internal.mapper.CountryMapper;
import com.ramsys.reference.internal.repository.CountryRepository;
import com.ramsys.reference.model.Country;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CountryService {
    private final CountryRepository countryRepository;
    private final CountryMapper countryMapper;
    private final LocalizedMapper localizedMapper;
    private final MessageService messageService;

    public List<ReferenceDTO> getAllCountriesAsReferenceDTO() {
        return localizedMapper.toDtoList(countryRepository.findAll());
    }

    public List<ReferenceDTO> getCountriesByRegionAsReferenceDTO(Long regionId) {
        return localizedMapper.toDtoList(countryRepository.findByRegionId(regionId));
    }

    /**
     * Récupère tous les pays sous forme de CountryDTO
     * @return Liste des pays en CountryDTO
     */
    @Cacheable("countries")
    public List<CountryDTO> getAllCountries() {
        List<Country> countries = countryRepository.findAll();
        return countryMapper.toDtoList(countries);
    }
    
    /**
     * Récupère un pays par son ID
     * @param id L'ID du pays
     * @return Le pays en CountryDTO
     */
    public CountryDTO getCountryById(Long id) {
        Country country = countryRepository.findById(id)
            .orElseThrow(() -> new ReferenceNotFoundException(
                messageService.getMessage("reference.country.notfound", id.toString())));
        return countryMapper.toDto(country);
    }

    /**
     * Récupère tous les pays d'une région sous forme de CountryDTO
     * @param regionId L'ID de la région
     * @return Liste des pays en CountryDTO
     */
    public List<CountryDTO> getCountriesByRegion(Long regionId) {
        List<Country> countries = countryRepository.findByRegionId(regionId);
        return countryMapper.toDtoList(countries);
    }
    

    public Optional<CountryDTO> getCountryByCode(String code) {
        return countryRepository.findByCode(code)
            .map(country -> countryMapper.toDto(country));
    }
    

    public boolean existsByCode(String code) {
        return countryRepository.existsByCode(code);
    }
}
