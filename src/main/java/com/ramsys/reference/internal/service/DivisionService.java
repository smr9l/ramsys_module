package com.ramsys.reference.internal.service;

import com.ramsys.reference.dto.DivisionDTO;
import com.ramsys.reference.internal.mapper.DivisionMapper;
import com.ramsys.reference.internal.repository.DivisionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class DivisionService {

    private final DivisionRepository divisionRepository;
    private final DivisionMapper divisionMapper;

    public List<DivisionDTO> getAllDivisions() {
        return divisionMapper.toDtoList(divisionRepository.findAll());
    }

    public Optional<DivisionDTO> getDivisionById(Long id) {
        return divisionRepository.findById(id).map(divisionMapper::toDto);
    }
} 