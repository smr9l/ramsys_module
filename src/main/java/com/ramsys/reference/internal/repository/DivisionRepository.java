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
    

    @Query("SELECT d FROM Division d WHERE d.location.id = :locationId AND d.active = true ORDER BY d.code")
    List<Division> findByLocationIdAndActiveTrueOrderByCode(@Param("locationId") Long locationId);

 }
