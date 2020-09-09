package jobreport

class UserState {
    Date dateCreated
    Date lastUpdated
    String state

    static constraints = {
        state nullable: false, blank: false
    }
}
