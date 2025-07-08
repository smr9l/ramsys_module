package com.ramsys.reference.validation;

import com.ramsys.reference.dto.CreatePartnerDTO;
import com.ramsys.reference.internal.service.PartnerTypeService;
import com.ramsys.reference.model.PartnerTypeCodeEnum;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Validateur pour la contrainte TypeOtherRequired
 * Vérifie que typeOther est renseigné quand partnerTypeId correspond au type "OTHER"
 */
@Component
@RequiredArgsConstructor
public class TypeOtherRequiredValidator implements ConstraintValidator<TypeOtherRequired, CreatePartnerDTO> {

    private final PartnerTypeService partnerTypeService;

    @Override
    public void initialize(TypeOtherRequired constraintAnnotation) {
        // Pas d'initialisation nécessaire
    }

    @Override
    public boolean isValid(CreatePartnerDTO dto, ConstraintValidatorContext context) {
        if (dto == null || dto.getPartnerTypeId() == null) {
            return true; // La validation @NotNull se charge de ces cas
        }

        try {
             boolean isOtherType = partnerTypeService.isType(dto.getPartnerTypeId(), PartnerTypeCodeEnum.OTHER);

            // Si c'est "OTHER", alors typeOther doit être renseigné
            if (isOtherType) {
                boolean isTypeOtherValid = dto.getTypeOther() != null &&
                                         !dto.getTypeOther().trim().isEmpty();

                if (!isTypeOtherValid) {
                    // Personnaliser le message d'erreur pour pointer vers le bon champ
                    context.disableDefaultConstraintViolation();
                    context.buildConstraintViolationWithTemplate(context.getDefaultConstraintMessageTemplate())
                           .addPropertyNode("typeOther")
                           .addConstraintViolation();
                    return false;
                }
            }else if (dto.getTypeOther() != null) {
                // Si le type n'est pas "OTHER", alors typeOther doit être null
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Le champ 'typeOther' ne doit pas être renseigné pour ce type de partenaire.")
                       .addPropertyNode("typeOther")
                       .addConstraintViolation();
                return false;
            }

            return true;
        } catch (Exception e) {
            // En cas d'erreur lors de la récupération du type, considérer comme valide
            // et laisser d'autres validations gérer les erreurs
            return true;
        }
    }
}
