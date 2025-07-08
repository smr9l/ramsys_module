package com.ramsys.reference.model;

import com.ramsys.common.model.Auditable;
import com.ramsys.reference.model.embedded.AddressInfo;
import com.ramsys.reference.model.embedded.ContactInfo;
import jakarta.persistence.*;
import lombok.*;

/**
 * Entité représentant les assurés (NON TRADUISIBLE)
 * Table: ref_insured
 * 
 * Utilise des objets embeddés pour organiser les informations par domaine :
 * - ContactInfo : informations de contact
 * - AddressInfo : informations d'adresse
 */
@Entity
@Table(name = "ref_insured")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
 public class Insured extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_insured_seq")
    @SequenceGenerator(name = "ref_insured_seq", sequenceName = "ref_insured_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "name", nullable = false, unique = true, length = 150)
    private String name;

    @Column(name = "short_name", nullable = false, length = 40)
    private String shortName;

    @Column(name = "type", length = 40)
    private String type;

    @Column(name = "comment", columnDefinition = "TEXT")
    private String comment;

    @Column(name = "number_of_locations")
    private Integer numberOfLocations;

    // === RELATIONS AVEC LES ENTITÉS DE RÉFÉRENCE ===
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "occupancy_id", nullable = false)
    private Occupancy occupancy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "region_id", nullable = false)
    private Region region;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "country_id", nullable = false)
    private Country country;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id")
    private City city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partner_id")
    private Partner partner;

    // === OBJETS EMBEDDÉS POUR ORGANISER LES INFORMATIONS ===
    
    @Embedded
    @AttributeOverrides({
        @AttributeOverride(name = "genre", column = @Column(name = "contact_genre")),
        @AttributeOverride(name = "name", column = @Column(name = "contact_name")),
        @AttributeOverride(name = "telephone", column = @Column(name = "telephone")),
        @AttributeOverride(name = "fax", column = @Column(name = "fax")),
        @AttributeOverride(name = "emailPrefix", column = @Column(name = "email_prefix")),
        @AttributeOverride(name = "emailDomain", column = @Column(name = "email_domain"))
    })
    @Builder.Default
    private ContactInfo contactInfo = new ContactInfo();

    @Embedded
    @AttributeOverrides({
        @AttributeOverride(name = "fullAddress", column = @Column(name = "address")),
        @AttributeOverride(name = "area", column = @Column(name = "area")),
        @AttributeOverride(name = "road", column = @Column(name = "road")),
        @AttributeOverride(name = "building", column = @Column(name = "building")),
        @AttributeOverride(name = "flat", column = @Column(name = "flat")),
        @AttributeOverride(name = "longitude", column = @Column(name = "longitude")),
        @AttributeOverride(name = "latitude", column = @Column(name = "latitude"))
    })
    @Builder.Default
    private AddressInfo addressInfo = new AddressInfo();

    /**
     * Retourne l'email complet du contact
     */
    public String getContactEmail() {
        return contactInfo.getFullEmail();
    }

    /**
     * Retourne l'adresse formatée
     */
    public String getFormattedAddress() {
        return addressInfo.getFormattedAddress();
    }

    /**
     * Retourne la description du risque basée sur l'occupation
     */
    public String getRiskDescription() {
        return occupancy != null ? occupancy.getLocalizedName() : "Unknown";
    }
} 