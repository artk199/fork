package pl.fork.place.other

import pl.fork.auth.User
import pl.fork.auth.UserRole
import pl.fork.place.Place
import pl.fork.place.PlaceService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class PricedElementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    PlaceService placeService
    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PricedElement.list(params), model:[pricedElementCount: PricedElement.count()]
    }

    def show(PricedElement pricedElement) {
        respond pricedElement
    }

    @Transactional
    def create(Pricing pricing) {
        def isAdmin = false;
        UserRole.withTransaction {
            def roles = springSecurityService.getPrincipal().getAuthorities();
            for(def role in roles){ if(role.getAuthority() == "ROLE_ADMIN") isAdmin = true };
        }
        User currentUser = User.findByUsername(springSecurityService.currentUser);

        // if params are set
        if(params['pricing.id']){
            Pricing pr = placeService.getPricing(params.long('pricing.id'));
            Place p = pr?.place;

            if(!isAdmin && (currentUser == null || p?.owner == null || currentUser.id != p.owner.id)){
                redirect view: "/noPermError"
                return
            }
        }
        else{
            if(!isAdmin){
                redirect view:  "/noPermError"
                return
            }
        }
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

        pricedElement.clearErrors()
        pricedElement.price = params.double("price")
        pricedElement.validate()

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
