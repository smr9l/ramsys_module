package com.ramsys.reference.internal.mapper;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.dto.LocationDTO;
import com.ramsys.reference.model.Location;
import com.ramsys.reference.model.PartnerType;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LocationMapper {

    LocationDTO toDto(Location entity);

    List<LocationDTO> toDtoList(List<Location> entities);

    ReferenceDTO toDto(PartnerType partnerType);
}