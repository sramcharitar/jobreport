package jobreport

class Location {
    Date dateCreated
    Date lastUpdated
    String street
    String city
    String state
    String zipcode

    static belongsTo = [client:Client, jobReport:JobReport]
    static constraints = {
        client nullable: true
        jobReport nullable: true
        street blank: false
        city blank: false
        state blank: false
        zipcode blank: false
    }

    String toString(){
        return "${street}, ${city}, ${state} ${zipcode}"
    }
}
