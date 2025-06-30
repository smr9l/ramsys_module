package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.CountryDTO;
import com.ramsys.reference.model.Country;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;
import java.util.Locale;


@Mapper(componentModel = "spring", uses = {LocalizedMapper.class, RegionMapper.class})
public interface CountryMapper {

    @Mapping(target = "label", expression = "java(country.getLocalizedName())")
    @Mapping(target = "region", source = "region")
    CountryDTO toDto(Country country);

    List<CountryDTO> toDtoList(List<Country> countries);
}

