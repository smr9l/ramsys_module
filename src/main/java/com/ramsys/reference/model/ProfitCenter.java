package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ref_profit_center")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProfitCenter extends Auditable  implements I18nEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_profit_center_seq")
    @SequenceGenerator(name = "ref_profit_center_seq", sequenceName = "ref_profit_center_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "name", nullable = false, length = 40)
    private String name;

    @Column(name = "name_fr", length = 40)
    private String nameFr;

    @Column(name = "name_en", length = 40)
    private String nameEn;

    @Column(name = "name_ar", length = 40)
    private String nameAr;

    @Column(unique = true, nullable = false, length = 2)
    private String code;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "location_id", nullable = false)
    private Location location;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "division_id", nullable = false)
    private Division division;

    @Column(name = "manager_id")
    private Long managerId;


}
