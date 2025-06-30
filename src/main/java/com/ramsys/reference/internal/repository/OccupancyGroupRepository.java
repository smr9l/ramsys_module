package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.OccupancyGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OccupancyGroupRepository extends JpaRepository<OccupancyGroup, Long> {
    
    /**
     * Récupère tous les groupes d'occupation actifs
     * @return Liste des groupes d'occupation actifs
     */
    List<OccupancyGroup> findByIsActiveTrue();
    
    /**
     * Récupère un groupe d'occupation par son code
     * @param code Le code du groupe
     * @return Le groupe d'occupation ou null
     */
    OccupancyGroup findByCode(String code);
    
    /**
     * Vérifie si un groupe d'occupation avec ce code existe
     * @param code Le code à vérifier
     * @return true si un groupe avec ce code existe
     */
    boolean existsByCode(String code);
} 
