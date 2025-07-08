package com.ramsys.reference.model.embedded;

import com.ramsys.reference.model.Rating;
import jakarta.persistence.*;
import lombok.*;

/**
 * Informations financières embeddées
 */
@Embeddable
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FinancialInfo {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rating_id")
    private Rating rating;

    @Column(name = "scoring")
    private Integer scoring;

    @Column(name = "bank_name", length = 100)
    private String bankName;

    @Column(name = "bank_iban", length = 30)
    private String bankIban;

    @Column(name = "swift", length = 10)
    private String swiftCode;

    /**
     * Vérifie si les informations bancaires sont complètes
     * @return true si les informations bancaires minimales sont présentes
     */
    public boolean hasBankingInfo() {
        return bankName != null || bankIban != null || swiftCode != null;
    }

    /**
     * Vérifie si les informations de notation sont disponibles
     * @return true si rating ou scoring est renseigné
     */
    public boolean hasRatingInfo() {
        return rating != null || scoring != null;
    }

    /**
     * Retourne le niveau de risque basé sur le scoring
     * @return Le niveau de risque ou "Non évalué"
     */
    public String getRiskLevel() {
        if (scoring == null) return "Non évalué";
        if (scoring >= 80) return "Faible";
        if (scoring >= 60) return "Modéré";
        if (scoring >= 40) return "Élevé";
        return "Très élevé";
    }

    /**
     * Valide le format IBAN (validation simplifiée)
     * @return true si l'IBAN semble valide
     */
    public boolean isValidIban() {
        if (bankIban == null) return true; // Optionnel
        return bankIban.matches("^[A-Z]{2}[0-9]{2}[A-Z0-9]{4}[0-9]{7}([A-Z0-9]?){0,16}$");
    }

    /**
     * Valide le format SWIFT
     * @return true si le code SWIFT semble valide
     */
    public boolean isValidSwift() {
        if (swiftCode == null) return true; // Optionnel
        return swiftCode.matches("^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$");
    }

    @Override
    public String toString() {
        return "FinancialInfo{" +
                "rating='" + rating + '\'' +
                ", scoring=" + scoring +
                ", bankName='" + bankName + '\'' +
                ", riskLevel='" + getRiskLevel() + '\'' +
                '}';
    }
}
