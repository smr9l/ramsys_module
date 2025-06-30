package com.ramsys.reference.internal.api;

import com.ramsys.reference.api.OrganizationalApi;
import com.ramsys.reference.dto.DivisionDTO;
import com.ramsys.reference.dto.LocationDTO;
import com.ramsys.reference.dto.ProfitCenterDTO;
import com.ramsys.reference.internal.service.DivisionService;
import com.ramsys.reference.internal.service.LocationService;
import com.ramsys.reference.internal.service.ProfitCenterService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class OrganizationalApiImpl implements OrganizationalApi {

    private final LocationService locationService;
    private final DivisionService divisionService;
    private final ProfitCenterService profitCenterService;

    @Override
    public List<LocationDTO> findAllLocations() {
        return locationService.getAllLocations();
    }

    @Override
    public Optional<LocationDTO> findLocationById(Long id) {
        return locationService.getLocationById(id);
    }

    @Override
    public List<DivisionDTO> findAllDivisions() {
        return divisionService.getAllDivisions();
    }

    @Override
    public Optional<DivisionDTO> findDivisionById(Long id) {
        return divisionService.getDivisionById(id);
    }

    @Override
    public List<ProfitCenterDTO> findAllProfitCenters() {
        return profitCenterService.getAllProfitCenters();
    }

    @Override
    public Optional<ProfitCenterDTO> findProfitCenterById(Long id) {
        return profitCenterService.getProfitCenterById(id);
    }
} 