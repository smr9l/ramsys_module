package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.CreatePartnerDTO;
import com.ramsys.reference.dto.PartnerDTO;
import com.ramsys.reference.dto.PartnerSummaryDto;
import com.ramsys.reference.dto.UpdatePartnerDTO;
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
@Mapper(componentModel = "spring",uses = {LocalizedMapper.class})
public interface PartnerMapper  {

    /**
     * Convert a Partner entity to PartnerDTO
     */
    PartnerDTO toDto(Partner partner);

    Partner toEntity(CreatePartnerDTO createPartnerDTO);

    /**
     * Update an existing Partner entity from UpdatePartnerDTO
     */
    void updateEntityFromDto(UpdatePartnerDTO dto, @MappingTarget Partner entity);

    PartnerSummaryDto toSummaryDto(Partner partner);
}
