package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = {LocalizedMapper.class})
public interface CurrencyMapper {


} 