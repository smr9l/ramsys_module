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

}

/**
 * Configuration properties for the Reference module
 */
