package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.*;

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

    @Column(unique = true, nullable = false, length = 10)
    private String code;

    @Column(name = "name", length = 100, nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partner_id", nullable = false)
    private Partner partner;



    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id", nullable = false)
    private City city;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "fax", length = 20)
    private String fax;

    @Column(name = "email", length = 100)
    private String email;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "currency_id", nullable = false)
    private Currency currency;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "accounting_period_id", nullable = false)
    private AccountingPeriod accountingPeriod;





}