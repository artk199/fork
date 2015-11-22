package pl.fork.admin

import grails.transaction.Transactional
import pl.fork.auth.UserService
import pl.fork.place.PlaceService
import grails.converters.JSON

@Transactional
class AdminController {
    PlaceService placeService
    UserService userService
    AdminService adminService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def images = adminService.getImagesWaitingForDecision();
        render view: "index", model: [waitingImages: images];
    }

    def findPlace(){
        def places = placeService.filter(params.name, placeService.toList(params.types),
                params.town, null, null, params.address);
        render places as JSON;
    }

    def findUser(){
        def users = userService.filterUsers(params.username, params.email);
        render users as JSON;
    }

    def upadateImages(){
        def images = adminService.getImagesWaitingForDecision();
        render images as JSON;
    }

    def rejectImage(){
        if(params.id){
            adminService.rejectImage(params.id);
        }
        def images = adminService.getImagesWaitingForDecision();
        def imagesList = images.collect{["title": it.title, "id": it.id, "place_id": it.place?.id,
        "place_name": it.place?.name, "dateCreated": it.dateCreated, "user_id": it.owner.id, "user_name": it.owner.username]};
        render imagesList as JSON
    }

    def acceptImage(){
        if(params.id){
            adminService.acceptImage(params.id);
        }
        def images = adminService.getImagesWaitingForDecision();
        def imagesList = images.collect{["title": it.title, "id": it.id, "place_id": it.place?.id,
                "place_name": it.place?.name, "dateCreated": it.dateCreated, "user_id": it.owner.id, "user_name": it.owner.username]};

        render imagesList as JSON
    }

    def getImagesWaitingForDecision(){
        return adminService.getImagesWaitingForDecision();
    }
}
