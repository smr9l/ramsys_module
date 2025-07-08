package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.internal.repository.RatingRepository;
import com.ramsys.reference.model.Rating;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Service for managing Rating entities.
 */
@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class RatingService {
    
    private final RatingRepository ratingRepository;
    private final LocalizedMapper referenceMapper;
    
    /**
     * Get all ratings as reference DTOs
     */
    public List<ReferenceDTO> getAllRatings() {
        log.debug("Retrieving all ratings");
        List<Rating> ratings = ratingRepository.findAllOrderByNumericValue();
        return referenceMapper.toDtoList(ratings);
    }
    
    /**
     * Get rating by ID
     */
    public Optional<ReferenceDTO> getRatingById(Long id) {
        log.debug("Retrieving rating with ID: {}", id);
        return ratingRepository.findById(id)
                .map(referenceMapper::toReferenceDTO);
    }
    
    /**
     * Get rating by code
     */
    public Optional<ReferenceDTO> getRatingByCode(String code) {
        log.debug("Retrieving rating with code: {}", code);
        return ratingRepository.findByCode(code)
                .map(referenceMapper::toReferenceDTO);
    }
    
    /**
     * Get all active ratings (for dropdowns)
     */
    public List<ReferenceDTO> getAllActiveRatings() {
        log.debug("Retrieving all active ratings");
        List<Rating> ratings = ratingRepository.findAllActive();
        return referenceMapper.toDtoList(ratings);
    }
    
    /**
     * Find rating entity by ID
     */
    public Optional<Rating> findRatingById(Long id) {
        log.debug("Finding rating entity with ID: {}", id);
        return ratingRepository.findById(id);
    }
    
    /**
     * Find rating entity by code
     */
    public Optional<Rating> findRatingByCode(String code) {
        log.debug("Finding rating entity with code: {}", code);
        return ratingRepository.findByCode(code);
    }
} 