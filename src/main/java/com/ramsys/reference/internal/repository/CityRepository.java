package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.City;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CityRepository extends JpaRepository<City, Long> {
    
    /**
     * Récupère toutes les villes d'un pays
     * @param countryId L'ID du pays
     * @return Liste des villes du pays
     */
    List<City> findByCountryId(Long countryId);

    List<City> findByCountryCode(String countryCode);
}
    
