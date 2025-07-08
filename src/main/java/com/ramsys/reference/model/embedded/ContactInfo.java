package com.ramsys.reference.model.embedded;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

/**
 * Informations de contact embeddées
 */
@Embeddable
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ContactInfo {

    @Column(name = "contact_genre", length = 5)
    private String genre;

    @Column(name = "contact_name", length = 32)
    private String name;

    @Column(name = "telephone", length = 20)
    private String telephone;

    @Column(name = "fax", length = 20)
    private String fax;

    @Column(name = "prefix_mail", length = 32)
    private String emailPrefix;

    @Column(name = "domaine", length = 32)
    private String emailDomain;

    /**
     * Construit l'adresse email complète
     * @return L'adresse email complète ou null si incomplete
     */
    public String getFullEmail() {
        if (emailPrefix != null && emailDomain != null) {
            return emailPrefix + "@" + emailDomain;
        }
        return null;
    }

    /**
     * Vérifie si les informations de contact sont complètes
     * @return true si au moins un moyen de contact est renseigné
     */
    public boolean hasContactInfo() {
        return telephone != null || fax != null || getFullEmail() != null;
    }

    @Override
    public String toString() {
        return "ContactInfo{" +
                "name='" + name + '\'' +
                ", telephone='" + telephone + '\'' +
                ", email='" + getFullEmail() + '\'' +
                '}';
    }
}

