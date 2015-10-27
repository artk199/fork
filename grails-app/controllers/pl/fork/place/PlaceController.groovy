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
        println("asd");
        println(params.name);
        params.max = Math.min(max ?: 10, 100)
        respond Place.list(params), model:[placeCount: Place.count()]
    }

    def show(Place place) {
        respond place
    }

    def get(int id){
        render placeService.get(id) as JSON
    }

    def filter(PlaceService placeService) {
        println("filter");
        println(placeService.getName());
        redirect Place.list(params), model:[placeCount: Place.count()]
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

    def search(){

        println params.search

        Map zabytek_1 = [:]
        zabytek_1['id'] = 10
        zabytek_1['name'] = 'Fontanna Neptuna'
        zabytek_1['description'] = 'Sika na wszystkich przechodniow od poczatku istnienia tego miasta'

        Map zabytek_2 = [:]
        zabytek_2['id'] = 22
        zabytek_2['name'] = 'Dom Artura'
        zabytek_2['description'] = 'Relikt PRLowej Polski w ruinie'

        Map zabytek_3 = [:]
        zabytek_3['id'] = 25
        zabytek_3['name'] = 'Molo w jelitkowie'
        zabytek_3['description'] = 'Lepiej jedź do Sopotu'

        Map zabytek_4 = [:]
        zabytek_4['id'] = 26
        zabytek_4['name'] = 'Kościół Mariacki'
        zabytek_4['description'] = 'Legenda głosi, że usiadł na niej olbrzym'

        Map zabytek_5 = [:]
        zabytek_5['id'] = 31
        zabytek_5['name'] = 'Dwór Artusa'
        zabytek_5['description'] = 'W sumie nic o tym nie wiem'

        List zabytki = [zabytek_1, zabytek_2, zabytek_3, zabytek_4, zabytek_5]

        render zabytki as JSON
    }

    def searchAll(){

        render "OK"
    }

}
