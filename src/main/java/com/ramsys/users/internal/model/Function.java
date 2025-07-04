package com.ramsys.users.internal.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.common.model.I18nEntity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.SQLRestriction;
import org.hibernate.annotations.Where;
import org.hibernate.proxy.HibernateProxy;

import java.util.Objects;

@Entity
@Table(name = "ref_function")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@SQLRestriction("is_active = true")
public class Function extends  Auditable implements I18nEntity  {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_function_seq")
    @SequenceGenerator(name = "ref_function_seq", sequenceName = "ref_function_id_seq", allocationSize = 1)
    private Long id;
    
    @Column(name = "code", unique = true, nullable = false, length = 20)
    private String code;
    
    @Column(name = "name_fr", nullable = false, length = 80)
    private String nameFr;
    
    @Column(name = "name_en", length = 80)
    private String nameEn;
    
    @Column(name = "name_ar", length = 80)
    private String nameAr;
    
    @Column(name = "description_fr", length = 255)
    private String descriptionFr;
    
    @Column(name = "description_en", length = 255)
    private String descriptionEn;
    
    @Column(name = "description_ar", length = 255)
    private String descriptionAr;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    private Group group;
    
    @Column(name = "sequence_in_group")
    private Integer sequenceInGroup;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "function_type_id")
    private FunctionType functionType;
    












    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        Function function = (Function) o;
        return getId() != null && Objects.equals(getId(), function.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}