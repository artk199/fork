package pl.fork.place

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdditionalServiceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AdditionalService.list(params), model:[additionalServiceCount: AdditionalService.count()]
    }

    def show(AdditionalService additionalService) {
        respond additionalService
    }

    def create() {
        respond new AdditionalService(params)
    }

    @Transactional
    def save(AdditionalService additionalService) {
        if (additionalService == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (additionalService.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond additionalService.errors, view:'create'
            return
        }

        additionalService.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'additionalService.label', default: 'AdditionalService'), additionalService.id])
                redirect additionalService
            }
            '*' { respond additionalService, [status: CREATED] }
        }
    }

    def edit(AdditionalService additionalService) {
        respond additionalService
    }

    @Transactional
    def update(AdditionalService additionalService) {
        if (additionalService == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (additionalService.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond additionalService.errors, view:'edit'
            return
        }

        additionalService.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'additionalService.label', default: 'AdditionalService'), additionalService.id])
                redirect additionalService
            }
            '*'{ respond additionalService, [status: OK] }
        }
    }

    @Transactional
    def delete(AdditionalService additionalService) {

        if (additionalService == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        additionalService.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'additionalService.label', default: 'AdditionalService'), additionalService.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'additionalService.label', default: 'AdditionalService'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
