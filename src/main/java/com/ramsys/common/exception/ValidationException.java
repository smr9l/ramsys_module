package com.ramsys.common.exception;

/**
 * Exception for validation errors specific to business rules
 */
public class ValidationException extends BusinessException {

    public ValidationException(String message) {
        super(message);
    }

    public ValidationException(String message, Object... args) {
        super(String.format(message, args));
    }

    public ValidationException(String message, Throwable cause) {
        super(message, cause);
    }
}
