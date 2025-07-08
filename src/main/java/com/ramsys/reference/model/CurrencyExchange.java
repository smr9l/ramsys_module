package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "ref_currency_exchange")

public class CurrencyExchange extends Auditable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_currency_exchange_id_gen")
    @SequenceGenerator(name = "ref_currency_exchange_id_gen", sequenceName = "ref_rating_id_seq", allocationSize = 1)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
//    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "period_id", nullable = false)
    private AccountingPeriod period;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
//    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "currency_id", nullable = false)
    private Currency currency;

    @NotNull
    @Column(name = "rate", nullable = false, precision = 18, scale = 8)
    private BigDecimal rate;

}