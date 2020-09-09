package jobreport

import groovy.time.Duration
import groovy.time.TimeCategory
import groovy.time.TimeDuration

class TimeSheet {
    Date dateCreated
    Date lastUpdated
    Date startDateTime
    Date endDateTime
    boolean lunchBreak = false
    Workers worker
    boolean toBeRemoved = false
    boolean payrollComplete = false
    boolean isApprovedForPayroll = false
    BigDecimal hourlyRate

    static transients = ['toBeRemoved']
    static belongsTo = [siteReport:SiteReport]
    static constraints = {
        startDateTime nullable:false
        endDateTime nullable: false
        worker nullable: false
        lunchBreak nullable: true, blank: true
        toBeRemoved bindable: true
        hourlyRate nullable: true
    }

    def regularHours(){
        def lunchPeriod = General.findByNameEnumAndActive(GeneralEnum.LUNCH_PERIOD, true)?.value?.toBigDecimal()
        TimeDuration hrs = TimeCategory.minus(endDateTime, startDateTime)
        def modNum = hrs.minutes % 15
        def newTime = hrs.plus(new Duration(0,0,modNum?(15-modNum):0,0,0))
        def workHours = newTime.hours + (newTime.minutes==0?0:newTime.minutes.div(60))
        lunchBreak ? workHours.minus(lunchPeriod) : workHours
    }

    def overtimeHours(){
        BigDecimal overtimeHours
        BigDecimal workHours = regularHours()
        def overtimeThreshold = General.findByNameEnumAndActive(GeneralEnum.OVER_TIME_THRESHOLD, true)?.value?.toBigDecimal()
        if (rateCategory() == WageTypeEnum.STANDARD_RATE){
            switch (rateClass()){
                case StandardRateTypeEnum.REGULAR :
                    if (workHours > overtimeThreshold){
                        overtimeHours = workHours.minus(overtimeThreshold)
                    }
                    break
                case StandardRateTypeEnum.SALARY_NON_EXEMPT_ADJUSTMENT :

                    break
                case StandardRateTypeEnum.REGULAR_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PSF :

                    break
                case StandardRateTypeEnum.PSF_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PLF :

                    break
                case StandardRateTypeEnum.PREMIUM :

                    break
                case StandardRateTypeEnum.DOUBLE :

                    break
                case StandardRateTypeEnum.SPECIAL_RATE :

                    break
                case StandardRateTypeEnum.TRAVEL_RATE :

                    break
                case StandardRateTypeEnum.DAILY_MINIMUM :

                    break
                default :
                    log.debug("No matching rate type for standard wages!")
                    break
            }
        }
        if (rateCategory() == WageTypeEnum.REGIONAL_AGENCY_RATE){
            switch (rateClass()){
                case RegionalAgencyRateTypeEnum.NY_PLA :

                    break
                case RegionalAgencyRateTypeEnum.UNION_A_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.UNION_B_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING_DBA_REDUCED :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_R_AND_M :

                    break
                default:
                    log.debug("No matching rate type for regional / agency rates!")
                    break
            }
        }
        overtimeHours?:BigDecimal.ZERO
    }

    def regularPay(){
        BigDecimal hours = regularHours()
        BigDecimal pay
        if (rateCategory() == WageTypeEnum.STANDARD_RATE){
            switch (rateClass()){
                case StandardRateTypeEnum.REGULAR :
                    pay = hours.multiply(hourlyRate)
                    break
                case StandardRateTypeEnum.SALARY_NON_EXEMPT_ADJUSTMENT :

                    break
                case StandardRateTypeEnum.REGULAR_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PSF :

                    break
                case StandardRateTypeEnum.PSF_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PLF :

                    break
                case StandardRateTypeEnum.PREMIUM :

                    break
                case StandardRateTypeEnum.DOUBLE :

                    break
                case StandardRateTypeEnum.SPECIAL_RATE :

                    break
                case StandardRateTypeEnum.TRAVEL_RATE :

                    break
                case StandardRateTypeEnum.DAILY_MINIMUM :

                    break
                default :
                    log.debug("No matching rate type for standard wages!")
                    break
            }
        }
        if (rateCategory() == WageTypeEnum.REGIONAL_AGENCY_RATE){
            switch (rateClass()){
                case RegionalAgencyRateTypeEnum.NY_PLA :

                    break
                case RegionalAgencyRateTypeEnum.UNION_A_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.UNION_B_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING_DBA_REDUCED :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_R_AND_M :

                    break
                default:
                    log.debug("No matching rate type for regional / agency rates!")
                    break
            }
        }
        pay?pay:BigDecimal.ZERO
    }

