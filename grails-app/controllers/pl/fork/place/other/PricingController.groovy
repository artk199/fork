package pl.fork.place.other

import pl.fork.place.Place

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class PricingController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Pricing.list(params), model:[pricingCount: Pricing.count()]
    }

    def show(Pricing pricing) {
        respond pricing
    }

    def create(Place place) {
        Pricing pricing = new Pricing(params);
        pricing.place = place;
        respond pricing
    }

    @Transactional
    def save(Pricing pricing) {
        if (pricing == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (pricing.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond pricing.errors, view:'create'
            return
        }

        pricing.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pricing.label', default: 'Pricing'), pricing.id])
                redirect pricing
            }
            '*' { respond pricing, [status: CREATED] }
        }
    }

    def edit(Pricing pricing) {
        respond pricing
    }

    @Transactional
    def update(Pricing pricing) {
        if (pricing == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (pricing.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond pricing.errors, view:'edit'
            return
        }

        pricing.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'pricing.label', default: 'Pricing'), pricing.id])
                redirect pricing
            }
            '*'{ respond pricing, [status: OK] }
        }
    }

    @Transactional
    def delete(Pricing pricing) {

        if (pricing == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        pricing.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'pricing.label', default: 'Pricing'), pricing.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
