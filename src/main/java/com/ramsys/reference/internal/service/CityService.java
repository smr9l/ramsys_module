package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.internal.repository.CityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CityService {
    private final CityRepository cityRepository;
    private final LocalizedMapper localizedMapper;

    /**
     * Récupère toutes les villes d'un pays sous forme de ReferenceDTO
     * @param countryId L'ID du pays
     * @return Liste des villes en ReferenceDTO
     */
    public List<ReferenceDTO> getCitiesByCountryAsReferenceDTO(Long countryId) {
        return localizedMapper.toDtoList(cityRepository.findByCountryId(countryId));
    }

    public List<ReferenceDTO> getCitiesByCountryCode(String countryCode) {
        return localizedMapper.toDtoList(cityRepository.findByCountryCode(countryCode));
    }
} 
