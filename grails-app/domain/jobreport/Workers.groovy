package jobreport

class Workers {
    Workers(){
        this.perHour = true
    }

    Date dateCreated
    Date lastUpdated
    ChbUsers worker
    BigDecimal gas
    BigDecimal parking
    BigDecimal tolls
    BigDecimal train
    BigDecimal taxi
    BigDecimal lodging
    BigDecimal office
    BigDecimal tools
    BigDecimal misc
    //WageTypeEnum wageTypeEnum = WageTypeEnum.STANDARD_WAGE
    //RateTypeEnum rateTypeEnum = RateTypeEnum.HOURLY
    //BigDecimal payRate
    //BigDecimal overtimeRate
    boolean perSqFt
    boolean perPane
    boolean perHour
    boolean isTeamLeader = false
    BigDecimal teamLeaderPay
    boolean _deleted = false
    ChbUsers _member

    static transients = ['_deleted', '_member']
    static belongsTo = [jobReport:JobReport]
    static constraints = {
        gas nullable: true
        parking nullable: true
        tolls nullable: true
        train nullable: true
        taxi nullable: true
        lodging nullable: true
        office nullable: true
        tools nullable: true
        misc nullable: true
        //overtimeRate nullable: true
        teamLeaderPay nullable: true
        _member bindable: true
        _deleted bindable: true
        /*
        worker validator: { ChbUsers user, Workers obj, Errors error ->
            if(!user?.id && (obj.isTeamLeader || obj.payRate))
                println "user failed validation..."
                error.reject("nullable.jobreport.JobReport.fieldTeam.worker")
        }
        payRate validator: {BigDecimal val, Workers obj, Errors error ->
            if(!val && (obj.isTeamLeader || obj.worker?.id)) {
                println "payRate failed validation..."
                error.reject("nullable.jobreport.JobReport.fieldTeam.payRate")
            }
        }
        */
    }

    String toString(){
        return worker
    }
}
