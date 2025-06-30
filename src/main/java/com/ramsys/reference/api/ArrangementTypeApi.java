package com.ramsys.reference.api;

import com.ramsys.common.dto.ReferenceDTO;

import java.util.List;
import java.util.Optional;

/**
 * Public API for managing Arrangement Types.
 */
public interface ArrangementTypeApi {

    /**
     * Get all arrangement types as a list of reference DTOs.
     */
    List<ReferenceDTO> getAllArrangementTypes();

    /**
     * Get a specific arrangement type by its ID.
     */
    Optional<ReferenceDTO> getArrangementTypeById(Long id);

   // TODO add findbyCriteria filter method


} 