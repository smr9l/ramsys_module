package com.ramsys.reference.web;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.ArrangementTypeApi;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reference")
@RequiredArgsConstructor
public class ArrangementTypeController {

    private final ArrangementTypeApi arrangementTypeApi;

    @GetMapping("/arrangement-types")
    public List<ReferenceDTO> getAllArrangementTypes() {
        return arrangementTypeApi.getAllArrangementTypes();
    }

    @GetMapping("/arrangement-types/{id}")
    public ResponseEntity<ReferenceDTO> getArrangementTypeById(@PathVariable Long id) {
        return ResponseEntity.of(arrangementTypeApi.getArrangementTypeById(id));
    }


} 
