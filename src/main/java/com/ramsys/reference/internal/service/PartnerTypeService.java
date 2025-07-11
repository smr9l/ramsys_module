package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.internal.repository.PartnerTypeRepository;
import com.ramsys.reference.model.PartnerType;
import com.ramsys.reference.model.PartnerTypeCodeEnum;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PartnerTypeService {

    private final PartnerTypeRepository partnerTypeRepository;
    private final LocalizedMapper referenceMapper;

    public List<ReferenceDTO> getAllPartnerTypes() {
        List<PartnerType> partnerTypes = partnerTypeRepository.findAll();
        return referenceMapper.toDtoList(partnerTypes);
    }

    public Optional<ReferenceDTO> getPartnerTypeById(Long id) {
        return partnerTypeRepository.findById(id).map(referenceMapper::toReferenceDTO);

    }

    public List<ReferenceDTO> getActivePartnerTypes(Locale locale) {
        List<PartnerType> partnerTypes = partnerTypeRepository.findByActiveTrue();
        return referenceMapper.toDtoList(partnerTypes, locale);
    }

    public boolean isType(@NotNull(message = "{partner.partnertype.required}") Long partnerTypeId, PartnerTypeCodeEnum partnerTypeCodeEnum) {
        return partnerTypeRepository.findById(partnerTypeId)
                .map(PartnerType::getCode)
                .map(code -> code.equals(partnerTypeCodeEnum.getCode()))
                .orElse(false);
    }
}
