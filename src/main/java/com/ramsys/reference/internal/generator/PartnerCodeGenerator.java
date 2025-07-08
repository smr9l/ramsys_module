package com.ramsys.reference.internal.generator;

import com.ramsys.common.exception.BusinessException;
import com.ramsys.reference.model.Country;
import com.ramsys.reference.model.Partner;
import com.ramsys.reference.model.PartnerType;
import com.ramsys.reference.model.PartnerTypeCodeEnum;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.generator.BeforeExecutionGenerator;
import org.hibernate.generator.EventType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.EnumSet;

/**
 * Partner code generator that creates codes in the format: {CountryCode}{TypeIndicator}{TypeCode}{SequentialNumber}
 * <p>
 * Format breakdown:
 * - CountryCode: 2-letter ISO country code (CI, AE, CD, etc.)
 * - TypeIndicator: Always "0" (zero)
 * - TypeCode: Single letter based on partner type (C=CEDANT, B=BROKER, O=OTHER)
 * - SequentialNumber: 6-digit sequential number (000001, 000002, etc.)
 * <p>
 * Examples:
 * - CI0C000001 (Ivorian Cedant #1)
 * - AE0B000001 (UAE Broker #1)
 * - CD0C000001 (Congolese Cedant #1)
 *
 * @author RAMSYS Development Team
 * @version 1.0
 */
@Component
public class PartnerCodeGenerator implements BeforeExecutionGenerator {

    private static final Logger log = LoggerFactory.getLogger(PartnerCodeGenerator.class);

    private static final String TYPE_INDICATOR = "0";
    private static final int SEQUENCE_LENGTH = 6;


    @Override
    public Object generate(SharedSessionContractImplementor session, Object owner, Object currentValue, EventType eventType) {
        if (!(owner instanceof Partner partner)) {
            throw new IllegalArgumentException("PartnerCodeGenerator can only be used with Partner entities");
        }

        try {
            // Extract required information
            String countryCode = extractCountryCode(partner);
            String typeCode = extractPartnerTypeCode(partner);

            // Generate next sequence number
            int nextSequence = getNextSequenceNumber(session, countryCode, typeCode);

            // Format: {CountryCode}{TypeIndicator}{TypeCode}{SequentialNumber}
            String generatedCode = String.format("%s%s%s%0" + SEQUENCE_LENGTH + "d",
                    countryCode, TYPE_INDICATOR, typeCode, nextSequence);

            log.debug("Generated partner code: {} for partner: {}", generatedCode, partner.getName());
            return generatedCode;

        } catch (Exception e) {
            log.error("Failed to generate partner code for partner: {}", partner.getName(), e);
            throw new BusinessException("Failed to generate partner code", e);
        }
    }

    private String extractCountryCode(Partner partner) {
        Country country = partner.getCountry();
        if (country == null || country.getCode() == null) {
            throw new IllegalStateException("Partner must have a valid country with code");
        }
        return country.getCode().toUpperCase();
    }

    private String extractPartnerTypeCode(Partner partner) {
        PartnerType partnerType = partner.getPartnerType();
        if (partnerType == null || partnerType.getCode() == null) {
            throw new IllegalStateException("Partner must have a valid partner type with code");
        }

        PartnerTypeCodeEnum typeCode = PartnerTypeCodeEnum.fromCode(partnerType.getCode());
        return typeCode.getCode();
    }

    private int getNextSequenceNumber(SharedSessionContractImplementor session, String countryCode, String typeCode) {
        // Build the pattern for this country and type: CI0C%
        String codePattern = countryCode + TYPE_INDICATOR + typeCode + "%";

        // Query to find the maximum sequence number for this pattern
        String sql = """
                SELECT COALESCE(MAX(CAST(SUBSTRING(code, 5) AS INTEGER)), 0) + 1 
                FROM ref_partner 
                WHERE code LIKE ?
                """;

        try {
            // Save current flush mode and disable auto-flush to prevent circular dependencies
            org.hibernate.FlushMode originalFlushMode = session.getHibernateFlushMode();
            session.setHibernateFlushMode(org.hibernate.FlushMode.MANUAL);
            
            try {
                Object result = session.createNativeQuery(sql, Integer.class)
                        .setParameter(1, codePattern)
                        .getSingleResultOrNull();

                int nextSequence = (result != null) ? (Integer) result : 1;

                log.debug("Next sequence for pattern {}: {}", codePattern, nextSequence);
                return nextSequence;
            } finally {
                // Restore original flush mode
                session.setHibernateFlushMode(originalFlushMode);
            }

        } catch (Exception e) {
            log.error("Failed to get next sequence number for pattern: {}", codePattern, e);
            throw new RuntimeException("Failed to generate sequence number", e);
        }
    }

    @Override
    public EnumSet<EventType> getEventTypes() {
        return EnumSet.of(EventType.INSERT);
    }
}
