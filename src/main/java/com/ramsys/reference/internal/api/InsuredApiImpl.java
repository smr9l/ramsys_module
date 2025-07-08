package com.ramsys.reference.internal.api;

import com.ramsys.reference.api.InsuredApi;
import com.ramsys.reference.dto.*;
import com.ramsys.reference.internal.service.InsuredService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Implémentation de l'API publique pour la gestion des assurés
 */
@Service
@RequiredArgsConstructor
public class InsuredApiImpl implements InsuredApi {

    private final InsuredService insuredService;

    @Override
    public Page<InsuredDTO> getAllInsureds(InsuredFilterDTO filter, Pageable pageable) {
        return insuredService.getAllInsureds(filter, pageable);
    }

    @Override
    public List<InsuredSummaryDTO> getActiveInsuredsSummary() {
        return insuredService.getActiveInsureds();
    }

    @Override
    public InsuredDTO getInsuredById(Long id) {
        return insuredService.getInsuredById(id);
    }


    @Override
    public List<InsuredDTO> searchInsureds(String searchTerm) {
        return insuredService.searchInsureds(searchTerm);
    }

    @Override
    public InsuredDTO createInsured(CreateInsuredDTO createInsuredDTO) {
        return insuredService.createInsured(createInsuredDTO);
    }

    @Override
    public InsuredDTO updateInsured(Long id, CreateInsuredDTO updateInsuredDTO) {
        return insuredService.updateInsured(id, updateInsuredDTO);
    }

    @Override
    public void deactivateInsured(Long id) {
        insuredService.deactivateInsured(id);
    }
} 