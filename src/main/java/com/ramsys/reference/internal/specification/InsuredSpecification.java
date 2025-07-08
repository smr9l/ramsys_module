package com.ramsys.reference.internal.specification;

import com.ramsys.reference.dto.InsuredFilterDTO;
import com.ramsys.reference.model.Insured;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Spécification pour la construction dynamique de requêtes sur les assurés
 */
@Component
public class InsuredSpecification {

    public Specification<Insured> fromFilter(InsuredFilterDTO filter) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            // Search term (name or short name)
            if (filter.getSearchTerm() != null && !filter.getSearchTerm().trim().isEmpty()) {
                String searchPattern = "%" + filter.getSearchTerm().toLowerCase() + "%";
                Predicate namePredicate = criteriaBuilder.like(
                    criteriaBuilder.lower(root.get("name")), searchPattern);
                Predicate shortNamePredicate = criteriaBuilder.like(
                    criteriaBuilder.lower(root.get("shortName")), searchPattern);
                predicates.add(criteriaBuilder.or(namePredicate, shortNamePredicate));
            }

            // Type filter
            if (filter.getType() != null && !filter.getType().trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("type"), filter.getType()));
            }

            // Occupancy filter
            if (filter.getOccupancyId() != null) {
                predicates.add(criteriaBuilder.equal(root.get("occupancy").get("id"), filter.getOccupancyId()));
            }

            // Country filter
            if (filter.getCountryId() != null) {
                predicates.add(criteriaBuilder.equal(root.get("country").get("id"), filter.getCountryId()));
            }

            // Region filter
            if (filter.getRegionId() != null) {
                predicates.add(criteriaBuilder.equal(root.get("region").get("id"), filter.getRegionId()));
            }

            // City filter
            if (filter.getCityId() != null) {
                predicates.add(criteriaBuilder.equal(root.get("city").get("id"), filter.getCityId()));
            }

            // Partner filter
            if (filter.getPartnerId() != null) {
                predicates.add(criteriaBuilder.equal(root.get("partner").get("id"), filter.getPartnerId()));
            }

            // Active filter
            if (filter.getIsActive() != null) {
                predicates.add(criteriaBuilder.equal(root.get("active"), filter.getIsActive()));
            } else {
                // By default, only show active insureds
                predicates.add(criteriaBuilder.equal(root.get("active"), true));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
    }
} 