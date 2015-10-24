package pl.fork.place

import grails.transaction.Transactional

@Transactional
class PlaceService {

    def savePlace(Place place) {
        place.save(flush:true);
    }


}
