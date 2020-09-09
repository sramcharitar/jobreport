package jobreport

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Secured('IS_AUTHENTICATED_FULLY')
@Transactional(readOnly = true)
class TimeSheetController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TimeSheet.list(params), model:[timeSheetCount: TimeSheet.count()]
    }

    def show(TimeSheet timeSheet) {
        respond timeSheet
    }

    def create() {
        respond new TimeSheet(params)
    }

    @Transactional
    def save(TimeSheet timeSheet) {
        println timeSheet.startDateTime
        println timeSheet.endDateTime
        if (timeSheet == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (timeSheet.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond timeSheet.errors, view:'create'
            return
        }

        timeSheet.save flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'timeSheet.label', default: 'TimeSheet'), timeSheet.id])
                redirect timeSheet
            }
            '*' { respond timeSheet, [status: CREATED] }
        }
    }

    def edit(TimeSheet timeSheet) {
        respond timeSheet
    }

    @Transactional
    def update(TimeSheet timeSheet) {
        if (timeSheet == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (timeSheet.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond timeSheet.errors, view:'edit'
            return
        }

        timeSheet.save flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'timeSheet.label', default: 'TimeSheet'), timeSheet.id])
                redirect timeSheet
            }
            '*'{ respond timeSheet, [status: OK] }
        }
    }

    @Transactional
    def delete(TimeSheet timeSheet) {

        if (timeSheet == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        timeSheet.delete flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.deleted.message', args: [message(code: 'timeSheet.label', default: 'TimeSheet'), timeSheet.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.not.found.message', args: [message(code: 'timeSheet.label', default: 'TimeSheet'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def addRow(){
        println "Adding new time log row..."
        render (template: "/siteReport/timeLog", model:[cnt:params.count, jobReport:JobReport.get(params.id)])
    }
}
