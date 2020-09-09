package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum  RateTypeEnum {
    HOURLY("Hourly"),
    PREMIUM("Premium"),
    PSF("PSF"),
    PLF("PLF"),
    DAILY_MINIMUM("Daily Minimum"),
    NEW_YORK("New York"),
    NEW_YORK_R_AND_M("New York R And M"),
    ILLINOIS("Illinois"),
    NEW_JERSEY("New Jersey"),
    CONNECTICUT("Connecticut"),
    NY_DC9_A_RATE_PLA("NY DC9 A Rate PLA"),
    NY_DC9_B_RATE_FULL_RATE("NY DC9 B Rate Full Rate"),
    IL_LOCAL_27("IL Local 27")

    final String value

    RateTypeEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('rateTypeEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}
