package com.ramsys.common.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.data.domain.Persistable;

import java.io.Serializable;
import java.time.OffsetDateTime;

/**
 * Base entity that follows Spring Data JPA best practices.
 * 
 * This class implements Persistable<Long> which provides:
 * - Better integration with Spring Data JPA
 * - Proper new entity detection
 * - Optimized performance for batch operations
 * 
 * NOTE: Each entity must define its own ID generation strategy
 * for optimal performance with PostgreSQL sequences.
 * 
 * Example implementation in an entity:
 * 
 * @Id
 * @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_region_seq")
 * @SequenceGenerator(name = "ref_region_seq", sequenceName = "ref_region_id_seq", allocationSize = 1)
 * private Long id;
 */
@Getter
@Setter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public abstract class BaseEntity implements Persistable<Long>, Serializable {

    private static final long serialVersionUID = 1L;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    @JsonIgnore
    private OffsetDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    @JsonIgnore
    private OffsetDateTime updatedAt;

    @CreatedBy
    @Column(name = "created_by", updatable = false, length = 50)
    @JsonIgnore
    private String createdBy;

    @LastModifiedBy
    @Column(name = "updated_by", length = 50)
    @JsonIgnore
    private String updatedBy;    @Column(name = "is_active", nullable = false)
    private Boolean isActive = Boolean.TRUE;

    // Abstract method to force ID implementation in each entity
    @Override
    public abstract Long getId();
    
    public abstract void setId(Long id);

    /**
     * Spring Data JPA uses this method to determine if an entity is new.
     * An entity is considered new if its ID is null.
     */
    @Override
    @JsonIgnore
    public boolean isNew() {
        return getId() == null;
    }

    /**
     * Optimized equals method that follows JPA best practices.
     * Uses ID for comparison when available, otherwise falls back to instance comparison.
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        BaseEntity that = (BaseEntity) obj;
        
        // If both entities have IDs, compare them
        if (getId() != null && that.getId() != null) {
            return getId().equals(that.getId());
        }
        
        // If one or both don't have IDs, they are only equal if they're the same instance
        return false;
    }

    /**
     * Optimized hashCode method that follows JPA best practices.
     * Uses a constant hash code to ensure consistency across proxy states.
     */
    @Override
    public int hashCode() {
        return getClass().hashCode();
    }

    /**
     * Convenience method to activate an entity.
     */
    public void activate() {
        this.isActive = Boolean.TRUE;
    }

    /**
     * Convenience method to deactivate an entity.
     */
    public void deactivate() {
        this.isActive = Boolean.FALSE;
    }

    /**
     * Check if the entity is active.
     */
    public boolean isActive() {
        return Boolean.TRUE.equals(this.isActive);
    }

    @Override
    public String toString() {
        return String.format("%s{id=%s}", getClass().getSimpleName(), getId());
    }
}
