package com.ramsys.reference.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * DTO for Currency Exchange information.
 */
public record CurrencyExchangeDTO(
    Long id,
    String currencyCode,
    String currencyName,
    Long periodId,
    Integer year,
    Integer month,
    BigDecimal rate,
    LocalDate effectiveDate,
    Boolean isActive
) {}
