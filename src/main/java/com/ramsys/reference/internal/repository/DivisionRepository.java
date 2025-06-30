package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.Division;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DivisionRepository extends JpaRepository<Division, Long> {
    
    Optional<Division> findByCode(String code);
    
    List<Division> findByIsActiveTrueOrderByCode();
    
    @Query("SELECT d FROM Division d WHERE d.location.id = :locationId AND d.isActive = true ORDER BY d.code")
    List<Division> findByLocationIdAndIsActiveTrueOrderByCode(@Param("locationId") Long locationId);
    
    boolean existsByCode(String code);
} 
