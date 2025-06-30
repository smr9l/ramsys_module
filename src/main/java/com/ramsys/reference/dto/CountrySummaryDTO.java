package com.ramsys.reference.dto;

/**
 * Lightweight DTO for Country information used in cross-module communication.
 * Contains only essential fields to minimize data transfer overhead.
 */
public record CountrySummaryDTO(
    Long id,
    String code,
    String name,
    String regionName,
    Boolean isActive
) {
    
    /**
     * Constructor for creating a minimal summary with just basic info
     */
    public CountrySummaryDTO(Long id, String code, String name) {
        this(id, code, name, null, true);
    }
}
