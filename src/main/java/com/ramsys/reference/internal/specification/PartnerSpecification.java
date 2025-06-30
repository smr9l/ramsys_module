 package com.ramsys.reference.internal.specification;

import com.ramsys.reference.dto.PartnerFilterDTO;
import com.ramsys.reference.model.*;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

@Component
public class PartnerSpecification {

    public Specification<Partner> fromFilter(PartnerFilterDTO filter) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            // Search term for name or code (case-insensitive)
            if (StringUtils.hasText(filter.getSearchTerm())) {
                String pattern = "%" + filter.getSearchTerm().toLowerCase() + "%";
                Predicate nameLike = criteriaBuilder.like(criteriaBuilder.lower(root.get(Partner_.name)), pattern);
                Predicate codeLike = criteriaBuilder.like(criteriaBuilder.lower(root.get(Partner_.code)), pattern);
                predicates.add(criteriaBuilder.or(nameLike, codeLike));
            }

            // Filter by partner type ID
            if (filter.getPartnerTypeId() != null) {
                predicates.add(criteriaBuilder.equal(root.get(Partner_.partnerType).get(PartnerType_.id), filter.getPartnerTypeId()));
            }

            // Filter by country ID
            if (filter.getCountryId() != null) {
                predicates.add(criteriaBuilder.equal(root.get(Partner_.country).get(Country_.id), filter.getCountryId()));
            }

            // Filter by active status
            if (filter.getIsActive() != null) {
                predicates.add(criteriaBuilder.equal(root.get(Partner_.isActive), filter.getIsActive()));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
    }
}