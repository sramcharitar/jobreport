package jobreport

class Client {
    Date dateCreated
    Date lastUpdated
    String name
    Location address
    Contact contact

    static mapping = {
        //address index: 'client_location_idx'
        //contact index: 'client_contact_idx'
    }

    static constraints = {
        name  blank:false
        address  nullable: false
        contact  nullable: false
    }

    @Override
    String toString(){
        return name
    }
}
