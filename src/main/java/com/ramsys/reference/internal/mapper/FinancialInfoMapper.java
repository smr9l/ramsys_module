package com.ramsys.reference.internal.mapper;

import com.ramsys.reference.dto.FinancialInfoDto;
import com.ramsys.reference.model.embedded.FinancialInfo;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface FinancialInfoMapper {
    FinancialInfo toEntity(FinancialInfoDto dto);
    FinancialInfoDto toDto(FinancialInfo entity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    FinancialInfo partialUpdate(FinancialInfoDto dto, @MappingTarget FinancialInfo entity);
}

