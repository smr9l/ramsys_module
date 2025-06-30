package com.ramsys.reference.internal.service;

import com.ramsys.common.exception.BusinessException;
import com.ramsys.common.i18n.MessageService;
import com.ramsys.reference.api.OccupancyApi;
import com.ramsys.reference.dto.OccupancyDTO;
import com.ramsys.reference.dto.OccupancyGroupDTO;
import com.ramsys.reference.internal.mapper.OccupancyGroupMapper;
import com.ramsys.reference.internal.mapper.OccupancyMapper;
import com.ramsys.reference.internal.repository.OccupancyGroupRepository;
import com.ramsys.reference.internal.repository.OccupancyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
class OccupancyService implements OccupancyApi {

    private final OccupancyRepository occupancyRepository;
    private final OccupancyGroupRepository occupancyGroupRepository;
    private final OccupancyMapper occupancyMapper;
    private final OccupancyGroupMapper occupancyGroupMapper;
    private final MessageService messageService;

    @Override
    public List<OccupancyGroupDTO> getAllOccupancyGroups() {
        return occupancyGroupMapper.toDtoList(occupancyGroupRepository.findAll());
    }

    @Override
    public List<OccupancyDTO> getOccupanciesByGroup(Long groupId) {
        return occupancyMapper.toDtoList(occupancyRepository.findByGroupId(groupId));
    }

    @Override
    public List<OccupancyDTO> getAllOccupancies() {
        return occupancyMapper.toDtoList(occupancyRepository.findAll());
    }

    @Override
    public OccupancyDTO getOccupancyById(Long id) {
        return occupancyRepository.findById(id).map(occupancyMapper::toDto) // Assuming you have a mapper
                .orElseThrow(() -> new BusinessException(messageService.getMessage("error.occupancy.notfound", new Object[]{id})));
    }


}


