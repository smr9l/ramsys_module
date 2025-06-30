package com.ramsys.users.internal.repository;

import com.ramsys.users.internal.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    Optional<User> findByUsername(String username);
    
    Optional<User> findByUsernameAndIsActiveTrue(String username);
    
    Optional<User> findByEmail(String email);
    
    List<User> findByIsActiveTrue();
    
    Page<User> findByIsActiveTrue(Pageable pageable);
    
    boolean existsByUsername(String username);
    
    boolean existsByEmail(String email);
    
    @Query("SELECT u FROM User u WHERE u.role.code = :roleCode AND u.isActive = true")
    List<User> findByRolesCode(@Param("roleCode") String roleCode);
    
    List<User> findByLocationIdAndIsActiveTrue(Long locationId);

    List<User> findByDivisionIdAndIsActiveTrue(Long divisionId);

    List<User> findByManagerIdAndIsActiveTrue(Long managerId);
    
    @Query("SELECT u FROM User u WHERE " +
           "LOWER(u.username) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(u.firstName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(u.lastName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(u.email) LIKE LOWER(CONCAT('%', :searchTerm, '%'))")
    Page<User> searchUsers(@Param("searchTerm") String searchTerm, Pageable pageable);
} 