package com.ramsys.reference.internal.mapper;

import com.ramsys.reference.dto.ProfitCenterDTO;
import com.ramsys.reference.model.ProfitCenter;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ProfitCenterMapper {

    ProfitCenterDTO toDto(ProfitCenter entity);

    List<ProfitCenterDTO> toDtoList(List<ProfitCenter> entities);
} 