package com.ramsys.users.internal.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.proxy.HibernateProxy;

import java.util.Objects;

@Entity
@Table(name = "ref_role_function")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoleFunction extends com.ramsys.common.model.Auditable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_role_function_seq")
    @SequenceGenerator(name = "ref_role_function_seq", sequenceName = "ref_role_function_id_seq", allocationSize = 1)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @ManyToOne
    @JoinColumn(name = "function_id", nullable = false)
    private Function function;


    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        RoleFunction that = (RoleFunction) o;
        return getId() != null && Objects.equals(getId(), that.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}
