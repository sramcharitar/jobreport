package jobreport

import org.springframework.boot.autoconfigure.batch.BatchProperties

class Contact {
    Date dateCreated
    Date lastUpdated
    String firstName
    String lastName
    String phone
    String email
    String company

    static belongsTo = [client:Client]
    static constraints = {
        client nullable:true
        company blank:true, nullable:true
        firstName blank:false
        lastName blank:false
        phone blank:false
        email email:true, blank:true, nullable:true
    }

    @Override
    String toString(){
        return "${firstName} ${lastName}"
    }
}
