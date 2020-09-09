package jobreport

import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.codehaus.groovy.util.HashCodeHelper
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@ToString(cache=true, includeNames=true, includePackage=false)
class ChbUsersRole implements Serializable {

	private static final long serialVersionUID = 1

	ChbUsers chbUsers
	Role role

	@Override
	boolean equals(other) {
		if (other instanceof ChbUsersRole) {
			other.chbUsersId == chbUsers?.id && other.roleId == role?.id
		}
	}

    @Override
	int hashCode() {
	    int hashCode = HashCodeHelper.initHash()
        if (chbUsers) {
            hashCode = HashCodeHelper.updateHash(hashCode, chbUsers.id)
		}
		if (role) {
		    hashCode = HashCodeHelper.updateHash(hashCode, role.id)
		}
		hashCode
	}

	static ChbUsersRole get(long chbUsersId, long roleId) {
		criteriaFor(chbUsersId, roleId).get()
	}

	static boolean exists(long chbUsersId, long roleId) {
		criteriaFor(chbUsersId, roleId).count()
	}

	private static DetachedCriteria criteriaFor(long chbUsersId, long roleId) {
		ChbUsersRole.where {
			chbUsers == ChbUsers.load(chbUsersId) &&
			role == Role.load(roleId)
		}
	}

	static ChbUsersRole create(ChbUsers chbUsers, Role role, boolean flush = false) {
		def instance = new ChbUsersRole(chbUsers: chbUsers, role: role)
		instance.save(flush: flush)
		instance
	}

	static boolean remove(ChbUsers u, Role r) {
		if (u != null && r != null) {
			ChbUsersRole.where { chbUsers == u && role == r }.deleteAll()
		}
	}

	static int removeAll(ChbUsers u) {
		u == null ? 0 : ChbUsersRole.where { chbUsers == u }.deleteAll() as int
	}

	static int removeAll(Role r) {
		r == null ? 0 : ChbUsersRole.where { role == r }.deleteAll() as int
	}

	static constraints = {
	    chbUsers nullable: false
		role nullable: false, validator: { Role r, ChbUsersRole ur ->
			if (ur.chbUsers?.id) {
				if (ChbUsersRole.exists(ur.chbUsers.id, r.id)) {
				    return ['userRole.exists']
				}
			}
		}
	}

	static mapping = {
		id composite: ['chbUsers', 'role']
		//version false
	}
}
