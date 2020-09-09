package jobreport

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*

@Secured('IS_AUTHENTICATED_FULLY')
class ProductInfoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def nav

    ProductInfoController(){
        this.nav = "summary"
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ProductInfo.list(params), model:[productInfoCount: ProductInfo.count(), nav:getNav()]
    }

    def show(ProductInfo productInfo) {
        respond productInfo
    }

    def create() {
        respond new ProductInfo(params)
    }

    def save(ProductInfo productInfo) {
        if (productInfo == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (productInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond productInfo.errors, view:'create'
            return
        }

        productInfo.save flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'productInfo.label', default: 'ProductInfo'), productInfo.id])
                redirect productInfo
            }
            '*' { respond productInfo, [status: CREATED] }
        }
    }

    def edit(ProductInfo productInfo) {
        respond productInfo
    }

    def update(ProductInfo productInfo) {
        if (productInfo == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (productInfo.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond productInfo.errors, view:'edit'
            return
        }

        productInfo.save flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'productInfo.label', default: 'ProductInfo'), productInfo.id])
                redirect productInfo
            }
            '*'{ respond productInfo, [status: OK] }
        }
    }

    def delete(ProductInfo productInfo) {

        if (productInfo == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        productInfo.delete flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.deleted.message', args: [message(code: 'productInfo.label', default: 'ProductInfo'), productInfo.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.not.found.message', args: [message(code: 'productInfo.label', default: 'ProductInfo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def addRow(){
        render (template: "/common/rolls", model:[idx:params.idx, cnt:params.count])
    }

    def addProduct(){
        render (template: "/common/products", model:[idx:params.count])
    }

    private def getNav(){
        //println this.nav
        return this.nav
    }
}
