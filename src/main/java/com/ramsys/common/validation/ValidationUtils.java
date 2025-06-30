package com.ramsys.common.validation;

import com.ramsys.common.exception.ValidationException;
import com.ramsys.common.i18n.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
 * Utility class for common validation operations
 */
@Component
@RequiredArgsConstructor
public class ValidationUtils {

    private final MessageService messageService;

    /**
     * Validates that a string is not null or empty
     * @param value the value to validate
     * @param fieldName the field name for error messages
     * @throws ValidationException if the value is null or empty
     */
    public void validateRequired(String value, String fieldName) {
        if (!StringUtils.hasText(value)) {
            throw new ValidationException(messageService.getMessage("field.required", fieldName));
        }
    }

    /**
     * Validates that an ID is not null and greater than 0
     * @param id the ID to validate
     * @param entityName the entity name for error messages
     * @throws ValidationException if the ID is null or invalid
     */
    public void validateId(Long id, String entityName) {
        if (id == null || id <= 0) {
            throw new ValidationException(messageService.getMessage("reference.id.invalid", entityName, String.valueOf(id)));
        }
    }
}
