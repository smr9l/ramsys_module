package com.ramsys.common.repository;

import com.ramsys.common.model.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.List;
import java.util.Optional;

/**
 * Base repository interface that extends Spring Data JPA
 * 
 * This interface provides common repository methods that all
 * repositories can inherit from, leveraging Spring Data JPA
 * capabilities without reinventing the wheel.
 */
@NoRepositoryBean
public interface BaseRepository<T extends BaseEntity, ID> extends 
    JpaRepository<T, ID>, JpaSpecificationExecutor<T> {

    /**
     * Find all active entities
     */
    List<T> findByIsActiveTrue();

    /**
     * Find entity by ID if active
     */
    Optional<T> findByIdAndIsActiveTrue(ID id);

    /**
     * Check if entity exists and is active
     */
    boolean existsByIdAndIsActiveTrue(ID id);

    /**
     * Count active entities
     */
    long countByIsActiveTrue();
} 