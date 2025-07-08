package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "ref_rating")

public class Rating extends Auditable implements I18nEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_rating_id_gen")
    @SequenceGenerator(name = "ref_rating_id_gen", sequenceName = "ref_rating_id_seq", allocationSize = 1)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 4)
    @NotNull
    @Column(name = "code", nullable = false, length = 4)
    private String code;

    @Size(max = 80)
    @NotNull
    @Column(name = "name", nullable = false, length = 80)
    private String name;

    @Size(max = 255)
    @Column(name = "description")
    private String description;

    @Size(max = 80)
    @Column(name = "name_fr", length = 80)
    private String nameFr;

    @Size(max = 80)
    @Column(name = "name_en", length = 80)
    private String nameEn;

    @Size(max = 80)
    @Column(name = "name_ar", length = 80)
    private String nameAr;

    @Column(name = "numeric_value")
    private Integer numericValue;


}