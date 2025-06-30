package com.ramsys.reference.api;

import com.ramsys.reference.dto.DivisionDTO;
import com.ramsys.reference.dto.LocationDTO;
import com.ramsys.reference.dto.ProfitCenterDTO;

import java.util.List;
import java.util.Optional;

/**
 * Public API for Organizational Structure Reference Data (Locations, Divisions, etc.).
 */
public interface OrganizationalApi {

    /**
     * Find all Locations.
     * @return a list of all locations.
     */
    List<LocationDTO> findAllLocations();

    /**
     * Find a Location by its ID.
     * @param id the location ID.
     * @return an optional containing the location if found.
     */
    Optional<LocationDTO> findLocationById(Long id);

    /**
     * Find all Divisions.
     * @return a list of all divisions.
     */
    List<DivisionDTO> findAllDivisions();

    /**
     * Find a Division by its ID.
     * @param id the division ID.
     * @return an optional containing the division if found.
     */
    Optional<DivisionDTO> findDivisionById(Long id);

    /**
     * Find all Profit Centers.
     * @return a list of all profit centers.
     */
    List<ProfitCenterDTO> findAllProfitCenters();

    /**
     * Find a Profit Center by its ID.
     * @param id the profit center ID.
     * @return an optional containing the profit center if found.
     */
    Optional<ProfitCenterDTO> findProfitCenterById(Long id);
} 