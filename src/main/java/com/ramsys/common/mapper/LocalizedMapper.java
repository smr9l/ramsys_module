package com.ramsys.common.mapper;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.model.I18nEntity;
import org.mapstruct.*;
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Mapper(componentModel = "spring",builder=@Builder(disableBuilder = true))
public interface LocalizedMapper {

    @Mapping(target = "label", expression = "java(entity.getLocalizedName())")
     ReferenceDTO toReferenceDTO(I18nEntity entity);



    /**
     * Converts a list of I18nEntities to a list of ReferenceDTOs using the current request's locale.
     * @param entities The list of entities to convert.
     * @return The list of converted ReferenceDTOs.
     */
    default List<ReferenceDTO> toDtoList(Iterable<? extends I18nEntity> entities) {
        return toDtoList(entities, LocaleContextHolder.getLocale());
    }

    default List<ReferenceDTO> toDtoList(Iterable<? extends I18nEntity> entities, @Context Locale locale) {
        return StreamSupport.stream(entities.spliterator(), false)
                .map(entity -> toReferenceDTO(entity))
                .collect(Collectors.toList());
    }
}