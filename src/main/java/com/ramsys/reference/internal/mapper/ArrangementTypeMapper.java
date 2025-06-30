package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.ArrangementTypeDTO;
import com.ramsys.reference.model.ArrangementType;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", uses = {LocalizedMapper.class},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ArrangementTypeMapper {

    @BeanMapping(resultType = ArrangementTypeDTO.class)
    ArrangementTypeDTO toDto(ArrangementType arrangementType);

} 