    BigDecimal overtimeRate(){
        BigDecimal rate
        if (rateCategory() == WageTypeEnum.STANDARD_RATE){
            switch (rateClass()){
                case StandardRateTypeEnum.REGULAR :
                    pay = hours.multiply(hourlyRate)
                    break
                case StandardRateTypeEnum.SALARY_NON_EXEMPT_ADJUSTMENT :

                    break
                case StandardRateTypeEnum.REGULAR_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PSF :

                    break
                case StandardRateTypeEnum.PSF_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PLF :

                    break
                case StandardRateTypeEnum.PREMIUM :

                    break
                case StandardRateTypeEnum.DOUBLE :

                    break
                case StandardRateTypeEnum.SPECIAL_RATE :

                    break
                case StandardRateTypeEnum.TRAVEL_RATE :

                    break
                case StandardRateTypeEnum.DAILY_MINIMUM :

                    break
                default :
                    log.debug("No matching rate type for standard wages!")
                    break
            }
        }
        if (rateCategory() == WageTypeEnum.REGIONAL_AGENCY_RATE){
            switch (rateClass()){
                case RegionalAgencyRateTypeEnum.NY_PLA :

                    break
                case RegionalAgencyRateTypeEnum.UNION_A_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.UNION_B_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING_DBA_REDUCED :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_R_AND_M :

                    break
                default:
                    log.debug("No matching rate type for regional / agency rates!")
                    break
            }
        }
        rate?rate:BigDecimal.ZERO
    }

    BigDecimal overtimePay(){
        BigDecimal pay
        if (rateCategory() == WageTypeEnum.STANDARD_RATE){
            switch (rateClass()){
                case StandardRateTypeEnum.REGULAR :
                    pay = overtimeHours()*overtimeRate()
                    break
                case StandardRateTypeEnum.SALARY_NON_EXEMPT_ADJUSTMENT :

                    break
                case StandardRateTypeEnum.REGULAR_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PSF :

                    break
                case StandardRateTypeEnum.PSF_PLUS_25_PERCENT_SCAFFOLD :

                    break
                case StandardRateTypeEnum.PLF :

                    break
                case StandardRateTypeEnum.PREMIUM :

                    break
                case StandardRateTypeEnum.DOUBLE :

                    break
                case StandardRateTypeEnum.SPECIAL_RATE :

                    break
                case StandardRateTypeEnum.TRAVEL_RATE :

                    break
                case StandardRateTypeEnum.DAILY_MINIMUM :

                    break
                default :
                    log.debug("No matching rate type for standard wages!")
                    break
            }
        }
        if (rateCategory() == WageTypeEnum.REGIONAL_AGENCY_RATE){
            switch (rateClass()){
                case RegionalAgencyRateTypeEnum.NY_PLA :

                    break
                case RegionalAgencyRateTypeEnum.UNION_A_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.UNION_B_FULL_RATE :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING :

                    break
                case RegionalAgencyRateTypeEnum.NYS_PREVAILING_DBA_REDUCED :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.NJ_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.CT_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.MA_PREVAILING_R_AND_M :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_BY_REGION :

                    break
                case RegionalAgencyRateTypeEnum.IL_PREVAILING_R_AND_M :

                    break
                default:
                    log.debug("No matching rate type for regional / agency rates!")
                    break
            }
        }
        pay?pay:BigDecimal.ZERO
    }

    def rateCategory(){
        siteReport.jobReport.rateCategory as WageTypeEnum
    }

    def rateClass(){
        def rateClassification

        if (rateCategory() == WageTypeEnum.STANDARD_RATE){
            rateClassification = siteReport.jobReport.rateClass as StandardRateTypeEnum
        }
        else{
            rateClassification = siteReport.jobReport.rateClass as RegionalAgencyRateTypeEnum
        }
        rateClassification
    }
}
