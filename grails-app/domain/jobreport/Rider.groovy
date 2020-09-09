package jobreport

class Rider {
    Rider(){
        this.installerAcceptance = false
    }

    Date dateCreated
    Date lastUpdated

    String measuredBy
    Date measurementDate
    Date installationDate
    String specialInstructions
    boolean installerAcceptance
    Date installerAcceptanceDate

    static mapping = {
        specialInstructions type: "text"
    }
    static constraints = {
        specialInstructions nullable: true
        installerAcceptanceDate nullable: true
    }
}
