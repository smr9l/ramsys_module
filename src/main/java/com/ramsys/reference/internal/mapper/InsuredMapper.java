package com.ramsys.reference.internal.mapper;

import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.dto.CreateInsuredDTO;
import com.ramsys.reference.dto.InsuredDTO;
import com.ramsys.reference.dto.InsuredSummaryDTO;
import com.ramsys.reference.model.Insured;
import org.mapstruct.*;

import java.util.List;

/**
 * Mapper pour la conversion entre Insured entity et DTOs
 */
@Mapper(
    componentModel = "spring", 
    uses = {LocalizedMapper.class, ContactInfoMapper.class, AddressInfoMapper.class},
    unmappedTargetPolicy = ReportingPolicy.IGNORE
)
public interface InsuredMapper {

    /**
     * Convert an Insured entity to InsuredDTO
     */
    InsuredDTO toDto(Insured insured);
    
    /**
     * Convert CreateInsuredDTO to Insured entity
     */
    Insured toEntity(CreateInsuredDTO createInsuredDTO);

    /**
     * Update an existing Insured entity from CreateInsuredDTO
     */
    @Mapping(target = "id", ignore = true)
    void updateEntityFromDto(CreateInsuredDTO dto, @MappingTarget Insured entity);

    /**
     * Convert to summary DTO
     */
    @Mapping(target = "occupancyName", source = "occupancy.name")
    @Mapping(target = "countryName", source = "country.name")
    InsuredSummaryDTO toSummaryDto(Insured insured);

    /**
     * Convert list of entities to list of DTOs
     */
    List<InsuredDTO> toDtoList(List<Insured> insureds);

    /**
     * Convert list of entities to list of summary DTOs
     */
    List<InsuredSummaryDTO> toSummaryDtoList(List<Insured> insureds);
} 