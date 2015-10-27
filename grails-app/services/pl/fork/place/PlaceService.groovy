package pl.fork.place

import grails.transaction.Transactional

@Transactional
class PlaceService {

    def springSecurityService

    Place get(int id){
        return Place.get(id)
    }

    Place save(Place place) {
        place.owner = springSecurityService.currentUser
        place.save(flush:true);
    }

    def delete(Place place) {
        place.delete(flush:true);
    }

    List<Place> search(String query){
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

        [zabytek_1, zabytek_2, zabytek_3, zabytek_4, zabytek_5]
    }


}
