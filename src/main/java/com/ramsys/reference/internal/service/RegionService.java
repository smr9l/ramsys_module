package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.model.Region;
import com.ramsys.reference.internal.repository.RegionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RegionService {
    private final RegionRepository regionRepository;
    private final LocalizedMapper localizedMapper;

    /**
     * Récupère toutes les régions sous forme de ReferenceDTO
     * @return Liste des régions en ReferenceDTO
     */
    public List<ReferenceDTO> getAllRegionsAsReferenceDTO() {
        return localizedMapper.toDtoList(regionRepository.findAll());
    }
    
    /**
     * Récupère toutes les régions (entités)
     * @return Liste des entités Region
     */
    public List<Region> getAllRegions() {
        return regionRepository.findAll();
    }
} 
