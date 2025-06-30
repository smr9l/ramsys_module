package com.ramsys.reference.event;

import com.ramsys.reference.model.Partner;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

/**
 * Event publisher for the Reference module.
 * 
 * <p>This component is responsible for publishing events when significant
 * changes occur in the reference data. Other modules can listen to these
 * events to maintain consistency and react to changes.</p>
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class ReferenceEventPublisher {
    
    private final ApplicationEventPublisher eventPublisher;
    
    /**
     * Publish an event when a partner is created
     */
    public void publishPartnerCreated(Partner partner) {
        log.debug("Publishing PartnerCreated event for partner: {}", partner.getCode());
        
        var event = new ReferenceEvents.PartnerCreated(
            partner.getId(),
            partner.getCode(),
            partner.getName(),
            partner.getPartnerType() != null ? partner.getPartnerType().getName() : "Unknown"
        );
        
        eventPublisher.publishEvent(event);
        log.info("Published PartnerCreated event for partner: {} (ID: {})", 
                partner.getCode(), partner.getId());
    }
    
    /**
     * Publish an event when a partner is updated
     */
    public void publishPartnerUpdated(Partner partner) {
        log.debug("Publishing PartnerUpdated event for partner: {}", partner.getCode());
        
        var event = new ReferenceEvents.PartnerUpdated(
            partner.getId(),
            partner.getCode(),
            partner.getName(),
            partner.getPartnerType() != null ? partner.getPartnerType().getName() : "Unknown"
        );
        
        eventPublisher.publishEvent(event);
        log.info("Published PartnerUpdated event for partner: {} (ID: {})", 
                partner.getCode(), partner.getId());
    }
    
    /**
     * Publish an event when a partner is deactivated
     */
    public void publishPartnerDeactivated(Long partnerId, String partnerCode, String reason) {
        log.debug("Publishing PartnerDeactivated event for partner: {}", partnerCode);
        
        var event = new ReferenceEvents.PartnerDeactivated(
            partnerId,
            partnerCode,
            reason
        );
        
        eventPublisher.publishEvent(event);
        log.info("Published PartnerDeactivated event for partner: {} (ID: {}), reason: {}", 
                partnerCode, partnerId, reason);
    }
    
    /**
     * Publish an event when currency rates are updated
     */
    public void publishCurrencyRatesUpdated(Long currencyId, String currencyCode, Long periodId) {
        log.debug("Publishing CurrencyRatesUpdated event for currency: {} in period: {}", 
                 currencyCode, periodId);
        
        var event = new ReferenceEvents.CurrencyRatesUpdated(
            currencyId,
            currencyCode,
            periodId
        );
        
        eventPublisher.publishEvent(event);
        log.info("Published CurrencyRatesUpdated event for currency: {} (ID: {}) in period: {}", 
                currencyCode, currencyId, periodId);
    }
    
    /**
     * Publish an event when a country is added
     */
    public void publishCountryCreated(Long countryId, String countryCode, String countryName) {
        log.debug("Publishing CountryCreated event for country: {}", countryCode);
        
        var event = new ReferenceEvents.CountryCreated(
            countryId,
            countryCode,
            countryName
        );
        
        eventPublisher.publishEvent(event);
        log.info("Published CountryCreated event for country: {} (ID: {})", 
                countryCode, countryId);
    }
    
    /**
     * Publish an event when arrangement types are updated
     */
    public void publishArrangementTypesUpdated(String reason) {
        log.debug("Publishing ArrangementTypesUpdated event, reason: {}", reason);
        
        var event = new ReferenceEvents.ArrangementTypesUpdated(reason);
        
        eventPublisher.publishEvent(event);
        log.info("Published ArrangementTypesUpdated event, reason: {}", reason);
    }
}
