package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;

/**
 * Entité représentant les secteurs d'activité
 * Table: ref_occupancy
 */
@Entity
@Table(name = "ref_occupancy")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Occupancy extends Auditable implements I18nEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_occupancy_seq")
    @SequenceGenerator(name = "ref_occupancy_seq", sequenceName = "ref_occupancy_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "code", nullable = false, unique = true, length = 4)
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
    @JoinColumn(name = "group_id", nullable = false)
    private OccupancyGroup group;

    @Override
    public String toString() {
        return "Occupancy{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", group=" + (group != null ? group.getName() : "null") +
                ", isActive=" + isActive() +
                '}';
    }
} 
