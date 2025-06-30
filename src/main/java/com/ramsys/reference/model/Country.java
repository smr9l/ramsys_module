package com.ramsys.reference.model;

import com.ramsys.common.model.BaseEntity;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;

/**
 * Entité représentant les pays
 * Table: ref_country
 */
@Entity
@Table(name = "ref_country")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Country extends BaseEntity implements I18nEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_country_seq")
    @SequenceGenerator(name = "ref_country_seq", sequenceName = "ref_country_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "code", unique = true, nullable = false, length = 2)
    private String code;

    @Column(name = "name", nullable = false, length = 80)
    private String name;

    @Column(name = "name_fr", length = 80)
    private String nameFr;

    @Column(name = "name_en", length = 80)
    private String nameEn;

    @Column(name = "name_ar", length = 80)
    private String nameAr;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "region_id", nullable = false)
    private Region region;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private Boolean isActive = true;


    @Override
    public String toString() {
        return "Country{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", region=" + (region != null ? region.getName() : "null") +
                ", isActive=" + getIsActive() +
                '}';
    }
} 
