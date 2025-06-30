package com.ramsys.common.mapper;

import java.util.List;

public interface BaseEntityMapper<E, D> {
    D toDto(E entity);
    E toEntity(D dto);

    List<D> toDtoList(List<E> entities);
    List<E> toEntityList(List<D> dtos);
} 
