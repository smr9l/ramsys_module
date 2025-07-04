package com.ramsys.users.internal.model;

import com.ramsys.common.model.Auditable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ref_user_detail")
@Data
@EqualsAndHashCode(callSuper = true, onlyExplicitlyIncluded = true)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User extends Auditable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_user_detail_seq")
    @SequenceGenerator(name = "ref_user_detail_seq", sequenceName = "ref_user_detail_id_seq", allocationSize = 1)
    @EqualsAndHashCode.Include
    private Long id;
    
    @Column(name = "username", unique = true, nullable = false, length = 50)
    private String username;
    
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;
    
    @Column(name = "email", unique = true, length = 100)
    private String email;
    
    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;
    
    @Column(name = "last_name", nullable = false, length = 50)
    private String lastName;
    
    @Column(name = "title", length = 100)
    private String title;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id")
    private Role role;

    @Column(name = "location_id")
    private Long locationId;

    @Column(name = "division_id")
    private Long divisionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "manager_id")
    private User manager;

    @Column(name = "language", length = 10)
    private String language;


    

    
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", isActive=" +isActive() +
                '}';
    }
} 