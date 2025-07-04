package com.ramsys.reference.internal.repository;

import com.ramsys.common.repository.BaseRepository;
import com.ramsys.reference.model.PartnerType;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository pour les types de partenaires
 */
@Repository
public interface PartnerTypeRepository extends BaseRepository<PartnerType, Long> {

    /**
     * Récupère tous les types de partenaire actifs
     * @return Liste des types de partenaire actifs
     */
    List<PartnerType> findByActiveTrue();

    /**
     * Récupère un type de partenaire par son code (actif seulement)
     * @param code Le code du type de partenaire
     * @return Le type de partenaire correspondant
     */
    PartnerType findByCodeAndActiveTrue(String code);
}
