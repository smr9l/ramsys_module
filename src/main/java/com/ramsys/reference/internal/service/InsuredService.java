package com.ramsys.reference.internal.service;

import com.ramsys.common.exception.BusinessException;
import com.ramsys.common.i18n.MessageService;
import com.ramsys.reference.dto.*;
import com.ramsys.reference.internal.mapper.InsuredMapper;
import com.ramsys.reference.internal.repository.*;
import com.ramsys.reference.internal.specification.InsuredSpecification;
import com.ramsys.reference.model.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
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

/**
 * Service pour la gestion des assurés
 */
@Service
@RequiredArgsConstructor
public class InsuredService {

    private final InsuredRepository insuredRepository;
    private final InsuredMapper insuredMapper;
    private final OccupancyRepository occupancyRepository;
    private final RegionRepository regionRepository;
    private final CountryRepository countryRepository;
    private final CityRepository cityRepository;
    private final PartnerRepository partnerRepository;
    private final MessageService messageService;
    private final InsuredSpecification insuredSpecification;

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * Retrieves a paginated and filtered list of insureds.
     * @param filter The filter criteria.
     * @param pageable Pagination information.
     * @return A page of InsuredDTOs.
     */
    public Page<InsuredDTO> getAllInsureds(InsuredFilterDTO filter, Pageable pageable) {
        Specification<Insured> spec = insuredSpecification.fromFilter(filter);
        return insuredRepository.findAll(spec, pageable)
                .map(insuredMapper::toDto);
    }

    /**
     * Récupère tous les assurés actifs sous forme de InsuredSummaryDTO
     * @return Liste des assurés actifs en InsuredSummaryDTO
     */
    public List<InsuredSummaryDTO> getActiveInsureds() {
        return insuredRepository.findByActiveTrue().stream()
                .map(insuredMapper::toSummaryDto)
                .collect(Collectors.toList());
    }

