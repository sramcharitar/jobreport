package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum  StandardRateTypeEnum {
    REGULAR("Regular"),
    SALARY_NON_EXEMPT_ADJUSTMENT("Salary Non-Exempt Adjustment"),
    REGULAR_PLUS_25_PERCENT_SCAFFOLD("Regular + 25% Scaffold"),
    PSF("PSF"),
    PSF_PLUS_25_PERCENT_SCAFFOLD("PSF + 25% Scaffold"),
    PLF("PLF"),
    PREMIUM("Premium (1.5x Regular)"),
    DOUBLE("Double (2x Regular)"),
    SPECIAL_RATE("Special Rate"),
    TRAVEL_RATE("Travel Rate"),
    DAILY_MINIMUM("Daily Minimum")

    final String value

    StandardRateTypeEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('rateTypeEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}
