package pl.fork.admin

import grails.transaction.Transactional
import pl.fork.activity.Activity
import pl.fork.auth.UserService
import pl.fork.place.PlaceService
import grails.converters.JSON

import static org.springframework.http.HttpStatus.NO_CONTENT

@Transactional
class AdminController {
    PlaceService placeService
    UserService userService
    AdminService adminService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        def images = adminService.getImagesWaitingForDecision();
        def pendingPlaces = placeService.findAllPending();
        def flaggedScores = placeService.getFlaggedScores();
        render view: "index", model: [waitingImages: images, pendingPlaces: pendingPlaces, flaggedScores: flaggedScores];
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

    def rejectPlace(){
        if(params.placeId){
            adminService.rejectPlace(params.placeId);
        }
        redirect(controller: "admin", action: "index")
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

    def acceptPlace(){
        if(params.placeId){
            adminService.acceptPlace(params.placeId);
        }
        redirect(controller: "admin", action: "index")
    }

    def getImagesWaitingForDecision(){
        return adminService.getImagesWaitingForDecision();
    }

    def closeReports(){
        if(params.id){
            adminService.removeReports(params.long("id"));
        }

        def scores = placeService.getFlaggedScores();
        def scoreList = scores.collect{[ "id": it.id, "owner_id": it.owner.id, "owner_name": it.owner.username,
            "title": it.title, "review": it.review, "reports_size": it.reports.size(), "version":it.version]};

        render scoreList as JSON;

    }

    def removeScore(){
        if(params.id){
            def score = placeService.getScore(params.long("id"));

            adminService.removeScore(score);
        }

        def scores = placeService.getFlaggedScores();
        def scoreList = scores.collect{[ "id": it.id, "owner_id": it.owner.id, "owner_name": it.owner.username,
            "title": it.title, "review": it.review, "reports_size": it.reports.size(), "version":it.version]};

        render scoreList as JSON;
    }
}
