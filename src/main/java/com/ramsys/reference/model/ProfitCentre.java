package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "ref_profit_centre")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@SequenceGenerator(name = "profit_centre_seq", sequenceName = "ref_profit_centre_id_seq", allocationSize = 1)
public class ProfitCentre extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "profit_centre_seq")
    private Long id;

    @Column(name = "code", unique = true, nullable = false, length = 2)
    private String code;

    @Column(name = "name", nullable = false, length = 40)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "location_id", nullable = false)
    private Location location;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "division_id", nullable = false)
    private Division division;

    @Column(name = "manager_id")
    private Long managerId;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private Boolean isActive = true;
} 
