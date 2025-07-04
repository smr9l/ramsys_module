package com.ramsys.users.internal.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.proxy.HibernateProxy;

import java.util.Objects;

@Entity
@Table(name = "ref_function_type")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FunctionType extends Auditable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_function_type_seq")
    @SequenceGenerator(name = "ref_function_type_seq", sequenceName = "ref_function_type_id_seq", allocationSize = 1)
    private Long id;
    
    @Column(name = "code", unique = true, nullable = false, length = 20)
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
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        FunctionType that = (FunctionType) o;
        return getId() != null && Objects.equals(getId(), that.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}