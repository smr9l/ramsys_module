package com.ramsys.reference.web;

import com.ramsys.common.security.Authority;
import com.ramsys.reference.api.InsuredApi;
import com.ramsys.reference.dto.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

/**
 * Contrôleur REST pour la gestion des assurés
 */
@RestController
@RequestMapping("/api/v1/insureds")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Insured Management", description = "API pour la gestion des assurés")
public class InsuredController {

    private final InsuredApi insuredApi;

    /**
     * Récupère la liste paginée et filtrée des assurés
     */
    @GetMapping
    @Operation(summary = "Récupération de la liste des assurés", description = "Récupère une liste paginée et filtrée des assurés")
    @PreAuthorize(Authority.HAS_REF_INS)
    public ResponseEntity<Page<InsuredDTO>> getAllInsureds( InsuredFilterDTO filter,

            @PageableDefault(size = 20) Pageable pageable) {

        log.info("Récupération de la liste des assurés avec terme de recherche: {}", filter.getSearchTerm());


        Page<InsuredDTO> insureds = insuredApi.getAllInsureds(filter, pageable);
        return ResponseEntity.ok(insureds);
    }

    /**
     * Récupère la liste des assurés actifs (pour les dropdowns)
     */
    @GetMapping("/active")
    @Operation(summary = "Récupération des assurés actifs", description = "Récupère une liste des assurés actifs pour les dropdowns")
    @PreAuthorize(Authority.HAS_REF_INS)
    public ResponseEntity<List<InsuredSummaryDTO>> getActiveInsureds() {
        log.info("Récupération des assurés actifs");
        List<InsuredSummaryDTO> insureds = insuredApi.getActiveInsuredsSummary();
        return ResponseEntity.ok(insureds);
    }

    /**
     * Récupère un assuré par son ID
     */
    @GetMapping("/{id}")
    @Operation(summary = "Récupération d'un assuré par ID", description = "Récupère un assuré spécifique par son identifiant")
    @PreAuthorize(Authority.HAS_REF_INS)
    public ResponseEntity<InsuredDTO> getInsuredById(@PathVariable @NotNull Long id) {
        log.info("Récupération de l'assuré avec ID: {}", id);
        InsuredDTO insured = insuredApi.getInsuredById(id);
        return ResponseEntity.ok(insured);
    }

    /**
     * Recherche d'assurés par terme
     */
    @GetMapping("/search")
    @Operation(summary = "Recherche d'assurés", description = "Recherche des assurés par nom ou nom court")
    @PreAuthorize(Authority.HAS_REF_INS)
    public ResponseEntity<List<InsuredDTO>> searchInsureds(@RequestParam String searchTerm) {
        log.info("Recherche d'assurés avec terme: {}", searchTerm);
        List<InsuredDTO> insureds = insuredApi.searchInsureds(searchTerm);
        return ResponseEntity.ok(insureds);
    }

    /**
     * Crée un nouvel assuré
     */
    @PostMapping
    @Operation(summary = "Création d'un nouvel assuré", description = "Crée un nouvel assuré dans le système")
    @PreAuthorize(Authority.HAS_REF_INS)
    public ResponseEntity<InsuredDTO> createInsured(@Valid @RequestBody CreateInsuredDTO createInsuredDTO) {
        log.info("Création d'un nouvel assuré: {}", createInsuredDTO.getName());
        InsuredDTO createdInsured = insuredApi.createInsured(createInsuredDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdInsured);
    }

    /**
     * Met à jour un assuré existant
     */
    @PutMapping("/{id}")
    @Operation(summary = "Mise à jour d'un assuré", description = "Met à jour les informations d'un assuré existant")
    @PreAuthorize(Authority.HAS_REF_INS)
    public ResponseEntity<InsuredDTO> updateInsured(@PathVariable @NotNull Long id, @Valid @RequestBody CreateInsuredDTO updateInsuredDTO) {
        log.info("Mise à jour de l'assuré avec ID: {}", id);
        InsuredDTO updatedInsured = insuredApi.updateInsured(id, updateInsuredDTO);
        return ResponseEntity.ok(updatedInsured);
    }

    /**
     * Désactive un assuré
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "Désactivation d'un assuré", description = "Désactive un assuré (soft delete)")
    @PreAuthorize(Authority.HAS_REF_INS)
    public ResponseEntity<Void> deactivateInsured(@PathVariable @NotNull Long id) {
        log.info("Désactivation de l'assuré avec ID: {}", id);
        insuredApi.deactivateInsured(id);
        return ResponseEntity.noContent().build();
    }


} 