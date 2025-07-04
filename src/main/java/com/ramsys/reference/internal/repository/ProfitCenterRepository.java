package com.ramsys.reference.internal.repository;

import com.ramsys.reference.model.ProfitCenter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProfitCenterRepository extends JpaRepository<ProfitCenter, Long> {
    
}
