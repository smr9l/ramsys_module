package com.ramsys.common.exception;

import com.ramsys.common.i18n.MessageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
@RequiredArgsConstructor
@Slf4j
public class GlobalExceptionHandler {

    private final MessageService messageService;    /**
     * Gestion des erreurs de validation Bean Validation
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();

            // Utiliser le MessageSource de Spring pour interpoler les messages
            if (error instanceof FieldError fieldError) {
                try {
                    // Récupérer les codes d'erreur et arguments pour l'interpolation
                    String[] codes = fieldError.getCodes();
                    Object[] arguments = fieldError.getArguments();

                    // Essayer d'utiliser MessageSource pour résoudre le message avec interpolation
                    if (codes != null && codes.length > 0) {
                        for (String code : codes) {
                            try {
                                String resolvedMessage = messageService.getMessage(code, arguments);
                                if (resolvedMessage != null && !resolvedMessage.equals(code)) {
                                    errorMessage = resolvedMessage;
                                    break;
                                }
                            } catch (Exception ignored) {
                                // Continuer avec le message par défaut
                            }
                        }
                    }

                    // Si l'interpolation n'a pas fonctionné, essayer une interpolation simple
                    if (errorMessage != null && errorMessage.contains("{0}") && arguments != null && arguments.length > 2) {
                        // Pour @Size, l'argument max est généralement à l'index 2
                        Object maxValue = arguments[2];
                        if (maxValue != null) {
                            errorMessage = errorMessage.replace("{0}", maxValue.toString());
                        }
                    }
                } catch (Exception e) {
                    log.debug("Erreur lors de l'interpolation du message de validation: {}", e.getMessage());
                }
            }

            errors.put(fieldName, errorMessage);
        });

        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.BAD_REQUEST.value())
                .error(messageService.getMessage("validation.error"))
                .message(messageService.getMessage("validation.message"))
                .validationErrors(errors)
                .build();

        log.warn("Erreur de validation: {}", errors);
        return ResponseEntity.badRequest().body(errorResponse);
    }

    /**
     * Gestion des erreurs de données de référence introuvables
     */
    @ExceptionHandler(ReferenceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleReferenceNotFoundException(ReferenceNotFoundException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.NOT_FOUND.value())
                .error(messageService.getMessage("reference.data.notfound"))
                .message(ex.getMessage())
                .build();

        log.warn("Données de référence introuvables: {}", ex.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
    }

    /**
     * Gestion des erreurs métier personnalisées (BusinessException)
     */
    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ErrorResponse> handleBusinessException(BusinessException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.BAD_REQUEST.value())
                .error(messageService.getMessage("business.error"))
                .message(ex.getMessage())
                .build();

        log.warn("Erreur métier: {}", ex.getMessage());
        return ResponseEntity.badRequest().body(errorResponse);
    }

    /**
     * Gestion des erreurs métier (IllegalArgumentException) - Pour compatibilité
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegalArgumentException(IllegalArgumentException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.BAD_REQUEST.value())
                .error(messageService.getMessage("business.error"))
                .message(ex.getMessage())
                .build();

        log.warn("Erreur métier (IllegalArgumentException): {}", ex.getMessage());
        return ResponseEntity.badRequest().body(errorResponse);
    }

    /**
     * Gestion des erreurs d'authentification (BadCredentialsException)
     */
    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<ErrorResponse> handleBadCredentialsException(BadCredentialsException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.UNAUTHORIZED.value())
                .error(messageService.getMessage("auth.invalid.credentials"))
                .message(messageService.getMessage("auth.invalid.credentials"))
                .build();

        log.warn("Tentative d'authentification avec des identifiants invalides");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
    }

    /**
     * Gestion des erreurs d'utilisateur désactivé (DisabledException)
     */
    @ExceptionHandler(DisabledException.class)
    public ResponseEntity<ErrorResponse> handleDisabledException(DisabledException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.UNAUTHORIZED.value())
                .error(messageService.getMessage("auth.user.disabled"))
                .message(messageService.getMessage("auth.user.disabled"))
                .build();

        log.warn("Tentative d'authentification d'un utilisateur désactivé");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
    }

    /**
     * Gestion des erreurs d'utilisateur verrouillé (LockedException)
     */
    @ExceptionHandler(LockedException.class)
    public ResponseEntity<ErrorResponse> handleLockedException(LockedException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.UNAUTHORIZED.value())
                .error(messageService.getMessage("auth.user.locked"))
                .message(messageService.getMessage("auth.user.locked"))
                .build();

        log.warn("Tentative d'authentification d'un utilisateur verrouillé");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
    }

    /**
     * Gestion des erreurs d'utilisateur introuvable (UsernameNotFoundException)
     */
    @ExceptionHandler(UsernameNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleUsernameNotFoundException(UsernameNotFoundException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.UNAUTHORIZED.value())
                .error(messageService.getMessage("auth.invalid.credentials"))
                .message(messageService.getMessage("auth.invalid.credentials"))
                .build();

        log.warn("Tentative d'authentification avec un nom d'utilisateur inexistant: {}", ex.getMessage());
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
    }

    /**
     * Gestion générique des erreurs d'authentification
     */
    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<ErrorResponse> handleAuthenticationException(AuthenticationException ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.UNAUTHORIZED.value())
                .error(messageService.getMessage("auth.invalid.credentials"))
                .message(messageService.getMessage("auth.invalid.credentials"))
                .build();

        log.warn("Erreur d'authentification: {}", ex.getMessage());
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
    }



    /**
     * Gestion des erreurs génériques
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGenericException(Exception ex) {
        ErrorResponse errorResponse = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())
                .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                .error(messageService.getMessage("internal.error"))
                .message(messageService.getMessage("internal.message"))
                .build();

        log.error("Erreur inattendue", ex);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
    }
}

