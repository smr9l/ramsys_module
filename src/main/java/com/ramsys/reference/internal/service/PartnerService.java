// C:/Users/hp/IdeaProjects/ramsys-backend/ramsys-reference/src/main/java/com/ramsys/reference/internal/service/PartnerService.java
package com.ramsys.reference.internal.service;

import com.ramsys.common.exception.BusinessException;
import com.ramsys.common.i18n.MessageService;
import com.ramsys.reference.dto.CreatePartnerDTO;
import com.ramsys.reference.dto.PartnerDTO;
import com.ramsys.reference.dto.PartnerFilterDTO;
import com.ramsys.reference.dto.PartnerSummaryDto;
import com.ramsys.reference.dto.UpdatePartnerDTO;
import com.ramsys.reference.internal.mapper.PartnerMapper;
import com.ramsys.reference.internal.repository.*;
import com.ramsys.reference.internal.specification.PartnerSpecification;
import com.ramsys.reference.model.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PartnerService {
    private final PartnerRepository partnerRepository;
    private final PartnerMapper partnerMapper;
    private final PartnerTypeRepository partnerTypeRepository;
    private final RegionRepository regionRepository;
    private final CountryRepository countryRepository;
    private final CurrencyRepository currencyRepository;
    private final MessageService messageService;
    private final PartnerSpecification partnerSpecification; // Inject the specification builder

    /**
     * Retrieves a paginated and filtered list of partners.
     * @param filter The filter criteria.
     * @param pageable Pagination information.
     * @return A page of PartnerDTOs.
     */
    public Page<PartnerDTO> getAllPartners(PartnerFilterDTO filter, Pageable pageable) {
        Specification<Partner> spec = partnerSpecification.fromFilter(filter);
        return partnerRepository.findAll(spec, pageable)
                .map(partnerMapper::toDto);
    }

    /**
     * Récupère tous les partenaires sous forme de PartnerDTO
     * @return Liste des partenaires en PartnerDTO
     */
    public List<PartnerSummaryDto> getActivePartners() {
        return partnerRepository.findActivePartners().stream().map(partnerMapper::toSummaryDto).collect(Collectors.toList());
    }

    /**
     * Récupère un partenaire par son ID
     * @param id L'ID du partenaire
     * @return Le partenaire en PartnerDTO
     */
    public PartnerDTO getPartnerById(Long id) {
        Partner partner = partnerRepository.findById(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage("partner.notfound", id)));
        return partnerMapper.toDto(partner);
    }

    public Optional<PartnerDTO> getPartnerByCode(String code) {
        return partnerRepository.findByCode(code).map(partnerMapper::toDto);
    }

    public List<PartnerDTO> searchPartners(String searchTerm) {
        return partnerRepository.searchByTerm(searchTerm).stream()
                .map(partnerMapper::toDto)
                .collect(Collectors.toList());
    }


    @Transactional
    public PartnerDTO updatePartner(Long id,  UpdatePartnerDTO updatePartnerDTO) {
        Partner partner = partnerRepository.findById(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage("partner.notfound", id)));
        partnerMapper.updateEntityFromDto(updatePartnerDTO, partner);
        // handle relations update here if necessary
        return partnerMapper.toDto(partnerRepository.save(partner));
    }

    public Optional<Partner> findPartnerById(Long id) {
        return partnerRepository.findById(id);
    }


    /**
     * Crée un nouveau partenaire
     * @param createPartnerDTO Les données du partenaire à créer
     * @return Le partenaire créé en PartnerDTO
     */
    @Transactional
    public PartnerDTO createPartner(CreatePartnerDTO createPartnerDTO) {

        // Conversion du DTO vers l'entité
        Partner partner = partnerMapper.toEntity(createPartnerDTO);

        // Récupération et validation des entités référencées
        PartnerType partnerType = findByIdOrThrow(partnerTypeRepository, createPartnerDTO.getPartnerTypeId(), "partner.partnertype.notfound", createPartnerDTO.getPartnerTypeId());
        Region region = findByIdOrThrow(regionRepository, createPartnerDTO.getRegionId(), "partner.region.notfound", createPartnerDTO.getRegionId());
        Country country = findByIdOrThrow(countryRepository, createPartnerDTO.getCountryId(), "partner.country.notfound", createPartnerDTO.getCountryId());
        Currency currency = findByIdOrThrow(currencyRepository, createPartnerDTO.getCurrencyId(), "partner.currency.notfound", createPartnerDTO.getCurrencyId());
        
        // Validation de la cohérence région/pays
        if (!country.getRegion().getId().equals(region.getId())) {
            throw new BusinessException(messageService.getMessage("partner.country.region.mismatch"));
        }
        
        partner.setPartnerType(partnerType);
        partner.setRegion(region);
        partner.setCountry(country);
        partner.setCurrency(currency);

        // Gestion du partenaire parent (optionnel)
        Optional.ofNullable(createPartnerDTO.getParentPartnerId()).ifPresent(parentId -> {
            Partner parentPartner = findByIdOrThrow(partnerRepository, parentId, "partner.parent.notfound", parentId);
            partner.setParentPartner(parentPartner);
        });

        Partner savedPartner = partnerRepository.save(partner);
        return partnerMapper.toDto(savedPartner);
    }

    private <T> T findByIdOrThrow(JpaRepository<T, Long> repository, Long id, String messageKey, Object... args) {
        return repository.findById(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage(messageKey, args)));
    }


    public void save(Partner partner) {
        if (partner == null) {
            throw new BusinessException(messageService.getMessage("partner.null"));
        }
        partnerRepository.save(partner);
    }
}