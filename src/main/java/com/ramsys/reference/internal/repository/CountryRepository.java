package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.Country;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CountryRepository extends JpaRepository<Country, Long> {
    
    /**
     * Récupère tous les pays d'une région
     * @param regionId L'ID de la région
     * @return Liste des pays de la région
     */
    List<Country> findByRegionId(Long regionId);
    
    /**
     * Find country by ISO code
     * @param code the country ISO code (e.g., "US", "FR", "MA")
     * @return Optional country
     */
    Optional<Country> findByCode(String code);
    
    /**
     * Check if country exists by code
     * @param code the country ISO code
     * @return true if exists
     */
    boolean existsByCode(String code);
    
    /**
     * Find active countries by region
     * @param regionId the region ID
     * @return List of active countries
     */
    List<Country> findByRegionIdAndIsActiveTrue(Long regionId);
}
