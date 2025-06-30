package com.ramsys.reference.web;

import com.ramsys.reference.api.OrganizationalApi;
import com.ramsys.reference.dto.LocationDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference/locations")
@RequiredArgsConstructor
public class LocationController {

    private final OrganizationalApi organizationalApi;

    @GetMapping
    public ResponseEntity<List<LocationDTO>> getAll() {
        return ResponseEntity.ok(organizationalApi.findAllLocations());
    }

    @GetMapping("/{id}")
    public ResponseEntity<LocationDTO> getById(@PathVariable Long id) {
        return ResponseEntity.of(organizationalApi.findLocationById(id));
    }
} 