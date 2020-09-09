package jobreport

class PayrollDetails {
    Date dateCreated
    Date lastUpdated
    String jobNumber
    String clientName
    Date startDate
    Date timeIn
    Date timeOut
    BigDecimal regularHours
    BigDecimal overtimeHours
    BigDecimal specialHours
    WageTypeEnum wageType
    RateTypeEnum basis
    BigDecimal rate
    BigDecimal otRate
    BigDecimal regularPay
    BigDecimal overTimePay
    BigDecimal teamLeaderPay
    TimeSheet timeSheet

    static constraints = {
        overtimeHours nullable: true
        specialHours nullable: true
        otRate nullable: true
        overTimePay nullable: true
        teamLeaderPay nullable: true
    }
}
