package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.ArrangementTypeApi;
import com.ramsys.reference.internal.mapper.ArrangementTypeMapper;
import com.ramsys.reference.internal.repository.ArrangementTypeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
class ArrangementTypeService implements ArrangementTypeApi {

    private final ArrangementTypeRepository arrangementTypeRepository;
    private final ArrangementTypeMapper arrangementTypeMapper;

    @Override
    public List<ReferenceDTO> getAllArrangementTypes() {
        return arrangementTypeRepository.findAll().stream()
                .map(arrangementTypeMapper::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<ReferenceDTO> getArrangementTypeById(Long id) {
        return arrangementTypeRepository.findById(id)
                .map(arrangementTypeMapper::toDto);
    }


} 
