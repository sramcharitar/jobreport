package jobreport

class JobProgressStatus {
    Date dateCreated
    Date lastUpdated
    String state

    static constraints = {
        state blank: false
    }

    @Override
    String toString(){
        return state
    }
}
