package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum SpecialHoursEnum {
    PTO("Paid Time Off"),
    HOLIDAY("Holiday Pay"),
    JURY_DUTY("Jury Duty")

    final String value

    SpecialHoursEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('specialHoursEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}