package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;

/**
 * Entité représentant les types d'arrangement
 * Table: ref_arrangement_type
 */
@Entity
@Table(name = "ref_arrangement_type")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ArrangementType extends Auditable implements I18nEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_arrangement_type_seq")
    @SequenceGenerator(name = "ref_arrangement_type_seq", sequenceName = "ref_arrangement_type_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "code", nullable = false, unique = true, length = 8)
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
    @JoinColumn(name = "portfolio_type_id", nullable = false)
    private PortfolioType portfolioType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contract_type_id", nullable = false)
    private ContractType contractType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "processing_type_id", nullable = false)
    private ProcessingType processingType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "business_type_id", nullable = false)
    private BusinessType businessType;



    @Override
    public String toString() {
        return "ArrangementType{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", portfolioType=" + (portfolioType != null ? portfolioType.getCode() : "null") +
                ", contractType=" + (contractType != null ? contractType.getCode() : "null") +
                ", isActive=" + getIsActive() +
                '}';
    }
} 
