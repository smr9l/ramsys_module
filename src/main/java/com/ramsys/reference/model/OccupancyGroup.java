package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Entité représentant les groupes de secteurs d'activité
 * Table: ref_occupancy_group
 */
@Entity
@Table(name = "ref_occupancy_group")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OccupancyGroup extends Auditable implements I18nEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_occupancy_group_seq")
    @SequenceGenerator(name = "ref_occupancy_group_seq", sequenceName = "ref_occupancy_group_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "code", nullable = false, unique = true, length = 10)
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
    @OneToMany(mappedBy = "group", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @Builder.Default
    private List<Occupancy> occupancies = new ArrayList<>();

    @Override
    public String toString() {
        return "OccupancyGroup{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", occupanciesCount=" + (occupancies != null ? occupancies.size() : 0) +
                ", isActive=" + isActive() +
                '}';
    }
} 
