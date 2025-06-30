package com.ramsys.reference.web;

import com.ramsys.reference.api.OrganizationalApi;
import com.ramsys.reference.dto.ProfitCenterDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference/profit-centers")
@RequiredArgsConstructor
public class ProfitCenterController {

    private final OrganizationalApi organizationalApi;

    @GetMapping
    public ResponseEntity<List<ProfitCenterDTO>> getAll() {
        return ResponseEntity.ok(organizationalApi.findAllProfitCenters());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProfitCenterDTO> getById(@PathVariable Long id) {
        return ResponseEntity.of(organizationalApi.findProfitCenterById(id));
    }
} 