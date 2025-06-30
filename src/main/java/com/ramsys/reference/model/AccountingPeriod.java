package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.proxy.HibernateProxy;

import java.time.LocalDate;
import java.util.Objects;

@Entity
@Table(name = "ref_period", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"year", "month"})
})
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@SequenceGenerator(name = "accounting_period_seq", sequenceName = "ref_period_id_seq", allocationSize = 1)
public class AccountingPeriod extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "accounting_period_seq")
    private Long id;

    @Column(name = "year", nullable = false)
    private Integer year;

    @Column(name = "month", nullable = false)
    private Integer month;

    @Column(name = "name", length = 50)
    private String name;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;

    @Column(name = "is_current_processing", nullable = false)
    @Builder.Default
    private Boolean isCurrentProcessing = false;

    @Column(name = "is_open_for_linkage", nullable = false)
    @Builder.Default
    private Boolean isOpenForLinkage = false;

    @Column(name = "is_open_for_exchange_rates", nullable = false)
    @Builder.Default
    private Boolean isOpenForExchangeRates = false;

    @Column(name = "is_open_for_bank_balance", nullable = false)
    @Builder.Default
    private Boolean isOpenForBankBalance = false;

    @Version
    @Column(name = "version", nullable = false)
    @Builder.Default
    private Integer version = 0;

    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        AccountingPeriod that = (AccountingPeriod) o;
        return getId() != null && Objects.equals(getId(), that.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}
