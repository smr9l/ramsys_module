package com.ramsys.reference.dto;

/**
 * Lightweight DTO for Currency information used in cross-module communication.
 * Contains only essential fields to minimize data transfer overhead.
 */
public record CurrencySummaryDTO(
    Long id,
    String code,
    String name,
    Boolean isActive
) {
    
    /**
     * Constructor for creating a minimal summary with just basic info
     */
    public CurrencySummaryDTO(Long id, String code, String name) {
        this(id, code, name, true);
    }
}
