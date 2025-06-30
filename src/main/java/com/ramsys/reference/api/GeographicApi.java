package com.ramsys.reference.api;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.dto.CountryDTO;

import java.util.List;
import java.util.Optional;

/**
 * Public API for Geographic Reference Data.
 */
public interface GeographicApi {

    /**
     * Récupère toutes les régions
     */
    List<ReferenceDTO> getAllRegions();

    /**
     * Récupère tous les pays
     */
    List<ReferenceDTO> getAllCountries();

    /**
     * Récupère un pays par son ID
     */
    Optional<CountryDTO> getCountryById(Long id);

    /**
     * Récupère un pays par son code ISO (ex : "US", "FR", "MA")
     */
    Optional<CountryDTO> getCountryByCode(String code);

    /**
     * Récupère les pays d'une région
     */
    List<ReferenceDTO> getCountriesByRegion(Long regionId);

    /**
     * Récupère les villes d'un pays
     */
    List<ReferenceDTO> getCitiesByCountry(Long countryId);

    /**
     * Récupère les villes d'un pays par son code pays
     */
    List<ReferenceDTO> getCitiesByCountryCode(String countryCode);
} 