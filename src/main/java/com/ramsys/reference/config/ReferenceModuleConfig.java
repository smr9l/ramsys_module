package com.ramsys.reference.config;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * Configuration for the Reference Data Management Module.
 * 
 * <p>This configuration class sets up the Spring context for the Reference module,
 * including JPA repositories, entity scanning, and caching configuration.</p>
 */
@Configuration
@EnableJpaRepositories(basePackages = "com.ramsys.reference.internal.repository")
@EntityScan(basePackages = "com.ramsys.reference.model")
@ComponentScan(basePackages = {
    "com.ramsys.reference.internal",
    "com.ramsys.reference.web",
    "com.ramsys.reference.event"
})
@EnableCaching
@EnableAsync
public class ReferenceModuleConfig {
    
    /**
     * Configuration properties for the Reference module
     */
    @Bean
    @ConfigurationProperties("ramsys.reference")
    public ReferenceModuleProperties referenceProperties() {
        return new ReferenceModuleProperties();
    }
}

/**
 * Configuration properties for the Reference module
 */
class ReferenceModuleProperties {
    
    private CacheProperties cache = new CacheProperties();
    private ValidationProperties validation = new ValidationProperties();
    
    public CacheProperties getCache() {
        return cache;
    }
    
    public void setCache(CacheProperties cache) {
        this.cache = cache;
    }
    
    public ValidationProperties getValidation() {
        return validation;
    }
    
    public void setValidation(ValidationProperties validation) {
        this.validation = validation;
    }
    
    public static class CacheProperties {
        private long ttlMinutes = 120; // 2 hours default
        private long maxSize = 1000;
        
        public long getTtlMinutes() {
            return ttlMinutes;
        }
        
        public void setTtlMinutes(long ttlMinutes) {
            this.ttlMinutes = ttlMinutes;
        }
        
        public long getMaxSize() {
            return maxSize;
        }
        
        public void setMaxSize(long maxSize) {
            this.maxSize = maxSize;
        }
    }
    
    public static class ValidationProperties {
        private boolean strictValidation = true;
        private boolean validateReferences = true;
        
        public boolean isStrictValidation() {
            return strictValidation;
        }
        
        public void setStrictValidation(boolean strictValidation) {
            this.strictValidation = strictValidation;
        }
        
        public boolean isValidateReferences() {
            return validateReferences;
        }
        
        public void setValidateReferences(boolean validateReferences) {
            this.validateReferences = validateReferences;
        }
    }
}
