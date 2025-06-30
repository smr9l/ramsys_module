package com.ramsys.common.i18n;

import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import java.util.Locale;

/**
 * Service pour la gestion des messages internationalisés
 */
@Service
@RequiredArgsConstructor
public class MessageService {

    private final MessageSource messageSource;

    /**
     * Récupère un message traduit avec la locale courante
     * @param key La clé du message
     * @param args Les arguments du message
     * @return Le message traduit
     */
    public String getMessage(String key, Object... args) {
        return getMessage(key, LocaleContextHolder.getLocale(), args);
    }

    /**
     * Récupère un message traduit avec une locale spécifique
     * @param key La clé du message
     * @param locale La locale
     * @param args Les arguments du message
     * @return Le message traduit
     */
    public String getMessage(String key, Locale locale, Object... args) {
        try {
            return messageSource.getMessage(key, args, locale);
        } catch (Exception e) {
            // Fallback en cas d'erreur
            return key;
        }
    }

    /**
     * Récupère un message traduit avec une valeur par défaut
     * @param key La clé du message
     * @param defaultMessage Le message par défaut
     * @param args Les arguments du message
     * @return Le message traduit ou le message par défaut
     */
    public String getMessageWithDefault(String key, String defaultMessage, Object... args) {
        return messageSource.getMessage(key, args, defaultMessage, LocaleContextHolder.getLocale());
    }
} 
