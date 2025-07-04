package com.ramsys.users.internal.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.SQLRestriction;
import org.hibernate.proxy.HibernateProxy;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "ref_role")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Role extends Auditable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_role_seq")
    @SequenceGenerator(name = "ref_role_seq", sequenceName = "ref_role_id_seq", allocationSize = 1)
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
        Role role = (Role) o;
        return getId() != null && Objects.equals(getId(), role.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }

    @SQLRestriction( "is_active = true" )
    @OneToMany(mappedBy = "role", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private Set<RoleFunction> roleFunctions = new HashSet<>();





}