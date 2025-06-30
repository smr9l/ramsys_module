package com.ramsys.reference.internal.mapper;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.model.Region;
import org.mapstruct.Context;
import org.mapstruct.Mapper;

import java.util.List;
import java.util.Locale;

/**
 * Internal mapper for Region entities.
 * 
 * <p>This mapper is part of the internal implementation of the Reference module
 * and should not be accessed directly by other modules.</p>
 */
@Mapper(componentModel = "spring", uses = {LocalizedMapper.class})
public interface RegionMapper {

    ReferenceDTO toReferenceDto(Region region, @Context Locale locale);

    List<ReferenceDTO> toReferenceDtoList(List<Region> regions, @Context Locale locale);
}
