package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.ArrangementType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArrangementTypeRepository extends JpaRepository<ArrangementType, Long> {
    
    /**
     * Récupère tous les types d'arrangement actifs
     * @return Liste des types d'arrangement actifs
     */
    List<ArrangementType> findByIsActiveTrue();
    
    /**
     * Récupère tous les types d'arrangement d'un type de portefeuille
     * @param portfolioTypeId L'ID du type de portefeuille
     * @return Liste des types d'arrangement
     */
    List<ArrangementType> findByPortfolioTypeId(Long portfolioTypeId);
    
    /**
     * Récupère tous les types d'arrangement d'un type de contrat
     * @param contractTypeId L'ID du type de contrat
     * @return Liste des types d'arrangement
     */
    List<ArrangementType> findByContractTypeId(Long contractTypeId);
    
    /**
     * Récupère tous les types d'arrangement d'un type de traitement
     * @param processingTypeId L'ID du type de traitement
     * @return Liste des types d'arrangement
     */
    List<ArrangementType> findByProcessingTypeId(Long processingTypeId);
    
    /**
     * Récupère tous les types d'arrangement d'un type d'affaires
     * @param businessTypeId L'ID du type d'affaires
     * @return Liste des types d'arrangement
     */
    List<ArrangementType> findByBusinessTypeId(Long businessTypeId);
} 
