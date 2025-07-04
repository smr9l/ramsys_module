package com.ramsys.users.internal.repository;

import com.ramsys.users.internal.model.Function;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FunctionRepository extends JpaRepository<Function, Long> {
    
    Optional<Function> findByCode(String code);
    
    Optional<Function> findByCodeAndActiveTrue(String code);
}
