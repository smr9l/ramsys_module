package com.ramsys.config;

import io.swagger.v3.oas.models.Operation;
import io.swagger.v3.oas.models.parameters.Parameter;
import io.swagger.v3.oas.models.media.StringSchema;
import org.springdoc.core.customizers.OperationCustomizer;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;

import java.util.List;

/**
 * Global operation customizer that adds common headers to all API operations.
 * This ensures that the Accept-Language header appears in all Swagger UI endpoints.
 */
@Component
public class SwaggerHeaderInterceptor implements OperationCustomizer {

    @Override
    public Operation customize(Operation operation, HandlerMethod handlerMethod) {
        Parameter acceptLanguageParam = new Parameter()
                .in("header")
                .name("Accept-Language")
                .description("Preferred language for response content (e.g., 'fr', 'en', 'ar')")
                .required(false)
                .schema(new StringSchema()
                        ._default("fr")
                        .example("fr")
                        ._enum(List.of("fr", "en", "ar"))
                );

        operation.addParametersItem(acceptLanguageParam);
        return operation;
    }
} 