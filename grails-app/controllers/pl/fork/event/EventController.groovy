package pl.fork.event

import pl.fork.place.Place
import pl.fork.place.PlaceService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class EventController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    EventService eventService;
    PlaceService placeService;

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Event.list(params), model:[eventCount: Event.count()]
    }

    def show(Event event) {
        Comment comment = eventService.getUserComment(event);
        List<Comment> comments = eventService.getComments(event);
        boolean signedUser = eventService.isUserSigned(event);
        respond event, model:[comment:comment, comments:comments, signedUser:signedUser]
    }

    def create() {
        List<Place> places = placeService.findAllApproved();
        respond new Event(params), model:[places: places]
    }

    @Transactional
    def save(Event event) {
        if (event == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (event.hasErrors()) {
            transactionStatus.setRollbackOnly()
            List<Place> places = placeService.findAllApproved();
            respond event.errors, view:'create', model:[places: places]
            return
        }

        event.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'event.label', default: 'Event'), event.id])
                redirect event
            }
            '*' { respond event, [status: CREATED] }
        }
    }

    def addComment(Event event) {
        eventService.addCommentToEvent(event, params);
        redirect action:"show",id:event.id;
    }

    def edit(Event event) {
        List<Place> places = placeService.findAllApproved();
        respond event, model:[places: places]
    }

    @Transactional
    def update(Event event) {
        if (event == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (event.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond event.errors, view:'edit'
            return
        }

        event.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), event.id])
                redirect event
            }
            '*'{ respond event, [status: OK] }
        }
    }

    @Transactional
    def delete(Event event) {

        if (event == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        event.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'event.label', default: 'Event'), event.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Transactional
    def join(Event event) {
        Event respEvent = eventService.join(event);
        redirect action:"show", id: respEvent.id
    }

    @Transactional
    def unjoin(Event event) {
        Event respEvent = eventService.unjoin(event);
        redirect action:"show", id: respEvent.id
    }
}
