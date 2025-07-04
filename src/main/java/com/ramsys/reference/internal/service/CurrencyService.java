package com.ramsys.reference.internal.service;

import com.ramsys.common.dto.ReferenceDTO;
import com.ramsys.common.mapper.LocalizedMapper;
import com.ramsys.reference.api.CurrencyApi;
import com.ramsys.reference.internal.repository.CurrencyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
class CurrencyService implements CurrencyApi {

    private final CurrencyRepository currencyRepository;
    private final LocalizedMapper currencyMapper;

    @Override
    @Cacheable("currencies")
    public List<ReferenceDTO> getAllCurrencies() {
        return currencyRepository.findAllByActiveTrueOrderByCode().stream()
                .map(currency -> currencyMapper.toReferenceDTO(currency ))
                .collect(Collectors.toList());
    }

    @Override
    public Optional<ReferenceDTO> getCurrencyByCode(String code) {
        return currencyRepository.findByCode(code)
                .map(currency -> currencyMapper.toReferenceDTO(currency));
    }
}
