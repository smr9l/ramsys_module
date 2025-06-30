package com.ramsys.reference.internal.service;

import com.ramsys.reference.dto.ProfitCenterDTO;
import com.ramsys.reference.internal.mapper.ProfitCenterMapper;
import com.ramsys.reference.internal.repository.ProfitCenterRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class ProfitCenterService {

    private final ProfitCenterRepository profitCenterRepository;
    private final ProfitCenterMapper profitCenterMapper;

    public List<ProfitCenterDTO> getAllProfitCenters() {
        return profitCenterMapper.toDtoList(profitCenterRepository.findAll());
    }

    public Optional<ProfitCenterDTO> getProfitCenterById(Long id) {
        return profitCenterRepository.findById(id).map(profitCenterMapper::toDto);
    }
} 