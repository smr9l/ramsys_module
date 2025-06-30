package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.Partner;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PartnerRepository extends JpaRepository<Partner, Long>, JpaSpecificationExecutor<Partner> {

    @Override
    @EntityGraph(attributePaths = {"partnerType", "country", "region", "currency", "parentPartner"})
    Page<Partner> findAll(Specification<Partner> spec, Pageable pageable);

     boolean existsByCode(String code);

    Optional<Partner> findByCode(String code);

    @Query("SELECT p FROM Partner p WHERE lower(p.name) LIKE lower(concat('%', :term, '%')) OR lower(p.code) LIKE lower(concat('%', :term, '%'))")
    List<Partner> searchByTerm(@Param("term") String term);

    @Query("SELECT p FROM Partner p WHERE p.isActive = true")
    List<Partner> findActivePartners();

    List<Partner> findByIsInwardsTrue();

    List<Partner> findByIsOutwardsTrue();

    @Query("SELECT p FROM Partner p WHERE p.country.code = :countryCode")
    List<Partner> findByCountryCode(@Param("countryCode") String countryCode);
}