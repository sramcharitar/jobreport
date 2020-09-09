package jobreport

class PriorPeriodAdjustments {
    Date dateCreated
    Date lastUpdated
    ChbUsers employee
    Date workDate
    String jobId
    String location
    WageTypeEnum wageTypeEnum
    RateTypeEnum rateTypeEnum
    BigDecimal regularHours
    BigDecimal overtimeHours
    BigDecimal specialHours
    BigDecimal regularRate
    BigDecimal overtimeRate
    BigDecimal specialRate
    BigDecimal regularPay
    BigDecimal overtimePay
    BigDecimal specialPay
    BigDecimal teamLeaderPay

    static belongsTo = [siteReport:SiteReport]

    static mapping = {
        location type: 'text'
    }

    static constraints = {
        jobId nullable: true
        siteReport nullable: true
        overtimeHours nullable: true
        specialHours nullable: true
        overtimeRate nullable: true
        specialRate nullable: true
        overtimePay nullable: true
        specialPay nullable: true
        location nullable: true
        teamLeaderPay nullable: true
    }
}
