package com.ramsys.reference.web;

import com.ramsys.reference.api.OrganizationalApi;
import com.ramsys.reference.dto.DivisionDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference/divisions")
@RequiredArgsConstructor
public class DivisionController {

    private final OrganizationalApi organizationalApi;

    @GetMapping
    public ResponseEntity<List<DivisionDTO>> getAll() {
        return ResponseEntity.ok(organizationalApi.findAllDivisions());
    }

    @GetMapping("/{id}")
    public ResponseEntity<DivisionDTO> getById(@PathVariable Long id) {
        return ResponseEntity.of(organizationalApi.findDivisionById(id));
    }
} 