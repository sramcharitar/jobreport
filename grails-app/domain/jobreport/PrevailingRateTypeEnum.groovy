package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum PrevailingRateTypeEnum {

    final String value

    PrevailingRateTypeEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('rateTypeEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}