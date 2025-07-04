package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.Currency;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CurrencyRepository extends JpaRepository<Currency, Long>, JpaSpecificationExecutor<Currency> {
    
    /**
     * Find currency by code
     * @param code the currency code
     * @return Optional currency
     */
    Optional<Currency> findByCode(String code);
    
    /**
     * Check if currency exists by code
     * @param code the currency code
     * @return true if exists
     */
    boolean existsByCode(String code);

    List<Currency> findAllByActiveTrueOrderByCode();
}
