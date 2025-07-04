package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;

/**
 * Entité représentant les types de partenaires
 * Table: ref_partner_type
 */
@Entity
@Table(name = "ref_partner_type")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PartnerType extends Auditable implements I18nEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_partner_type_seq")
    @SequenceGenerator(name = "ref_partner_type_seq", sequenceName = "ref_partner_type_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "code", nullable = false, unique = true, length = 20)
    private String code;

    @Column(name = "name", nullable = false, length = 80)
    private String name;

    @Column(name = "name_fr", length = 80)
    private String nameFr;

    @Column(name = "name_en", length = 80)
    private String nameEn;

    @Column(name = "name_ar", length = 80)
    private String nameAr;

    @Override
    public String toString() {
        return "PartnerType{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", isActive=" + isActive() +
                '}';
    }
} 
