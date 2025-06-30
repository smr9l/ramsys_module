package com.ramsys.reference.web;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.PartnerApi;
import com.ramsys.reference.dto.CreatePartnerDTO;
import com.ramsys.reference.dto.PartnerDTO;
import com.ramsys.reference.dto.PartnerFilterDTO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference")
@RequiredArgsConstructor
public class PartnerController {

    private final PartnerApi partnerApi;

    @GetMapping("/partners")
    public Page<PartnerDTO> getAllPartners(PartnerFilterDTO filter, Pageable pageable) {
        return partnerApi.getAllPartners(filter, pageable);
    }

    @PostMapping("/partners")
    public ResponseEntity<PartnerDTO> createPartner(@Valid @RequestBody CreatePartnerDTO createPartnerDTO) {
        PartnerDTO createdPartner = partnerApi.createPartner(createPartnerDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdPartner);
    }


    @GetMapping("/partner-types")
    public List<ReferenceDTO> getAllPartnerTypes() {
        return partnerApi.getAllPartnerTypes();
    }

    @GetMapping("/partner-types/{id}")
    public ResponseEntity<ReferenceDTO> getPartnerTypeById(@PathVariable Long id) {
        return ResponseEntity.of(partnerApi.getPartnerTypeById(id));
    }
} 
