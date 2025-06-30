package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.OccupancyDTO;
import com.ramsys.reference.model.Occupancy;
import org.mapstruct.Mapper;

import java.util.List;

/**
 * Internal mapper for Occupancy entities.
 */
@Mapper(componentModel = "spring", uses = {LocalizedMapper.class})
public interface OccupancyMapper {

     OccupancyDTO toDto(Occupancy occupancy);

    List<OccupancyDTO> toDtoList(List<Occupancy> occupancies);
}
