package pl.fork.place.other

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PricedElementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PricedElement.list(params), model:[pricedElementCount: PricedElement.count()]
    }

    def show(PricedElement pricedElement) {
        respond pricedElement
    }

    def create() {
        respond new PricedElement(params)
    }

    @Transactional
    def save(PricedElement pricedElement) {
        if (pricedElement == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (pricedElement.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond pricedElement.errors, view:'create'
            return
        }

        pricedElement.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pricedElement.label', default: 'PricedElement'), pricedElement.id])
                redirect pricedElement
            }
            '*' { respond pricedElement, [status: CREATED] }
        }
    }

    def edit(PricedElement pricedElement) {
        respond pricedElement
    }

    @Transactional
    def update(PricedElement pricedElement) {
        if (pricedElement == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (pricedElement.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond pricedElement.errors, view:'edit'
            return
        }

        pricedElement.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'pricedElement.label', default: 'PricedElement'), pricedElement.id])
                redirect pricedElement
            }
            '*'{ respond pricedElement, [status: OK] }
        }
    }

    @Transactional
    def delete(PricedElement pricedElement) {

        if (pricedElement == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        pricedElement.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'pricedElement.label', default: 'PricedElement'), pricedElement.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pricedElement.label', default: 'PricedElement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
