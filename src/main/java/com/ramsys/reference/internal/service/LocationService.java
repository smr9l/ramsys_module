package com.ramsys.reference.internal.service;

import com.ramsys.reference.dto.LocationDTO;
import com.ramsys.reference.internal.mapper.LocationMapper;
import com.ramsys.reference.internal.repository.LocationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class LocationService {

    private final LocationRepository locationRepository;
    private final LocationMapper locationMapper;

    public List<LocationDTO> getAllLocations() {
        return locationRepository.findAll().stream()
                .map(location -> locationMapper.toDto(location))
                .collect(java.util.stream.Collectors.toList());
    }

    public Optional<LocationDTO> getLocationById(Long id) {
        return locationRepository.findById(id).map(location -> locationMapper.toDto(location));
    }
} 