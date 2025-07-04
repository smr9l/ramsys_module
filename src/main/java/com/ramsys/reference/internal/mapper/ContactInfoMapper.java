package com.ramsys.reference.internal.mapper;

import com.ramsys.reference.dto.ContactInfoDto;
import com.ramsys.reference.model.embedded.ContactInfo;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)
public interface ContactInfoMapper {
    ContactInfo toEntity(ContactInfoDto contactInfoDto);

    ContactInfoDto toDto(ContactInfo contactInfo);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    ContactInfo partialUpdate(ContactInfoDto contactInfoDto, @MappingTarget ContactInfo contactInfo);
}