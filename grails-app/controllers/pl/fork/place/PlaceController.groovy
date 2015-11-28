package pl.fork.place

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.SpringSecurityUtils
import pl.fork.auth.RoleType
import pl.fork.auth.Status
import pl.fork.auth.User
import pl.fork.file.ForkFile
import pl.fork.file.ImageService

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.web.json.JSONObject

@Transactional
class PlaceController {
    PlaceService placeService
    ImageService imageService
    SpringSecurityService springSecurityService;

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        String accepts = request.getHeader('accept')
        if( accepts.contains('html')){
            def places = placeService.filter(params.name, placeService.toList(params.types),
                    params.town, params.timeAfter, params.timeBefore, null)
            println "HTML"
            render view:"index", model:[placeList: places, placeCount: Place.count()]
            return
        }
        if( accepts.contains('json')){
            render Place.list() as JSON
        }

    }

    def show(Place place) {
        Score score = placeService.getUserScore(place);
        respond place, model:[score:score]
    }

    def get(int id){
        render placeService.get(id) as JSON
    }

    def getAll(double latitude,double longitude){
        render placeService.getNear(latitude,longitude) as JSON
    }

    def all(){
        render placeService.filter_dynamic(params.offset,params.max, params.name, placeService.toList(params.types), params.town, null) as JSON
    }

    def create() {
        respond new Place(params)
    }

    def save(Place place) {

        if (place == null) {
            notFound()
            return
        }

        User user = User.findByUsername(springSecurityService.currentUser)
        //jeżeli rola użytkownika to admin to miejsce od razu akceptowane
        if (SpringSecurityUtils.ifAnyGranted(RoleType.ROLE_ADMIN.name())) {
            place.status=Status.APPROVED;
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
        /* Fix for #190 */
        place.clearErrors()
        place.x = params.double("x")
        place.y = params.double("y")

        place.validate()
        if (place.hasErrors()) {
            println place.errors
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

        render view:'/place/index', model:[places:foundPlaces, placeCount: Place.count()]
    }

    def getScores(Long id){
        Place place = placeService.get(id)
        def result
        if( place && params.offset && params.max ){
            long offset = params.offset.toLong()
            long max = params.max.toLong()
            result = placeService.getScores(place, offset, max)
        }
        else{
            result = placeService.getScores(place)
        }
        if( !result ){
            result = []
        }
        render result as JSON

    }

    def addScore(Long id){
        JSONObject parameters = new JSONObject(request.reader.text)
        Place place = placeService.get(id)
        Score score = placeService.addScoreToPlace(place,parameters)
        render score as JSON
    }

    /** Metoda do testowania logowania */
    def getPlace() {
        render Place.get(1) as JSON;
    }

    def upload(Place place) {
        ForkFile image = imageService.create(params, place);
        println place
        render image.id
    }

    def linkImage(Long id){
        JSONObject parameters = new JSONObject(request.reader.text)
        Place place = placeService.get(id)
        placeService.addPhotoToPlace(place, parameters)
        render "OK"
    }


    def getAllImages(int placeID){
        Place place = placeService.get(placeID)
        render place.images.collect{ it.id } as JSON
    }

    def getNear(){
        List <Place> places;

        if(params.x && params.y){
            double x = params.x as Double;
            double y = params.y as Double;
            places = placeService.getNear(x, y);
        }
        else{
            places = new ArrayList<Place>();
        }
        render places as JSON
    }

    def reportScore(long id) {
        def score = placeService.getScore(id);
        placeService.createReport(score);

        def place = score.place
        Score userScore = placeService.getUserScore(place);
        redirect action: "show", id: place.id
    }

    def getMetascore(int id){
        render placeService.getMetascore(id) as JSON
    }

    def registerOwner(Place place) {
        placeService.registerOwner(place);
        redirect action: "show", id: place.id
    }
}
