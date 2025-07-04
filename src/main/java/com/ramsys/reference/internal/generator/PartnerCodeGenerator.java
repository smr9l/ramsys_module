package com.ramsys.reference.internal.generator;

import com.ramsys.reference.model.Country;
import com.ramsys.reference.model.Partner;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.generator.BeforeExecutionGenerator;
import org.hibernate.generator.EventType;

import java.util.EnumSet;

public class PartnerCodeGenerator implements BeforeExecutionGenerator {


    @Override
    public Object generate(SharedSessionContractImplementor session, Object owner, Object currentValue, EventType eventType) {

        Partner partner = (Partner) owner;
        Country country = partner.getCountry();
        if (country == null || country.getCode() == null) {
            throw new IllegalStateException("Country must be set before code generation");
        }
        String countryCode = country.getCode();
        String maxCode = session.createQuery(
                "SELECT count(*) FROM Partner p WHERE p.country = :country", String.class)
                .setParameter("country", country)
                .setHibernateFlushMode(org.hibernate.FlushMode.COMMIT)  // Prevent auto-flush recursion

                .getSingleResult();
        int nextNumber = 1;
        if (maxCode != null && maxCode.matches(countryCode + "-\\d+")) {
            nextNumber = Integer.parseInt(maxCode.substring(countryCode.length() + 1)) + 1;
        }
        return String.format("%s-%08d", countryCode, nextNumber);
    }

    @Override
    public EnumSet<EventType> getEventTypes() {
        return EnumSet.of(EventType.INSERT);
    }


}
