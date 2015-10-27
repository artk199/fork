package pl.fork.place

import grails.transaction.Transactional

@Transactional
class PlaceService {

    def springSecurityService

    Place get(int id){
        return Place.get(id)
    }

    def save(Place place) {
        place.owner = springSecurityService.currentUser
        place.save(flush:true);
    }

    def delete(Place place) {
        place.delete(flush:true);
    }
}
