package pl.fork.place.other

import pl.fork.auth.User
import pl.fork.auth.UserRole
import pl.fork.place.Place
import pl.fork.place.PlaceService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class PricingController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    PlaceService placeService
    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Pricing.list(params), model:[pricingCount: Pricing.count()]
    }

    def show(Pricing pricing) {
        respond pricing
    }

    @Transactional
    def create(Place place) {
        def isAdmin = false;
        UserRole.withTransaction {
            def roles = springSecurityService.getPrincipal().getAuthorities();
            for(def role in roles){ if(role.getAuthority() == "ROLE_ADMIN") isAdmin = true };
        }
        User currentUser = User.findByUsername(springSecurityService.currentUser);

        // if params are set
        if(params['place.id']){
            Place p = placeService.get(params.long('place.id'))

            if(!isAdmin && (currentUser == null || p.owner == null || currentUser.id != p.owner.id)){
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