    /**
     * Récupère un assuré actif par son ID
     * @param id L'ID de l'assuré
     * @return L'assuré en InsuredDTO
     */
    public InsuredDTO getInsuredById(Long id) {
        Insured insured = insuredRepository.findByIdAndActiveTrue(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage("insured.notfound", id)));
        return insuredMapper.toDto(insured);
    }

    public Optional<InsuredDTO> getInsuredByName(String name) {
        return insuredRepository.findByName(name).map(insuredMapper::toDto);
    }

    public List<InsuredDTO> searchInsureds(String searchTerm) {
        return insuredRepository.searchByTerm(searchTerm).stream()
                .map(insuredMapper::toDto)
                .collect(Collectors.toList());
    }

    /**
     * Crée un nouvel assuré
     * @param createInsuredDTO Les données de l'assuré à créer
     * @return L'assuré créé en InsuredDTO
     */
    @Transactional
    public InsuredDTO createInsured(CreateInsuredDTO createInsuredDTO) {

        // Vérifier l'unicité du nom
        if (insuredRepository.existsByName(createInsuredDTO.getName())) {
            throw new BusinessException(messageService.getMessage("insured.name.already.exists", createInsuredDTO.getName()));
        }

        // Conversion du DTO vers l'entité
        Insured insured = insuredMapper.toEntity(createInsuredDTO);

        // Récupération et validation des entités référencées
        Occupancy occupancy = findByIdOrThrow(occupancyRepository, createInsuredDTO.getOccupancyId(), "insured.occupancy.notfound", createInsuredDTO.getOccupancyId());
        Region region = findByIdOrThrow(regionRepository, createInsuredDTO.getRegionId(), "insured.region.notfound", createInsuredDTO.getRegionId());
        Country country = findByIdOrThrow(countryRepository, createInsuredDTO.getCountryId(), "insured.country.notfound", createInsuredDTO.getCountryId());
        
        // Validation de la cohérence région/pays
        if (!country.getRegion().getId().equals(region.getId())) {
            throw new BusinessException(messageService.getMessage("insured.country.region.mismatch"));
        }
        
        insured.setOccupancy(occupancy);
        insured.setRegion(region);
        insured.setCountry(country);

        // Gestion de la ville (optionnelle)
        Optional.ofNullable(createInsuredDTO.getCityId()).ifPresent(cityId -> {
            City city = findByIdOrThrow(cityRepository, cityId, "insured.city.notfound", cityId);
            // Validation que la ville appartient au bon pays
            if (!city.getCountry().getId().equals(country.getId())) {
                throw new BusinessException(messageService.getMessage("insured.city.country.mismatch"));
            }
            insured.setCity(city);
        });

        // Gestion du partenaire (optionnel)
        Optional.ofNullable(createInsuredDTO.getPartnerId()).ifPresent(partnerId -> {
            Partner partner = findByIdOrThrow(partnerRepository, partnerId, "insured.partner.notfound", partnerId);
            insured.setPartner(partner);
        });

        Insured savedInsured = insuredRepository.save(insured);
        
        // Flush to ensure all changes are persisted
        entityManager.flush();
        
        return insuredMapper.toDto(savedInsured);
    }

    /**
     * Met à jour un assuré existant
     * @param id L'ID de l'assuré à mettre à jour
     * @param updateInsuredDTO Les nouvelles données
     * @return L'assuré mis à jour en InsuredDTO
     */
    @Transactional
    public InsuredDTO updateInsured(Long id, CreateInsuredDTO updateInsuredDTO) {
        Insured insured = insuredRepository.findById(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage("insured.notfound", id)));

        // Vérifier l'unicité du nom (sauf pour l'entité courante)
        if (!insured.getName().equals(updateInsuredDTO.getName()) && 
            insuredRepository.existsByName(updateInsuredDTO.getName())) {
            throw new BusinessException(messageService.getMessage("insured.name.already.exists", updateInsuredDTO.getName()));
        }

        insuredMapper.updateEntityFromDto(updateInsuredDTO, insured);
        
        // Mise à jour des relations (similaire à la création)
        updateInsuredRelations(insured, updateInsuredDTO);
        
        Insured savedInsured = insuredRepository.save(insured);
        
        // Flush to ensure all changes are persisted
        entityManager.flush();
        
        return insuredMapper.toDto(savedInsured);
    }

    /**
     * Désactive un assuré
     * @param id L'ID de l'assuré à désactiver
     */
    @Transactional
    public void deactivateInsured(Long id) {
        Insured insured = insuredRepository.findById(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage("insured.notfound", id)));
        
        insured.setActive(false);
        insuredRepository.save(insured);
        entityManager.flush();
    }

    private void updateInsuredRelations(Insured insured, CreateInsuredDTO dto) {
        // Update occupancy
        Occupancy occupancy = findByIdOrThrow(occupancyRepository, dto.getOccupancyId(), "insured.occupancy.notfound", dto.getOccupancyId());
        insured.setOccupancy(occupancy);

        // Update region and country
        Region region = findByIdOrThrow(regionRepository, dto.getRegionId(), "insured.region.notfound", dto.getRegionId());
        Country country = findByIdOrThrow(countryRepository, dto.getCountryId(), "insured.country.notfound", dto.getCountryId());
        
        // Validation de la cohérence région/pays
        if (!country.getRegion().getId().equals(region.getId())) {
            throw new BusinessException(messageService.getMessage("insured.country.region.mismatch"));
        }
        
        insured.setRegion(region);
        insured.setCountry(country);

        // Update city (optional)
        if (dto.getCityId() != null) {
            City city = findByIdOrThrow(cityRepository, dto.getCityId(), "insured.city.notfound", dto.getCityId());
            if (!city.getCountry().getId().equals(country.getId())) {
                throw new BusinessException(messageService.getMessage("insured.city.country.mismatch"));
            }
            insured.setCity(city);
        } else {
            insured.setCity(null);
        }

        // Update partner (optional)
        if (dto.getPartnerId() != null) {
            Partner partner = findByIdOrThrow(partnerRepository, dto.getPartnerId(), "insured.partner.notfound", dto.getPartnerId());
            insured.setPartner(partner);
        } else {
            insured.setPartner(null);
        }
    }

    private <T> T findByIdOrThrow(JpaRepository<T, Long> repository, Long id, String messageKey, Object... args) {
        return repository.findById(id)
                .orElseThrow(() -> new BusinessException(messageService.getMessage(messageKey, args)));
    }
} 