package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.ProfitCenter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProfitCenterRepository extends JpaRepository<ProfitCenter, Long> {
    
    Optional<ProfitCenter> findByCode(String code);
    
    List<ProfitCenter> findByIsActiveTrueOrderByCode();

    @Query("SELECT pc FROM ProfitCenter pc WHERE pc.location.id = :locationId AND pc.isActive = true ORDER BY pc.code")
    List<ProfitCenter> findByLocationIdAndIsActiveTrueOrderByCode(@Param("locationId") Long locationId);
    
    @Query("SELECT pc FROM ProfitCenter pc WHERE pc.division.id = :divisionId AND pc.isActive = true ORDER BY pc.code")
    List<ProfitCenter> findByDivisionIdAndIsActiveTrueOrderByCode(@Param("divisionId") Long divisionId);
    
    boolean existsByCode(String code);
} 
