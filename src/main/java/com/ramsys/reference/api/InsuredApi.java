package com.ramsys.reference.api;

import com.ramsys.reference.dto.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

/**
 * API publique pour la gestion des assurés
 */
public interface InsuredApi {

    /**
     * Retrieves a paginated and filtered list of insureds.
     * This is the primary method for searching and listing insureds.
     *
     * @param filter A DTO containing all possible filter criteria (searchTerm, type, occupancy, country, etc.).
     * @param pageable Pagination information (page, size, sort).
     * @return A page of InsuredDTOs matching the criteria.
     */
    Page<InsuredDTO> getAllInsureds(InsuredFilterDTO filter, Pageable pageable);

    /**
     * Retrieves a lightweight list of all active insureds, suitable for dropdowns.
     *
     * @return A list of InsuredSummaryDTO objects.
     */
    List<InsuredSummaryDTO> getActiveInsuredsSummary();

    /**
     * Retrieves a single insured by its unique ID.
     *
     * @param id The unique identifier of the insured.
     * @return The full InsuredDTO.
     */
    InsuredDTO getInsuredById(Long id);


    /**
     * Searches insureds by term (name or short name).
     *
     * @param searchTerm The search term.
     * @return A list of matching InsuredDTOs.
     */
    List<InsuredDTO> searchInsureds(String searchTerm);

    /**
     * Creates a new insured.
     *
     * @param createInsuredDTO The DTO containing the data for the new insured.
     * @return The newly created InsuredDTO, including its generated ID.
     */
    InsuredDTO createInsured(CreateInsuredDTO createInsuredDTO);

    /**
     * Updates an existing insured.
     *
     * @param id The ID of the insured to update.
     * @param updateInsuredDTO The DTO containing the fields to update.
     * @return The updated InsuredDTO.
     */
    InsuredDTO updateInsured(Long id, CreateInsuredDTO updateInsuredDTO);

    /**
     * Deactivates an insured.
     *
     * @param id The ID of the insured to deactivate.
     */
    void deactivateInsured(Long id);
} 