package com.ramsys.users.internal.repository;

import com.ramsys.users.internal.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {

    @Query("SELECT r FROM Role r WHERE r.code = :code")
    Optional<Role> findByCode(String code);
    
 }