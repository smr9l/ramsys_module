package com.ramsys.reference.internal.repository;

import com.ramsys.common.repository.BaseRepository;
import com.ramsys.reference.model.Occupancy;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OccupancyRepository extends BaseRepository<Occupancy, Long> {

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
    List<Occupancy> findByActiveTrue();

    /**
     * Récupère toutes les occupations actives d'un groupe
     * @param groupId L'ID du groupe
     * @return Liste des occupations actives du groupe
     */
    List<Occupancy> findByGroupIdAndActiveTrue(Long groupId);
}
