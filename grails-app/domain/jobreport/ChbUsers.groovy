package jobreport

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class ChbUsers implements Serializable {

    private static final long serialVersionUID = 1

    ChbUsers(){
        this.calendar = false
    }

    String firstName
    String lastName
    String emailAddress
    String username
    String password
    String resetPassword
    String color
    boolean calendar
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    Set<Role> getAuthorities() {
        (ChbUsersRole.findAllByChbUsers(this) as List<ChbUsersRole>)*.role as Set<Role>
    }

    static constraints = {
        password password: true
        username unique: true
        emailAddress email: true
        color nullable: true
        resetPassword nullable: true
    }

    static mapping = {
	    password column: '`password`'
    }

    String toString(){
        return "$firstName $lastName"
    }
}
