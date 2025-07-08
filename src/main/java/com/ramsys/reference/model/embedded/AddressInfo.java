package com.ramsys.reference.model.embedded;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.math.BigDecimal;

/**
 * Informations d'adresse embeddées
 */
@Embeddable
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AddressInfo {

    @Column(name = "address", columnDefinition = "TEXT")
    private String fullAddress;

    @Column(name = "area", length = 40)
    private String area;

    @Column(name = "road", length = 40)
    private String road;

    @Column(name = "building", length = 40)
    private String building;

    @Column(name = "flat", length = 40)
    private String flat;

    @Column(name = "latitude", precision = 10, scale = 8)
    private BigDecimal latitude;

    @Column(name = "longitude", precision = 11, scale = 8)
    private BigDecimal longitude;

    /**
     * Construit l'adresse formatée pour l'affichage
     * @return L'adresse formatée ou l'adresse complète si les détails ne sont pas disponibles
     */
    public String getFormattedAddress() {
        if (hasDetailedAddress()) {
            StringBuilder sb = new StringBuilder();
            
            if (flat != null) sb.append(flat).append(", ");
            if (building != null) sb.append(building).append(", ");
            if (road != null) sb.append(road).append(", ");
            if (area != null) sb.append(area);
            
            String result = sb.toString();
            return result.endsWith(", ") ? result.substring(0, result.length() - 2) : result;
        }
        return fullAddress;
    }

    /**
     * Vérifie si l'adresse détaillée est disponible
     * @return true si au moins un champ d'adresse détaillée est renseigné
     */
    public boolean hasDetailedAddress() {
        return area != null || road != null || building != null || flat != null;
    }

    /**
     * Vérifie si des informations d'adresse sont disponibles
     * @return true si une adresse (complète ou détaillée) est présente
     */
    public boolean hasAddress() {
        return fullAddress != null || hasDetailedAddress();
    }



}

