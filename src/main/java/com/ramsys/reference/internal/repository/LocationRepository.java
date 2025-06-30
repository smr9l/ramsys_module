package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.Location;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LocationRepository extends JpaRepository<Location, Long> {
    
    Optional<Location> findByCode(String code);
    
    List<Location> findByIsActiveTrueOrderByCode();
    
    boolean existsByCode(String code);
} 
