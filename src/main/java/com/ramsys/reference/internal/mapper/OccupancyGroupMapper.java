package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.OccupancyGroupDTO;
import com.ramsys.reference.model.OccupancyGroup;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * Internal mapper for OccupancyGroup entities.
 */
@Mapper(componentModel = "spring", uses = {LocalizedMapper.class, OccupancyMapper.class})
public interface OccupancyGroupMapper {
    @Mapping(target = "label", expression = "java(group.getLocalizedName())")
    OccupancyGroupDTO toDto(OccupancyGroup group);

    List<OccupancyGroupDTO> toDtoList(List<OccupancyGroup> groups);
}
