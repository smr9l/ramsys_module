package com.ramsys.reference.internal.repository;

import com.ramsys.common.repository.BaseRepository;
import com.ramsys.reference.model.Insured;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository pour l'entité Insured
 */
@Repository
public interface InsuredRepository extends BaseRepository<Insured, Long> {

    @Override
    @EntityGraph(attributePaths = {"occupancy", "country", "region", "city", "partner"})
    List<Insured> findAll();

    @EntityGraph(attributePaths = {"occupancy", "country", "region", "city", "partner"})
    @Query("SELECT i FROM Insured i WHERE lower(i.name) LIKE lower(concat('%', :term, '%')) OR lower(i.shortName) LIKE lower(concat('%', :term, '%'))")
    List<Insured> searchByTerm(@Param("term") String term);

    @Query("SELECT i FROM Insured i WHERE i.active = true")
    List<Insured> findActiveInsured();

    @Query("SELECT i FROM Insured i WHERE i.occupancy.id = :occupancyId")
    List<Insured> findByOccupancyId(@Param("occupancyId") Long occupancyId);

    @Query("SELECT i FROM Insured i WHERE i.country.id = :countryId")
    List<Insured> findByCountryId(@Param("countryId") Long countryId);

    @Query("SELECT i FROM Insured i WHERE i.region.id = :regionId")
    List<Insured> findByRegionId(@Param("regionId") Long regionId);

    @Query("SELECT i FROM Insured i WHERE i.partner.id = :partnerId")
    List<Insured> findByPartnerId(@Param("partnerId") Long partnerId);

    @Query("SELECT i FROM Insured i WHERE i.type = :type")
    List<Insured> findByType(@Param("type") String type);

    Optional<Insured> findByName(String name);

    boolean existsByName(String name);

    @Query("SELECT COUNT(i) FROM Insured i WHERE i.active = true")
    long countActiveInsured();

    // Additional methods for service compatibility
    List<Insured> findByActiveTrue();
    
    Optional<Insured> findByIdAndActiveTrue(Long id);
} 