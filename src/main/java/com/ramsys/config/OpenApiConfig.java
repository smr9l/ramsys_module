package com.ramsys.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import io.swagger.v3.oas.models.parameters.Parameter;
import io.swagger.v3.oas.models.media.StringSchema;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * Configuration for OpenAPI/Swagger documentation.
 * 
 * This configuration sets up the API documentation for the RAMSYS application,
 * including security schemes, server information, and API metadata.
 */
@Configuration
public class OpenApiConfig {

    @Value("${server.port:8080}")
    private String serverPort;

    @Value("${spring.application.name:RAMSYS Backend}")
    private String applicationName;

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(apiInfo())
                .servers(List.of(
                    new Server().url("https://localhost:" + serverPort).description("Development server"),
                    new Server().url("https://staging.ramsys-reinsurance.com").description("Staging server"),
                    new Server().url("https://api.ramsys-reinsurance.com").description("Production server")
                ))
                .addSecurityItem(new SecurityRequirement().addList("bearerAuth"))
                .components(new io.swagger.v3.oas.models.Components()
                    .addSecuritySchemes("bearerAuth", 
                        new SecurityScheme()
                            .type(SecurityScheme.Type.HTTP)
                            .scheme("bearer")
                            .bearerFormat("JWT")
                            .description("JWT token authentication")
                    )
                    .addParameters("acceptLanguageHeader",
                        new Parameter()
                            .in("header")
                            .name("Accept-Language")
                            .description("Preferred language for response content (e.g., 'fr', 'en', 'ar')")
                            .required(false)
                            .schema(new StringSchema()
                                ._default("fr")
                                .example("fr")
                                ._enum(List.of("fr", "en", "ar"))
                            )
                    )
                );
    }

    private Info apiInfo() {
        return new Info()
                .title("RAMSYS API")
                .description("""
                    **Reinsurance and Assurance Management System (RAMSYS) REST API**
                    
                    This API provides comprehensive endpoints for managing reinsurance operations including:
                    
                    - **Reference Data Management**: Countries, currencies, partners, occupancies, etc.
                    - **User Management**: Authentication, authorization, user profiles
                    - **Organizational Structure**: Locations, divisions, profit centers
                    - **Partner Management**: Reinsurers, cedants, brokers
                    
                    ## Authentication
                    
                    Most endpoints require authentication using JWT tokens. To authenticate:
                    1. Use the `/api/auth/login` endpoint with valid credentials
                    2. Include the returned JWT token in the `Authorization` header as `Bearer <token>`
                    
                    ## API Versioning
                    
                    The API follows RESTful conventions and uses URL-based versioning when necessary.
                    Current version: v1 (implicit in base URLs)
                    
                    ## Error Handling
                    
                    The API returns standard HTTP status codes and structured error responses:
                    - `400` - Bad Request (validation errors)
                    - `401` - Unauthorized (authentication required)
                    - `403` - Forbidden (insufficient permissions)
                    - `404` - Not Found (resource doesn't exist)
                    - `500` - Internal Server Error
                    """)
                .version("1.0.0")
                .contact(new Contact()
                    .name("RAMSYS Development Team")
                    .email("dev@ramsys-reinsurance.com")
                    .url("https://ramsys-reinsurance.com"))
                .license(new License()
                    .name("Proprietary")
                    .url("https://ramsys-reinsurance.com/license"));
    }
} 