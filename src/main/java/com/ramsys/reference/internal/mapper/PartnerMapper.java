package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.CreatePartnerDTO;
import com.ramsys.reference.dto.PartnerDTO;
import com.ramsys.reference.dto.PartnerSummaryDto;
import com.ramsys.reference.model.Partner;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

/**
 * Internal mapper for Partner entities.
 * 
 * <p>This mapper is part of the internal implementation of the Reference module
 * and should not be accessed directly by other modules. It handles the conversion
 * between Partner entities and various DTOs.</p>
 */
@Mapper(componentModel = "spring", uses = {LocalizedMapper.class, ContactInfoMapper.class, AddressInfoMapper.class, FinancialInfoMapper.class})
public interface PartnerMapper  {

    /**
     * Convert a Partner entity to PartnerDTO
     */
    PartnerDTO toDto(Partner partner);
     Partner toEntity(CreatePartnerDTO createPartnerDTO);

    /**
     * Update an existing Partner entity from UpdatePartnerDTO
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "code", ignore = true)
    void updateEntityFromDto(CreatePartnerDTO dto, @MappingTarget Partner entity);

    PartnerSummaryDto toSummaryDto(Partner partner);
}
