package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.ProfitCenter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProfitCenterRepository extends JpaRepository<ProfitCenter, Long> {
    Optional<ProfitCenter> findByCode(String code);
} 