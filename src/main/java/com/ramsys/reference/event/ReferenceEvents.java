package com.ramsys.reference.event;

import java.time.Instant;

/**
 * Events published by the Reference module.
 * Other modules can listen to these events to react to changes in reference data.
 */
public final class ReferenceEvents {
    
    private ReferenceEvents() {
        // Utility class
    }
    
    /**
     * Published when a new partner is created.
     */
    public record PartnerCreated(
        Long partnerId,
        String partnerCode,
        String partnerName,
        String partnerType,
        Instant occurredAt
    ) {
        public PartnerCreated(Long partnerId, String partnerCode, String partnerName, String partnerType) {
            this(partnerId, partnerCode, partnerName, partnerType, Instant.now());
        }
    }
    
    /**
     * Published when partner information is updated.
     */
    public record PartnerUpdated(
        Long partnerId,
        String partnerCode,
        String partnerName,
        String partnerType,
        Instant occurredAt
    ) {
        public PartnerUpdated(Long partnerId, String partnerCode, String partnerName, String partnerType) {
            this(partnerId, partnerCode, partnerName, partnerType, Instant.now());
        }
    }
    
    /**
     * Published when a partner is deactivated.
     */
    public record PartnerDeactivated(
        Long partnerId,
        String partnerCode,
        String reason,
        Instant occurredAt
    ) {
        public PartnerDeactivated(Long partnerId, String partnerCode, String reason) {
            this(partnerId, partnerCode, reason, Instant.now());
        }
    }
    
    /**
     * Published when currency exchange rates are updated.
     */
    public record CurrencyRatesUpdated(
        Long currencyId,
        String currencyCode,
        Long periodId,
        Instant occurredAt
    ) {
        public CurrencyRatesUpdated(Long currencyId, String currencyCode, Long periodId) {
            this(currencyId, currencyCode, periodId, Instant.now());
        }
    }
    
    /**
     * Published when a new country is added to the system.
     */
    public record CountryCreated(
        Long countryId,
        String countryCode,
        String countryName,
        Instant occurredAt
    ) {
        public CountryCreated(Long countryId, String countryCode, String countryName) {
            this(countryId, countryCode, countryName, Instant.now());
        }
    }
    
    /**
     * Published when arrangement types are updated.
     */
    public record ArrangementTypesUpdated(
        String reason,
        Instant occurredAt
    ) {
        public ArrangementTypesUpdated(String reason) {
            this(reason, Instant.now());
        }
    }
}
