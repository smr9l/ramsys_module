package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.Occupancy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OccupancyRepository extends JpaRepository<Occupancy, Long> {
    
    /**
     * Récupère toutes les occupations d'un groupe
     * @param groupId L'ID du groupe
     * @return Liste des occupations du groupe
     */
    List<Occupancy> findByGroupId(Long groupId);
    
    /**
     * Récupère toutes les occupations actives
     * @return Liste des occupations actives
     */
    List<Occupancy> findByIsActiveTrue();
    
    /**
     * Récupère toutes les occupations actives d'un groupe
     * @param groupId L'ID du groupe
     * @return Liste des occupations actives du groupe
     */
    List<Occupancy> findByGroupIdAndIsActiveTrue(Long groupId);
} 
