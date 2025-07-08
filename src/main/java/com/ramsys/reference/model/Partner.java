package com.ramsys.reference.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.ramsys.common.model.Auditable;
import com.ramsys.reference.internal.generator.PartnerCode;
import com.ramsys.reference.model.embedded.AddressInfo;
import com.ramsys.reference.model.embedded.ContactInfo;
import com.ramsys.reference.model.embedded.FinancialInfo;
import jakarta.persistence.*;
import lombok.*;

/**
 * Entité représentant les partenaires (NON TRADUISIBLE)
 * Table: ref_partner
 * 
 * Utilise des objets embeddés pour organiser les informations par domaine :
 * - ContactInfo : informations de contact
 * - FinancialInfo : informations financières et bancaires
 * - AddressInfo : informations d'adresse
 * - BusinessCapabilities : capacités métier du partenaire
 */
@Entity
@Table(name = "ref_partner")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = {"parentPartner"})
public class Partner extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ref_partner_seq")
    @SequenceGenerator(name = "ref_partner_seq", sequenceName = "ref_partner_id_seq",allocationSize = 1)
    private Long id;


    @PartnerCode
    @Column(name = "code", unique = true, nullable = false, length = 20)
    private String code;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "short_name", nullable = false, length = 32)
    private String shortName;

    @Column(name = "comment", columnDefinition = "TEXT")
    private String comment;

    // === RELATIONS AVEC LES ENTITÉS DE RÉFÉRENCE ===
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partner_type_id", nullable = false)
    private PartnerType partnerType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "region_id", nullable = false)
    private Region region;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "country_id", nullable = false)
    private Country country;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "currency_id", nullable = false)
    private Currency currency;

    // Supprime le champ isActive redondant car il vient d'Auditable
    // @Column(name = "is_active", nullable = false)
    // private Boolean isActive;

    // === OBJETS EMBEDDÉS POUR ORGANISER LES INFORMATIONS ===
    
    @Embedded
    @AttributeOverrides({
        @AttributeOverride(name = "genre", column = @Column(name = "contact_genre")),
        @AttributeOverride(name = "name", column = @Column(name = "contact_name")),
        @AttributeOverride(name = "telephone", column = @Column(name = "telephone")),
        @AttributeOverride(name = "fax", column = @Column(name = "fax")),
        @AttributeOverride(name = "emailPrefix", column = @Column(name = "prefix_mail")),
        @AttributeOverride(name = "emailDomain", column = @Column(name = "domaine"))
    })
    @Builder.Default
    private ContactInfo contactInfo = new ContactInfo();

    @Embedded
    @AttributeOverrides({
        @AttributeOverride(name = "scoring", column = @Column(name = "scoring")),
        @AttributeOverride(name = "bankName", column = @Column(name = "bank_name")),
        @AttributeOverride(name = "bankIban", column = @Column(name = "bank_iban")),
        @AttributeOverride(name = "swiftCode", column = @Column(name = "swift"))
    })
    @AssociationOverrides({
        @AssociationOverride(name = "rating", joinColumns = @JoinColumn(name = "rating_id"))
    })
    @Builder.Default
    private FinancialInfo financialInfo = new FinancialInfo();

    @Embedded
    @AttributeOverrides({
        @AttributeOverride(name = "fullAddress", column = @Column(name = "address")),
        @AttributeOverride(name = "area", column = @Column(name = "area")),
        @AttributeOverride(name = "road", column = @Column(name = "road")),
        @AttributeOverride(name = "building", column = @Column(name = "building")),
        @AttributeOverride(name = "flat", column = @Column(name = "flat")),
        @AttributeOverride(name = "longitude", column = @Column(name = "longitude")),
        @AttributeOverride(name = "latitude", column = @Column(name = "latitude")),
    })
    @Builder.Default
    private AddressInfo addressInfo = new AddressInfo();

    // === HIÉRARCHIE PARENT/ENFANT ===
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_partner_id")
    @JsonBackReference
    private Partner parentPartner;



    // === NOUVEAUX ATTRIBUTS POUR LES CAPACITÉS ET TYPES ===
    @Column(name = "is_reinsurer")
    private Boolean isReinsurer;

    @Column(name = "is_inwards")
    private Boolean isInwards;

    @Column(name = "is_outwards")
    private Boolean isOutwards;

    @Column(name = "type_other")
    private String otherType;



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
     * Retourne le niveau de risque financier
     */
    public String getRiskLevel() {
        return financialInfo.getRiskLevel();
    }
}
