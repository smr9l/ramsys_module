package com.ramsys.reference.api;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.dto.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

/**
 * Public API for Partner and related reference data Management.
 */
public interface PartnerApi {

    /**
     * Retrieves a paginated and filtered list of partners.
     * This is the primary method for searching and listing partners.
     *
     * @param filter A DTO containing all possible filter criteria (searchTerm, type, country, etc.).
     * @param pageable Pagination information (page, size, sort).
     * @return A page of PartnerDTOs matching the criteria.
     */
    Page<PartnerDTO> getAllPartners(PartnerFilterDTO filter, Pageable pageable);

    /**
     * Retrieves a lightweight list of all active partners, suitable for dropdowns.
     *
     * @return A list of PartnerSummaryDto objects.
     */
    List<PartnerSummaryDto> getActivePartnersSummary();

    /**
     * Retrieves a single partner by its unique ID.
     *
     * @param id The unique identifier of the partner.
     * @return The full PartnerDTO.
     */
    PartnerDTO getPartnerById(Long id);

    /**
     * Creates a new partner.
     *
     * @param createPartnerDTO The DTO containing the data for the new partner.
     * @return The newly created PartnerDTO, including its generated ID.
     */
    PartnerDTO createPartner(CreatePartnerDTO createPartnerDTO);

    /**
     * Updates an existing partner.
     *
     * @param id The ID of the partner to update.
     * @param updatePartnerDTO The DTO containing the fields to update.
     * @return The updated PartnerDTO.
     */
    PartnerDTO updatePartner(Long id, CreatePartnerDTO updatePartnerDTO);

    /**
     * Deactivates a partner for a given reason.
     *
     * @param id The ID of the partner to deactivate.
     * @param reason The reason for deactivation, for auditing purposes.
     */
    void deactivatePartner(Long id);


    // --- Partner Type Methods ---

    /**
     * Retrieves all available partner types.
     *
     * @return A list of partner types as ReferenceDTOs.
     */
    List<ReferenceDTO> getAllPartnerTypes();

    /**
     * Retrieves a single partner type by its ID.
     *
     * @param id The ID of the partner type.
     * @return An Optional containing the ReferenceDTO if found.
     */
    Optional<ReferenceDTO> getPartnerTypeById(Long id);

    // --- Rating Methods ---

    /**
     * Retrieves all available partner ratings.
     *
     * @return A list of partner ratings as ReferenceDTOs.
     */
    List<ReferenceDTO> getPartnerRatings();
}