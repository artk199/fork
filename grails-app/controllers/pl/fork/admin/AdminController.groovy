package pl.fork.admin

import grails.transaction.Transactional
import pl.fork.auth.UserService
import pl.fork.place.PlaceService
import grails.converters.JSON

@Transactional(readOnly = true)
class AdminController {
    PlaceService placeService
    UserService userService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {

    }

    def findPlace(){
        def places = placeService.filter(params.name, placeService.toList(params.types),
                params.town, null, null, params.address)
        render places as JSON
    }

    def findUser(){
        def users = userService.filterUsers(params.username, params.email)
        render users as JSON
    }
}
