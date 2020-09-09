package jobreport

class UserRoles {
    Date dateCreated
    Date lastUpdated
    String role
    String dashboard
    Integer level

    static constraints = {
        role blank: false, nullable: false
        dashboard blank: false, nullable: false
        level blank: false, nullable: false
    }

    String toString(){
        return role
    }
}
