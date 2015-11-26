package pl.fork.place

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class PlaceTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlaceType.list(params), model:[placeTypeCount: PlaceType.count()]
    }

    def show(PlaceType placeType) {
        respond placeType
    }

    def create() {
        respond new PlaceType(params)
    }

    @Transactional
    def save(PlaceType placeType) {
        if (placeType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (placeType.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond placeType.errors, view:'create'
            return
        }

        placeType.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'placeType.label', default: 'PlaceType'), placeType.id])
                redirect placeType
            }
            '*' { respond placeType, [status: CREATED] }
        }
    }

    def edit(PlaceType placeType) {
        respond placeType
    }

    @Transactional
    def update(PlaceType placeType) {
        if (placeType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (placeType.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond placeType.errors, view:'edit'
            return
        }

        placeType.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'placeType.label', default: 'PlaceType'), placeType.id])
                redirect placeType
            }
            '*'{ respond placeType, [status: OK] }
        }
    }

    @Transactional
    def delete(PlaceType placeType) {

        if (placeType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        placeType.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'placeType.label', default: 'PlaceType'), placeType.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'placeType.label', default: 'PlaceType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
