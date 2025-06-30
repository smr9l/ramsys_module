package com.ramsys.reference.model.embedded;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

/**
 * Capacités métier embeddées du partenaire
 */
@Embeddable
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BusinessCapabilities {

    @Column(name = "is_reinsurer")
    @Builder.Default
    private Boolean isReinsurer = false;

    @Column(name = "is_inwards")
    @Builder.Default
    private Boolean isInwards = false;

    @Column(name = "is_outwards")
    @Builder.Default
    private Boolean isOutwards = false;

    @Column(name = "type_other", length = 32)
    private String otherCapabilities;

    /**
     * Vérifie si le partenaire est un réassureur
     * @return true si c'est un réassureur
     */
    public boolean isReinsurer() {
        return Boolean.TRUE.equals(isReinsurer);
    }

    /**
     * Vérifie si le partenaire accepte des affaires (inwards)
     * @return true si accepte inwards
     */
    public boolean acceptsInwards() {
        return Boolean.TRUE.equals(isInwards);
    }

    /**
     * Vérifie si le partenaire cède des affaires (outwards)
     * @return true si cède outwards
     */
    public boolean cedesOutwards() {
        return Boolean.TRUE.equals(isOutwards);
    }

    /**
     * Retourne le type de partenaire basé sur ses capacités
     * @return Le type de partenaire
     */
    public String getPartnershipType() {
        if (isReinsurer() && acceptsInwards() && cedesOutwards()) {
            return "Réassureur complet";
        }
        if (isReinsurer() && acceptsInwards()) {
            return "Réassureur acceptant";
        }
        if (isReinsurer() && cedesOutwards()) {
            return "Réassureur cédant";
        }
        if (acceptsInwards() && cedesOutwards()) {
            return "Courtier/Intermédiaire";
        }
        if (acceptsInwards()) {
            return "Accepteur";
        }
        if (cedesOutwards()) {
            return "Cédant";
        }
        return "Non défini";
    }

    /**
     * Vérifie si le partenaire a des capacités métier définies
     * @return true si au moins une capacité est définie
     */
    public boolean hasBusinessCapabilities() {
        return isReinsurer() || acceptsInwards() || cedesOutwards();
    }

    /**
     * Vérifie si le partenaire peut traiter des affaires dans les deux sens
     * @return true si peut accepter ET céder
     */
    public boolean isBidirectional() {
        return acceptsInwards() && cedesOutwards();
    }

    /**
     * Retourne une description des capacités pour l'affichage
     * @return Description des capacités
     */
    public String getCapabilitiesDescription() {
        if (!hasBusinessCapabilities()) {
            return "Aucune capacité définie";
        }

        StringBuilder sb = new StringBuilder();
        if (isReinsurer()) sb.append("Réassureur, ");
        if (acceptsInwards()) sb.append("Accepte affaires, ");
        if (cedesOutwards()) sb.append("Cède affaires, ");
        if (otherCapabilities != null) sb.append(otherCapabilities).append(", ");

        String result = sb.toString();
        return result.endsWith(", ") ? result.substring(0, result.length() - 2) : result;
    }

    /**
     * Valide la cohérence des capacités métier
     * @return true si les capacités sont cohérentes
     */
    public boolean isValid() {
        // Un réassureur devrait normalement accepter ou céder des affaires
        if (isReinsurer() && !acceptsInwards() && !cedesOutwards()) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "BusinessCapabilities{" +
                "type='" + getPartnershipType() + '\'' +
                ", isReinsurer=" + isReinsurer() +
                ", acceptsInwards=" + acceptsInwards() +
                ", cedesOutwards=" + cedesOutwards() +
                ", bidirectional=" + isBidirectional() +
                '}';
    }
} 
