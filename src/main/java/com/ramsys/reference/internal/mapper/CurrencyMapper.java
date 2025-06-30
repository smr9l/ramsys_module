package com.ramsys.reference.internal.mapper;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.model.Currency;
import org.mapstruct.Context;
import org.mapstruct.Mapper;

import java.util.Locale;

@Mapper(componentModel = "spring", uses = {LocalizedMapper.class})
public interface CurrencyMapper {


} 