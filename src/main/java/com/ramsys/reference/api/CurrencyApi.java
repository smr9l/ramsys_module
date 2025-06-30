package com.ramsys.reference.api;

import com.ramsys.common.dto.ReferenceDTO;

import java.util.List;
import java.util.Optional;

public interface CurrencyApi {

    /**
     * Get all active currencies
     *
     * @return list of currency reference data
     */
    List<ReferenceDTO> getAllCurrencies();

    /**
     * Get a specific currency by its code
     *
     * @param code the currency code (e.g., "USD", "EUR")
     * @return currency reference data
     */
    Optional<ReferenceDTO> getCurrencyByCode(String code);
} 