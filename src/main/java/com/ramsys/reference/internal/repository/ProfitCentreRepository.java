package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.ProfitCentre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProfitCentreRepository extends JpaRepository<ProfitCentre, Long> {
    
    Optional<ProfitCentre> findByCode(String code);
    
    List<ProfitCentre> findByIsActiveTrueOrderByCode();
    
    @Query("SELECT pc FROM ProfitCentre pc WHERE pc.location.id = :locationId AND pc.isActive = true ORDER BY pc.code")
    List<ProfitCentre> findByLocationIdAndIsActiveTrueOrderByCode(@Param("locationId") Long locationId);
    
    @Query("SELECT pc FROM ProfitCentre pc WHERE pc.division.id = :divisionId AND pc.isActive = true ORDER BY pc.code")
    List<ProfitCentre> findByDivisionIdAndIsActiveTrueOrderByCode(@Param("divisionId") Long divisionId);
    
    boolean existsByCode(String code);
} 
