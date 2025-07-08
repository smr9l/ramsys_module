package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.Rating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for Rating entities.
 */
@Repository
public interface RatingRepository extends JpaRepository<Rating, Long> {
    
    /**
     * Find all ratings ordered by numeric value descending
     */
    @Query("SELECT r FROM Rating r ORDER BY r.numericValue DESC")
    List<Rating> findAllOrderByNumericValue();
    
    /**
     * Find rating by code
     */
    Optional<Rating> findByCode(String code);
    
    /**
     * Find all active ratings - in this case all ratings are active
     */
    @Query("SELECT r FROM Rating r ORDER BY r.numericValue DESC")
    List<Rating> findAllActive();
} 