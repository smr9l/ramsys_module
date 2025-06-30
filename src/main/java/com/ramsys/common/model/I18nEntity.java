package com.ramsys.common.model;

import org.springframework.context.i18n.LocaleContextHolder;

import java.util.Locale;

public interface I18nEntity {

    Long getId();
    String getCode();
    Boolean getIsActive();

    String getNameFr();
    String getNameEn();
    String getNameAr();

    public default String getLocalizedName() {
        Locale locale = LocaleContextHolder.getLocale();
        return switch (locale.getLanguage()) {
            case "ar" -> getNameAr();
            case "en" -> getNameEn();
            case "fr" -> getNameFr();
            default -> getNameFr();
        };
    }

} 
