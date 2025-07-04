package com.ramsys.common.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.OffsetDateTime;


@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter

public abstract class Auditable {

     @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

     @Column(name = "updated_at")
    private OffsetDateTime updatedAt;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "updated_by")
    private String updatedBy;


    @Column(name = "is_active", nullable = false)
    private boolean active ;

    // Méthode abstraite pour forcer l'implémentation de l'ID dans chaque entité
    public abstract Long getId();
    public abstract void setId(Long id);

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = OffsetDateTime.now();
        }

            active = true;

    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = OffsetDateTime.now();
    }



} 
