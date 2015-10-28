package pl.fork.place

import grails.converters.JSON
import org.springframework.validation.FieldError

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON

@Transactional(readOnly = true)
class PlaceController {

    PlaceService placeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond placeService.filter(params.name, params.town, params.timeAfter, params.timeBefore), model:[placeCount: Place.count()]
    }

    def show(Place place) {
        respond place
    }

    def get(int id){
        render placeService.get(id) as JSON
    }

    def create() {
        respond new Place(params)
    }

    def save(Place place) {

        if (place == null) {
            notFound()
            return
        }

        placeService.save(place);

        if (place.hasErrors()) {
            respond place.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'place.label', default: 'Place'), place.id])
                redirect place
            }
            '*' { respond place, [status: CREATED] }
        }
    }

    def edit(Place place) {
        respond place
    }

    @Transactional
    def update(Place place) {
        if (place == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (place.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond place.errors, view:'edit'
            return
        }

        place.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'place.label', default: 'Place'), place.id])
                redirect place
            }
            '*'{ respond place, [status: OK] }
        }
    }

    def delete(Place place) {

        if (place == null) {
            notFound()
            return
        }

        placeService.delete(place)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'place.label', default: 'Place'), place.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'place.label', default: 'Place'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def search(def params){

        List foundPlaces = placeService.search(params['search'])

        render foundPlaces as JSON
    }

    def searchAll(def params){

        List foundPlaces = placeService.search(params['search'])

        render view:'/place/index_2', model:[places:foundPlaces]
    }

}
