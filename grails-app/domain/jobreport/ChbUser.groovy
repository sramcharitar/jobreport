package jobreport

@Deprecated
class ChbUser {

    ChbUser(){
        this.calendar = false
    }

    Date dateCreated
    Date lastUpdated
    String firstName
    String lastName
    String emailAddress
    String employeeId
    String password
    UserState state
    UserRoles role
    boolean calendar

    static mapping = {

    }
    static constraints = {
        firstName nullable: false, blank: false
        lastName  nullable: false, blank: false
        emailAddress  nullable: false, blank: false
        employeeId  nullable: false, blank: false
        password  nullable: true, blank: true
        state  nullable: false
        role nullable: false
        calendar nullable:false
    }

    def beforeInsert(){
        this.password = password?.encodeAsSHA1()
    }

    String toString(){
        return firstName + " " + lastName
    }
}
