package jobreport

class PayrollSchedule {
    Date dateCreated
    Date lastUpdated
    ChbUsers worker
    Date payrollPeriodStart
    Date payrollPeriodEnd
    BigDecimal totalRegularPay
    BigDecimal totalOverTimePay
    BigDecimal totalRegularHours
    BigDecimal totalOverTimeHours
    BigDecimal totalPayWithTeamLeaderBonus
    BigDecimal totalPay
    SiteReport siteReport

    static hasMany = [payrollDetails:PayrollDetails]

    static constraints = {
        totalOverTimeHours nullable: true
        totalOverTimePay nullable: true
    }
}
