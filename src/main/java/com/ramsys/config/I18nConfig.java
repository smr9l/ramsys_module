package com.ramsys.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

import java.util.Arrays;
import java.util.Locale;

/**
 * Configuration pour l'internationalisation
 */
@Configuration
public class I18nConfig {

    /**
     * Configuration du MessageSource pour les messages traduits
     */
    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("classpath:messages/messages");
        messageSource.setDefaultEncoding("UTF-8");
        messageSource.setDefaultLocale(Locale.FRENCH);
        messageSource.setFallbackToSystemLocale(false);
        return messageSource;
    }

    /**
     * Résolveur de locale basé sur le header Accept-Language
     */
    @Bean
    public LocaleResolver localeResolver() {
        AcceptHeaderLocaleResolver localeResolver = new AcceptHeaderLocaleResolver();
        localeResolver.setSupportedLocales(Arrays.asList(
            Locale.FRENCH,
            Locale.ENGLISH,
            new Locale("ar") // Arabe
        ));
        localeResolver.setDefaultLocale(Locale.FRENCH);
        return localeResolver;
    }



} 
