package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum WageTypeEnum{
    STANDARD_RATE("Standard Rate"),
    REGIONAL_AGENCY_RATE("Regional / Agency Rate")

    final String value

    WageTypeEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('rateCategoryEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}
