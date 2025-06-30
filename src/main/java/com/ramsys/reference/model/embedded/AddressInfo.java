package com.ramsys.reference.model.embedded;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

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

    @Column(name = "gps_code", length = 12)
    private String gpsCode;

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

    /**
     * Vérifie si les coordonnées GPS sont disponibles
     * @return true si le code GPS est renseigné
     */
    public boolean hasGpsCoordinates() {
        return gpsCode != null && !gpsCode.trim().isEmpty();
    }

    /**
     * Valide le format du code GPS (exemple: format simple)
     * @return true si le format GPS semble valide
     */
    public boolean isValidGpsCode() {
        if (gpsCode == null) return true; // Optionnel
        // Format simple: doit contenir des chiffres et éventuellement des lettres/points
        return gpsCode.matches("^[A-Z0-9.-]+$");
    }

    /**
     * Retourne l'adresse pour l'affichage avec informations GPS si disponibles
     * @return L'adresse complète avec GPS
     */
    public String getFullDisplayAddress() {
        String address = getFormattedAddress();
        if (hasGpsCoordinates()) {
            return address + " (GPS: " + gpsCode + ")";
        }
        return address;
    }

    @Override
    public String toString() {
        return "AddressInfo{" +
                "formattedAddress='" + getFormattedAddress() + '\'' +
                ", gpsCode='" + gpsCode + '\'' +
                ", hasGps=" + hasGpsCoordinates() +
                '}';
    }
} 
