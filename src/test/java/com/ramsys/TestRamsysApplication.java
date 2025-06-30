package com.ramsys;

import org.springframework.boot.SpringApplication;

/**
 * Test main class for running RAMSYS with TestContainers configuration.
 * 
 * This allows running the application locally with TestContainers for development
 * and testing purposes, providing an isolated database environment.
 * 
 * Usage: Run this class to start the application with TestContainers support.
 */
public class TestRamsysApplication {

    public static void main(String[] args) {
        SpringApplication.from(RamsysApplication::main)
            .with(TestcontainersConfiguration.class)
            .run(args);
    }

}
