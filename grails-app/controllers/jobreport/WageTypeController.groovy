package jobreport

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Secured('IS_AUTHENTICATED_FULLY')
@Transactional(readOnly = true)
class WageTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WageType.list(params), model:[wageTypeCount: WageType.count()]
    }

    def show(WageType wageType) {
        respond wageType
    }

    def create() {
        respond new WageType(params)
    }

    @Transactional
    def save(WageType wageType) {
        if (wageType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (wageType.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond wageType.errors, view:'create'
            return
        }

        wageType.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'wageType.label', default: 'WageType'), wageType.id])
                redirect wageType
            }
            '*' { respond wageType, [status: CREATED] }
        }
    }

    def edit(WageType wageType) {
        respond wageType
    }

    @Transactional
    def update(WageType wageType) {
        if (wageType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (wageType.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond wageType.errors, view:'edit'
            return
        }

        wageType.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'wageType.label', default: 'WageType'), wageType.id])
                redirect wageType
            }
            '*'{ respond wageType, [status: OK] }
        }
    }

    @Transactional
    def delete(WageType wageType) {

        if (wageType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        wageType.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'wageType.label', default: 'WageType'), wageType.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'wageType.label', default: 'WageType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
