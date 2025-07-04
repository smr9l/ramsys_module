package com.ramsys.reference.internal.api;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.exception.BusinessException;
import com.ramsys.reference.api.PartnerApi;
import com.ramsys.reference.dto.*;
import com.ramsys.reference.internal.service.PartnerService;
import com.ramsys.reference.internal.service.PartnerTypeService;
import com.ramsys.reference.model.Partner;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PartnerApiImpl implements PartnerApi {

    private final PartnerService partnerService;
    private final PartnerTypeService partnerTypeService;




    @Override
    public Page<PartnerDTO> getAllPartners(PartnerFilterDTO filter, Pageable pageable) {
        return partnerService.getAllPartners(filter, pageable);
    }

    @Override
    public List<PartnerSummaryDto> getActivePartnersSummary() {
        return List.of();
    }

    @Override
    public PartnerDTO getPartnerById(Long id) {
        return  partnerService.getPartnerById(id);
    }



    @Override
    @Transactional
    public PartnerDTO createPartner(CreatePartnerDTO createPartnerDTO) {
        return partnerService.createPartner(createPartnerDTO);
    }

    @Override
    @Transactional
    public PartnerDTO updatePartner(Long id, UpdatePartnerDTO updatePartnerDTO) {
        return partnerService.updatePartner(id, updatePartnerDTO);
    }

    @Override
    @Transactional
    public void deactivatePartner(Long id, String reason) {
        Partner partner = partnerService.findPartnerById(id)
                .orElseThrow(() -> new BusinessException("Partner not found with id: " + id));
        partner.setActive(false);
        partnerService.save(partner);
    }



    @Override
    public List<ReferenceDTO> getAllPartnerTypes() {
        return partnerTypeService.getAllPartnerTypes();
    }

    @Override
    public Optional<ReferenceDTO> getPartnerTypeById(Long id) {
        return partnerTypeService.getPartnerTypeById(id);
    }
}