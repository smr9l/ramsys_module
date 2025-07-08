package com.ramsys.reference.validation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

/**
 * Validation conditionnelle pour le champ typeOther
 * Le champ typeOther est requis quand partnerTypeId correspond au type "OTHER"
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = TypeOtherRequiredValidator.class)
@Documented
public @interface TypeOtherRequired {

    String message() default "{partner.typeother.required.when.other}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
