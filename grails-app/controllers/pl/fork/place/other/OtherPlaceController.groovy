package pl.fork.place.other

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OtherPlaceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond OtherPlace.list(params), model:[otherPlaceCount: OtherPlace.count()]
    }

    def show(OtherPlace otherPlace) {
        respond otherPlace
    }

    def create() {
        respond new OtherPlace(params)
    }

    @Transactional
    def save(OtherPlace otherPlace) {
        if (otherPlace == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (otherPlace.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond otherPlace.errors, view:'create'
            return
        }

        otherPlace.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'otherPlace.label', default: 'OtherPlace'), otherPlace.id])
                redirect otherPlace
            }
            '*' { respond otherPlace, [status: CREATED] }
        }
    }

    def edit(OtherPlace otherPlace) {
        respond otherPlace
    }

    @Transactional
    def update(OtherPlace otherPlace) {
        if (otherPlace == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (otherPlace.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond otherPlace.errors, view:'edit'
            return
        }

        otherPlace.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'otherPlace.label', default: 'OtherPlace'), otherPlace.id])
                redirect otherPlace
            }
            '*'{ respond otherPlace, [status: OK] }
        }
    }

    @Transactional
    def delete(OtherPlace otherPlace) {

        if (otherPlace == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        otherPlace.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'otherPlace.label', default: 'OtherPlace'), otherPlace.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'otherPlace.label', default: 'OtherPlace'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
