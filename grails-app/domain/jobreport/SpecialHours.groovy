package jobreport

class SpecialHours {
    Date dateCreated
    Date lastUpdated
    ChbUsers employee
    Date date
    BigDecimal hours
    BigDecimal rate
    SpecialHoursEnum typeEnum

    static belongsTo = [siteReport:SiteReport]

    static constraints = {
        siteReport nullable: true
    }

    BigDecimal pay(){
        hours * rate
    }

    String toString(){
        typeEnum
    }
}
