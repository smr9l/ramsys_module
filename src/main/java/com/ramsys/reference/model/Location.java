package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "ref_location")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Location extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_location_seq")
    @SequenceGenerator(name = "ref_location_seq", sequenceName = "ref_location_id_seq", allocationSize = 1)
    @EqualsAndHashCode.Include
    private Long id;

    @Column(unique = true, nullable = false, length = 2)
    private String code;

    @Column(name = "name", length = 100, nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partner_id", nullable = false)
    private Partner partner;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id")
    private City city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reporting_currency_id", nullable = false)
    private Currency reportingCurrency;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "current_period_id")
    private AccountingPeriod currentPeriod;


    @Column(name = "locale", length = 10, nullable = false)
    @Builder.Default
    private String locale = "fr-FR";

    @Column(name = "decimal_places", nullable = false)
    @Builder.Default
    private Short decimalPlaces = 2;

    @Column(name = "percentage_decimal_places")
    @Builder.Default
    private Short percentageDecimalPlaces = 8;

    @Column(name = "settlement_tolerance", precision = 15, scale = 5, nullable = false)
    @Builder.Default
    private BigDecimal settlementTolerance = new BigDecimal("5.00000");

    @Column(name = "uncovered_tolerance", precision = 15, scale = 5)
    @Builder.Default
    private BigDecimal uncoveredTolerance = BigDecimal.ZERO;

    @Column(name = "factoring_ind", nullable = false)
    @Builder.Default
    private Boolean factoringInd = false;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "financial_partner_id")
    private Partner financialPartner;

    @Column(name = "default_bank_account")
    private Integer defaultBankAccount;


}