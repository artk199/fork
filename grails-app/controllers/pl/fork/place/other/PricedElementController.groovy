package pl.fork.place.other

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class PricedElementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PricedElement.list(params), model:[pricedElementCount: PricedElement.count()]
    }

    def show(PricedElement pricedElement) {
        respond pricedElement
    }

    def create(Pricing pricing) {
        PricedElement element = new PricedElement(params)
        element.pricing = pricing
        respond element
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

        /*
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pricedElement.label', default: 'PricedElement'), pricedElement.id])
                redirect pricedElement
            }
            '*' { respond pricedElement, [status: CREATED] }
        }*/
        redirect controller: "pricing", action: "show", id: pricedElement.pricing.id
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

        /*
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'pricedElement.label', default: 'PricedElement'), pricedElement.id])
                redirect pricedElement
            }
            '*'{ respond pricedElement, [status: OK] }
        }*/
        redirect controller: "pricing", action: "show", id: pricedElement.pricing.id
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
