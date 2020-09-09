package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum RegionalAgencyRateTypeEnum {
    NY_PLA("NY PLA"),
    UNION_A_FULL_RATE("Union A Full Rate"),
    UNION_B_FULL_RATE("Union B Full Rate"),
    NYS_PREVAILING("NYS Prevailing (same statewide, only R&M)"),
    NYS_PREVAILING_DBA_REDUCED("NYS Prevailing – DBA Reduced"),
    NJ_PREVAILING_BY_REGION("NJ Prevailing (by region)"),
    NJ_PREVAILING_R_AND_M("NJ Prevailing R&M (by region)"),
    CT_PREVAILING_BY_REGION("CT Prevailing (by region)"),
    CT_PREVAILING_R_AND_M("CT Prevailing R&M (by region)"),
    MA_PREVAILING_BY_REGION("MA Prevailing (by region)"),
    MA_PREVAILING_R_AND_M("MA Prevailing R&M (by region)"),
    IL_PREVAILING_BY_REGION("IL Prevailing (by region)"),
    IL_PREVAILING_R_AND_M("IL Prevailing R&M (by region)"),

    final String value

    RegionalAgencyRateTypeEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('rateTypeEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey() { name() }
}