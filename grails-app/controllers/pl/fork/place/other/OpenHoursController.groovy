package pl.fork.place.other

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OpenHoursController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond OpenHours.list(params), model:[openHoursCount: OpenHours.count()]
    }

    def show(OpenHours openHours) {
        respond openHours
    }

    def create() {
        respond new OpenHours(params)
    }

    @Transactional
    def save(OpenHours openHours) {
        if (openHours == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (openHours.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond openHours.errors, view:'create'
            return
        }

        openHours.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'openHours.label', default: 'OpenHours'), openHours.id])
                redirect openHours
            }
            '*' { respond openHours, [status: CREATED] }
        }
    }

    def edit(OpenHours openHours) {
        respond openHours
    }

    @Transactional
    def update(OpenHours openHours) {
        if (openHours == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (openHours.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond openHours.errors, view:'edit'
            return
        }

        openHours.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'openHours.label', default: 'OpenHours'), openHours.id])
                redirect openHours
            }
            '*'{ respond openHours, [status: OK] }
        }
    }

    @Transactional
    def delete(OpenHours openHours) {

        if (openHours == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        openHours.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'openHours.label', default: 'OpenHours'), openHours.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'openHours.label', default: 'OpenHours'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
