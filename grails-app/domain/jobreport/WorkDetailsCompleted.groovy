package jobreport

class WorkDetailsCompleted {
    Date dateCreated
    Date lastUpdated
    WorkDetails workDetails
    Date dateCompleted
    ChbUsers worker
    Integer qtyCompleted
    boolean highScaffold
    BigDecimal psfRate
    BigDecimal plfRate
    String notes
    boolean toBeRemoved = false

    static belongsTo = [siteReport:SiteReport]
    static transients = ['toBeRemoved']
    static constraints = {
        highScaffold nullable: true
        psfRate nullable: true
        plfRate nullable: true
        notes blank: true, nullable: true
        toBeRemoved bindable: true
    }
}
