package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum GeneralEnum {
    TEAM_LEADER_PAY("Team Leader Pay"),
    OVER_TIME_THRESHOLD("Overtime Hours Threshold"),
    LUNCH_PERIOD("Lunch Period"),
    NO_LUNCH("No Lunch")

    final String value

    GeneralEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('generalEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}