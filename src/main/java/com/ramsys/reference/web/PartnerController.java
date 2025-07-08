package com.ramsys.reference.web;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.security.Authority;
import com.ramsys.reference.api.PartnerApi;
import com.ramsys.reference.dto.CreatePartnerDTO;
import com.ramsys.reference.dto.PartnerDTO;
import com.ramsys.reference.dto.PartnerFilterDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference")
@RequiredArgsConstructor
@Tag(name = "Partners", description = "Partner and partner type management endpoints")
@SecurityRequirement(name = "bearerAuth")
public class PartnerController {

    private final PartnerApi partnerApi;

    @GetMapping("/partners")
    @Operation(
        summary = "Get all partners",
        description = "Retrieve a paginated list of partners with optional filtering"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "Partners retrieved successfully",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Page.class)
            )
        )
    })
    @PreAuthorize(Authority.HAS_REF_PRT)
    public Page<PartnerDTO> getAllPartners( @ParameterObject
        @Parameter(description = "Filter criteria for partners") @Valid PartnerFilterDTO filter,
        @Parameter(description = "Pagination information") Pageable pageable
    ) {
        return partnerApi.getAllPartners(filter, pageable);
    }

    @GetMapping("/partners/{id}")
    @Operation(
        summary = "Get partner by ID",
        description = "Retrieve a specific partner by its ID"
    )
    @PreAuthorize(Authority.HAS_REF_PRT)
    public PartnerDTO getPartnerById(
        @Parameter(description = "Partner ID") @PathVariable Long id
    ) {
        return partnerApi.getPartnerById(id);
    }


    @PostMapping("/partners")
    @Operation(
        summary = "Create a new partner",
        description = "Create a new partner with the provided information"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "201",
            description = "Partner created successfully",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = PartnerDTO.class)
            )
        ),
        @ApiResponse(
            responseCode = "400",
            description = "Invalid partner data",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = com.ramsys.common.exception.ErrorResponse.class)
            )
        )
    })
    @PreAuthorize(Authority.HAS_REF_PRT)
    public ResponseEntity<PartnerDTO> createPartner(@Valid @RequestBody CreatePartnerDTO createPartnerDTO) {
        PartnerDTO createdPartner = partnerApi.createPartner(createPartnerDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdPartner);
    }

    @PutMapping("/partners/{id}")
    @Operation(
        summary = "Update an existing partner",
        description = "Update the details of an existing partner"
    )
    @PreAuthorize(Authority.HAS_REF_PRT)
    public ResponseEntity<PartnerDTO> updatePartner(
        @Parameter(description = "Partner ID") @PathVariable Long id,
        @Valid @RequestBody CreatePartnerDTO updatePartnerDTO
    ) {
        PartnerDTO updatedPartner = partnerApi.updatePartner(id, updatePartnerDTO);
        return ResponseEntity.ok(updatedPartner);
    }
    @DeleteMapping("/partners/{id}")
    @Operation(
        summary = "Delete a partner",
        description = "Delete a specific partner by its ID"
    )
    @PreAuthorize(Authority.HAS_REF_PRT)
    public ResponseEntity<Void> deletePartner(
        @Parameter(description = "Partner ID") @PathVariable Long id
    ) {
        partnerApi.deactivatePartner(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/partner-types")
    @Operation(
        summary = "Get all partner types",
        description = "Retrieve all available partner types"
    )
    @ApiResponse(
        responseCode = "200",
        description = "Partner types retrieved successfully"
    )
    @PreAuthorize(Authority.HAS_REF_PRT)
    public List<ReferenceDTO> getAllPartnerTypes() {
        return partnerApi.getAllPartnerTypes();
    }

    @GetMapping("/partner-types/{id}")
    @Operation(
        summary = "Get partner type by ID",
        description = "Retrieve a specific partner type by its ID"
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "Partner type found",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = ReferenceDTO.class)
            )
        ),
        @ApiResponse(
            responseCode = "404",
            description = "Partner type not found"
        )
    })
    @PreAuthorize(Authority.HAS_REF_PRT)
    public ResponseEntity<ReferenceDTO> getPartnerTypeById(
        @Parameter(description = "Partner type ID") @PathVariable Long id
    ) {
        return ResponseEntity.of(partnerApi.getPartnerTypeById(id));
    }
    
    @GetMapping("/partner-ratings")
    @Operation(
        summary = "Get all partner ratings",
        description = "Retrieve all available partner ratings"
    )
    @ApiResponse(
        responseCode = "200",
        description = "Partner ratings retrieved successfully"
    )
    @PreAuthorize(Authority.HAS_REF_PRT)
    public List<ReferenceDTO> getPartnerRatings() {
        return partnerApi.getPartnerRatings();
    }
}
