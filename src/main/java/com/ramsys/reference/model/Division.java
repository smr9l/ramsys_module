package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ref_division")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode(callSuper = true)
public class Division extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_division_seq")
    @SequenceGenerator(name = "ref_division_seq", sequenceName = "ref_division_id_seq", allocationSize = 1)
    @EqualsAndHashCode.Include
    private Long id;

    @Column(unique = true, nullable = false, length = 3)
    private String code;

    @Column(name = "name", length = 40, nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "location_id", nullable = false)
    private Location location;



} 