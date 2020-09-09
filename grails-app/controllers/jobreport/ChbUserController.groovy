package jobreport

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import org.springframework.transaction.TransactionStatus

@Secured("hasRole('ROLE_ADMIN')")
class ChbUserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        ChbUsers.async.task {
            [chbUserList: list(params), count: count() ]
        }.then { result ->
            respond result.chbUserList, model:[chbUserCount: result.count]
        }
    }

    def show(Long id) {
        ChbUsers.async.get(id).then { chbUser ->
            respond chbUser
        }
    }

    def create() {
        respond new ChbUsers(params)
    }

    def save(ChbUsers chbUser) {
        ChbUsers.async.withTransaction { TransactionStatus status ->
            if (chbUser == null) {
                status.setRollbackOnly()
                notFound()
                return
            }

            if(chbUser.hasErrors()) {
                status.setRollbackOnly()
                respond chbUser.errors, view:'create' // STATUS CODE 422
                return
            }

            chbUser.save flush:true
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'chbUser.label', default: 'ChbUser'), chbUser.id])
                    redirect chbUser
                }
                '*' { respond chbUser, [status: CREATED] }
            }
        }
    }

    def edit(Long id) {
        ChbUsers.async.get(id).then { chbUser ->
            respond chbUser
        }
    }

    def update(Long id) {
        ChbUsers.async.withTransaction { TransactionStatus status ->
            def chbUser = ChbUsers.get(id)
            if (chbUser == null) {
                status.setRollbackOnly()
                notFound()
                return
            }

            chbUser.properties = params
            if( !chbUser.save(flush:true) ) {
                status.setRollbackOnly()
                respond chbUser.errors, view:'edit' // STATUS CODE 422
                return
            }

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'ChbUser.label', default: 'ChbUser'), chbUser.id])
                    redirect chbUser
                }
                '*'{ respond chbUser, [status: OK] }
            }
        }
    }

    def delete(Long id) {
        ChbUsers.async.withTransaction { TransactionStatus status ->
            def chbUser = ChbUsers.get(id)
            if (chbUser == null) {
                status.setRollbackOnly()
                notFound()
                return
            }

            chbUser.delete flush:true

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'ChbUser.label', default: 'ChbUser'), chbUser.id])
                    redirect action:"index", method:"GET"
                }
                '*'{ render status: NO_CONTENT }
            }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'chbUser.label', default: 'ChbUser'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}