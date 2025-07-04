package com.ramsys.common.repository;

import com.ramsys.common.model.Auditable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
 import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.query.Param;

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
public interface BaseRepository<T extends Auditable, ID> extends
    JpaRepository<T, ID>, JpaSpecificationExecutor<T> {

    /**
     * Find all active entities
     */
    List<T> findByActiveTrue();

    /**
     * Find entity by ID if active
     */
    Optional<T> findByIdAndActiveTrue(ID id);

    /**
     * Check if entity exists and is active
     */
    boolean existsByIdAndActiveTrue(ID id);

    /**
     * Count active entities
     */
    long countByActiveTrue();

    /**
     * Find all entities including inactive ones (for admin purposes)
     */
    @Query("SELECT e FROM #{#entityName} e")
    List<T> findAllIncludingInactive();

    /**
     * Find entity by ID including inactive ones (for admin purposes)
     */
    @Query("SELECT e FROM #{#entityName} e WHERE e.id = :id")
    Optional<T> findByIdIncludingInactive(@Param("id") ID id);
}
