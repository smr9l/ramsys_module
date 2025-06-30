package com.ramsys.common.exception;

/**
 * Exception for reference data not found errors
 */
public class ReferenceNotFoundException extends BusinessException {

    public ReferenceNotFoundException(String message) {
        super(message);
    }

    public ReferenceNotFoundException(String message, Object... args) {
        super(String.format(message, args));
    }

    public ReferenceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
