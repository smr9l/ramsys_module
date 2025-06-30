package com.ramsys.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.lang.NonNull;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

/**
 * JPA Auditing configuration that follows Spring Data JPA best practices.
 * 
 * This configuration:
 * - Enables JPA auditing for automatic population of audit fields
 * - Provides an AuditorAware implementation that uses Spring Security
 * - Handles both authenticated and anonymous users
 * - Uses proper timezone handling for dates
 */
@Configuration
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class JpaAuditingConfig {

    /**
     * AuditorAware implementation that integrates with Spring Security.
     * 
     * This bean provides the current auditor (user) for JPA auditing.
     * It follows Spring Security best practices by:
     * - Getting the current authentication from SecurityContext
     * - Handling anonymous users gracefully
     * - Providing a fallback for system operations
     */
    @Bean
    public AuditorAware<String> auditorProvider() {
        return new SpringSecurityAuditorAware();
    }

    /**
     * Spring Security-aware auditor provider.
     */
    public static class SpringSecurityAuditorAware implements AuditorAware<String> {        @Override
        @NonNull
        public Optional<String> getCurrentAuditor() {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            
            if (authentication == null || !authentication.isAuthenticated()) {
                return Optional.of("system");
            }
            
            String username = authentication.getName();
            
            // Handle anonymous users
            if ("anonymousUser".equals(username)) {
                return Optional.of("anonymous");
            }
            
            return Optional.of(username);
        }
    }
}
