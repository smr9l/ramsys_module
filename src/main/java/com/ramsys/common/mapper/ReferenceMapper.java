package com.ramsys.common.mapper;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.model.I18nEntity;
import org.mapstruct.*;
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.List;
import java.util.Locale;

//@Mapper(componentModel = "spring", imports = { LocaleContextHolder.class },unmappedTargetPolicy = ReportingPolicy.IGNORE)
//public
interface ReferenceMapper {

    /** Mapping avec la locale courante (via LocaleContextHolder). */
    @Named("defaultLocale")
    @Mapping(target = "label",
            expression = "java(entity.getLocalizedName(LocaleContextHolder.getLocale()))")
    ReferenceDTO toReferenceDTO(I18nEntity entity);

    /** Mapping explicite avec une locale passée en contexte. */
    @Mapping(target = "label",
            expression = "java(entity.getLocalizedName(locale))")
    ReferenceDTO toReferenceDTO(I18nEntity entity, @Context Locale locale);

    /** Liste avec locale courante. */
    @IterableMapping(qualifiedByName = "defaultLocale")
    List<ReferenceDTO> toReferenceDTOList(List<? extends I18nEntity> entities);

    /** Liste avec locale explicite. */
     List<ReferenceDTO> toReferenceDTOList(List<? extends I18nEntity> entities, @Context Locale locale);


}
