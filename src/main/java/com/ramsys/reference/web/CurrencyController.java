package com.ramsys.reference.web;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.reference.api.CurrencyApi;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Locale;

/**
 * REST Controller for Currency reference data.
 * 
 * <p>This controller provides HTTP endpoints for accessing currency information.
 * It's part of the public web API of the Reference module.</p>
 */
@RestController
@RequestMapping("/api/reference/currencies")
@RequiredArgsConstructor
public class CurrencyController {

    private final CurrencyApi currencyApi;

    /**
     * Get all active currencies
     * 
     * @return list of currency reference data
     */
    @GetMapping
    public List<ReferenceDTO> getAllCurrencies() {
        return currencyApi.getAllCurrencies();
    }
    

    @GetMapping("/{code}")
    public ResponseEntity<ReferenceDTO> getCurrencyByCode(@PathVariable String code) {
        return ResponseEntity.of(currencyApi.getCurrencyByCode(code));
    }
}
