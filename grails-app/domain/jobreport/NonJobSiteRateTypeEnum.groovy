package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum NonJobSiteRateTypeEnum {
    PTO("PTO"),
    HOLIDAY("Holiday"),
    BEREAVEMENT("Bereavement"),
    JURY_DUTY("Jury Duty"),
    E_PSL("E-PSL")

    final String value

    NonJobSiteRateTypeEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('rateTypeEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}