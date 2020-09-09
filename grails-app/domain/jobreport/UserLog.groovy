package jobreport

class UserLog {
    Date dateCreated
    Date lastUpdated
    ChbUsers chbUser
    String type

    static constraints = {
        type  inList: ['Login','Logout']
    }
}
