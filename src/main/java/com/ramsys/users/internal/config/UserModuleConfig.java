package com.ramsys.users.internal.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.boot.autoconfigure.domain.EntityScan;

/**
 * Configuration for the User Management Module.
 * 
 * <p>This configuration class sets up the Spring context for the Users module,
 * including JPA repositories, entity scanning, and module-specific configuration.</p>
 */
@Configuration
@EnableJpaRepositories(basePackages = "com.ramsys.users.internal.repository")
@EntityScan(basePackages = "com.ramsys.users.internal.model")
@ComponentScan(basePackages = {
    "com.ramsys.users.internal",
    "com.ramsys.users.web"
})
public class UserModuleConfig {
    
    /**
     * Configuration properties for the Users module
     */
    @Bean
    @ConfigurationProperties("ramsys.users")
    public UserModuleProperties userProperties() {
        return new UserModuleProperties();
    }
}

/**
 * Configuration properties for the Users module
 */
class UserModuleProperties {
    
    private SecurityProperties security = new SecurityProperties();
    private ValidationProperties validation = new ValidationProperties();
    
    public SecurityProperties getSecurity() {
        return security;
    }
    
    public void setSecurity(SecurityProperties security) {
        this.security = security;
    }
    
    public ValidationProperties getValidation() {
        return validation;
    }
    
    public void setValidation(ValidationProperties validation) {
        this.validation = validation;
    }
    
    public static class SecurityProperties {
        private boolean enforcePasswordPolicy = true;
        private int minPasswordLength = 8;
        private boolean requireSpecialCharacters = true;
        
        public boolean isEnforcePasswordPolicy() {
            return enforcePasswordPolicy;
        }
        
        public void setEnforcePasswordPolicy(boolean enforcePasswordPolicy) {
            this.enforcePasswordPolicy = enforcePasswordPolicy;
        }
        
        public int getMinPasswordLength() {
            return minPasswordLength;
        }
        
        public void setMinPasswordLength(int minPasswordLength) {
            this.minPasswordLength = minPasswordLength;
        }
        
        public boolean isRequireSpecialCharacters() {
            return requireSpecialCharacters;
        }
        
        public void setRequireSpecialCharacters(boolean requireSpecialCharacters) {
            this.requireSpecialCharacters = requireSpecialCharacters;
        }
    }
    
    public static class ValidationProperties {
        private boolean strictValidation = true;
        private boolean validateEmailFormat = true;
        
        public boolean isStrictValidation() {
            return strictValidation;
        }
        
        public void setStrictValidation(boolean strictValidation) {
            this.strictValidation = strictValidation;
        }
        
        public boolean isValidateEmailFormat() {
            return validateEmailFormat;
        }
        
        public void setValidateEmailFormat(boolean validateEmailFormat) {
            this.validateEmailFormat = validateEmailFormat;
        }
    }
} 