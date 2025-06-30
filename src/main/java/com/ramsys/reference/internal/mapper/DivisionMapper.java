package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.DivisionDTO;
import com.ramsys.reference.model.Division;
import org.mapstruct.BeanMapping;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = {LocalizedMapper.class})
public interface DivisionMapper {

    @BeanMapping(resultType = DivisionDTO.class)
    DivisionDTO toDto(Division entity);

    List<DivisionDTO> toDtoList(List<Division> entities);
} 