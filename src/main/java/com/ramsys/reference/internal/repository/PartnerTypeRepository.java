package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.PartnerType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository pour les types de partenaires
 */
@Repository
public interface PartnerTypeRepository extends JpaRepository<PartnerType, Long> {
    
    /**
     * Récupère tous les types de partenaire actifs
     * @return Liste des types de partenaire actifs
     */
    List<PartnerType> findByIsActiveTrue();
    
    /**
     * Récupère un type de partenaire par son code
     * @param code Le code du type de partenaire
     * @return Le type de partenaire ou null
     */
    PartnerType findByCode(String code);
    
    /**
     * Vérifie si un type de partenaire avec ce code existe
     * @param code Le code à vérifier
     * @return true si un type avec ce code existe
     */
    boolean existsByCode(String code);
} 
