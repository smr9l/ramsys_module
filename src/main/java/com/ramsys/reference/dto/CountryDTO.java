    package com.ramsys.reference.dto;

    import com.fasterxml.jackson.annotation.JsonInclude;
    import com.ramsys.common.dto.ReferenceDTO;
    import lombok.*;
    import lombok.experimental.SuperBuilder;

    /**
     * DTO pour l'entité Country
     * Étend ReferenceDTO pour les propriétés communes (id, code, label)
     */
    @Getter
    @Setter
    @SuperBuilder
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode(callSuper = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public class CountryDTO extends ReferenceDTO {

        // Propriétés spécifiques à Country
        private ReferenceDTO region;

        @Override
        public String toString() {
            return "CountryDTO{id=" + getId() + ", code='" + getCode() + "', label='" + getLabel() +
                   ", region=" + region + ", isActive=" + getIsActive() + "}";
        }
    }
