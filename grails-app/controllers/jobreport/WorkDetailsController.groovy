package jobreport

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Secured('IS_AUTHENTICATED_FULLY')
@Transactional(readOnly = true)
class WorkDetailsController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WorkDetails.list(params), model:[workDetailsCount: WorkDetails.count()]
    }

    def show(WorkDetails workDetails) {
        respond workDetails
    }

    def create() {
        respond new WorkDetails(params)
    }

    @Transactional
    def save(WorkDetails workDetails) {
        if (workDetails == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (workDetails.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond workDetails.errors, view:'create'
            return
        }

        workDetails.save flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'workDetails.label', default: 'WorkDetails'), workDetails.id])
                redirect workDetails
            }
            '*' { respond workDetails, [status: CREATED] }
        }
    }

    def edit(WorkDetails workDetails) {
        respond workDetails
    }

    @Transactional
    def update(WorkDetails workDetails) {
        if (workDetails == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (workDetails.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond workDetails.errors, view:'edit'
            return
        }

        workDetails.save flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'workDetails.label', default: 'WorkDetails'), workDetails.id])
                redirect workDetails
            }
            '*'{ respond workDetails, [status: OK] }
        }
    }

    @Transactional
    def delete(WorkDetails workDetails) {

        if (workDetails == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        workDetails.delete flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.deleted.message', args: [message(code: 'workDetails.label', default: 'WorkDetails'), workDetails.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.not.found.message', args: [message(code: 'workDetails.label', default: 'WorkDetails'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def addRow(){
        println "Adding new work details row..."
        render (template: "/common/workDetails", model:[cnt:params.count])
    }
}
