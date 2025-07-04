package com.ramsys.reference.internal.repository;

import com.ramsys.common.repository.BaseRepository;
import com.ramsys.reference.model.OccupancyGroup;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OccupancyGroupRepository extends BaseRepository<OccupancyGroup, Long> {

    /**
     * Récupère tous les groupes d'occupation actifs
     * @return Liste des groupes d'occupation actifs
     */
    List<OccupancyGroup> findByActiveTrue();

    /**
     * Récupère un groupe d'occupation par son code (actif seulement)
     * @param code Le code du groupe
     * @return Le groupe d'occupation ou Optional.empty()
     */
    Optional<OccupancyGroup> findByCodeAndActiveTrue(String code);
}
