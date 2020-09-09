package jobreport

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured("IS_AUTHENTICATED_FULLY")
class DocumentsController {

    DocumentsService documentsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond documentsService.list(params), model:[documentsCount: documentsService.count()]
    }

    def show(Long id) {
        respond documentsService.get(id)
    }

    def create() {
        respond new Documents(params)
    }

    def save(Documents documents) {
        if (documents == null) {
            notFound()
            return
        }

        try {
            documentsService.save(documents)
        } catch (ValidationException e) {
            respond documents.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'documents.label', default: 'Documents'), documents.id])
                redirect documents
            }
            '*' { respond documents, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond documentsService.get(id)
    }

    def update(Documents documents) {
        if (documents == null) {
            notFound()
            return
        }

        try {
            documentsService.save(documents)
        } catch (ValidationException e) {
            respond documents.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'documents.label', default: 'Documents'), documents.id])
                redirect documents
            }
            '*'{ respond documents, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        documentsService.delete(id)

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.deleted.message', args: [message(code: 'documents.label', default: 'Documents'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.not.found.message', args: [message(code: 'documents.label', default: 'Documents'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
