package pl.fork.place

import grails.transaction.Transactional
import org.apache.commons.collections.CollectionUtils
import pl.fork.auth.User

import java.text.DateFormat
import java.text.SimpleDateFormat

@Transactional
class PlaceService {

    def springSecurityService

    Place get(int id){
        return Place.get(id)
    }

    Place get(Long id){
        return Place.get(id)
    }

    List<Place> filter(String name, String town, String timeAfter, String timeBefore) {

        DateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm", Locale.ENGLISH);
        String minDate = "1000/01/01 00:00";
        String maxDate = "3000/12/31 23:59"

        Date dateAfter = timeAfter != null && !"".equals(timeAfter) ? format.parse(timeAfter) : format.parse(minDate);
        Date dateBefore = timeBefore != null && !"".equals(timeBefore) ? format.parse(timeBefore) : format.parse(maxDate);

        List<Place> places = Place.createCriteria().list {
            if (name != null && !"".equals(name)) {
                eq("name", name)
            }

            if(timeAfter != null) {
                gt("dateCreated", dateAfter)
            }

            if(timeBefore != null) {
                lt("dateCreated", dateBefore)
            }

            if(town != null && !"".equals(town)) {
                eq("town", town)
            }
        }
        return places;
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

    List<Place> getAll(){
        return Place.getAll();
    }

    List<Place> getNear(def latitude, def longitude){
        //TODO: Implement method
        return getAll()
    }


    List<Score> getScores(Place place){
        place.scores.isEmpty() ? [] : place.scores
    }

    Score addScoreToPlace(Place place, parameters){
        Score score = new Score(parameters)
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        score.language = 'PL'
        score.place = place
        score.owner = currentUser
        score.validate()
        if( score && !score.hasErrors() ){
            place.addToScores(score)
            score.save(flush:true)
            place.save(flush:true)
        }
        else{
            return null
        }
        score
    }

    Score getUserScore(Place place) {
        User currentUser = User.findByUsername(springSecurityService.currentUser);
        List<Score> scores = Score.createCriteria().list {
            if (currentUser) {
                eq("owner", currentUser)
            }

            if(place) {
                eq("place", place)
            }
        }
        if (!CollectionUtils.isEmpty(scores)) {
            return scores.get(0);
        }
        return null;
    }

}
