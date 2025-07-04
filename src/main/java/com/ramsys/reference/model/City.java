package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;

/**
 * Entité représentant les villes
 * Table: ref_city
 */
@Entity
@Table(name = "ref_city")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class City extends Auditable implements I18nEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_city_seq")
    @SequenceGenerator(name = "ref_city_seq", sequenceName = "ref_city_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "code", nullable = false, unique = true, length = 5)
    private String code;

    @Column(name = "name", nullable = false, length = 80)
    private String name;

    @Column(name = "name_fr", length = 80)
    private String nameFr;

    @Column(name = "name_en", length = 80)
    private String nameEn;

    @Column(name = "name_ar", length = 80)
    private String nameAr;

    // Relations
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "country_id", nullable = false)
    private Country country;

    @Override
    public String toString() {
        return "City{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", country=" + (country != null ? country.getName() : "null") +
                ", isActive=" + isActive() +
                '}';
    }
} 
