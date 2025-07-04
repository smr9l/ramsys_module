package com.ramsys.reference.internal.mapper;

import com.ramsys.reference.dto.AddressInfoDto;
import com.ramsys.reference.model.embedded.AddressInfo;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface AddressInfoMapper {
    AddressInfo toEntity(AddressInfoDto dto);
    AddressInfoDto toDto(AddressInfo entity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    AddressInfo partialUpdate(AddressInfoDto dto, @MappingTarget AddressInfo entity);
}

