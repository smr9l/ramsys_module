package com.ramsys;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.modulith.Modulith;

/**
 * Main Spring Boot application class for RAMSYS Backend.
 *
 * This is the entry point for the entire multi-module Spring Modulith application.
 * It enables component scanning across all modules and configures cross-cutting concerns.
 *
 * @author RAMSYS Team
 */
@SpringBootApplication(scanBasePackages = {"com.ramsys", "com.ramsys.config"})
//@EnableCaching
@Modulith(

        systemName = "Ramsys",
        sharedModules = "common"
)
public class RamsysApplication {

    public static void main(String[] args) {
        SpringApplication.run(RamsysApplication.class, args);
    }
}