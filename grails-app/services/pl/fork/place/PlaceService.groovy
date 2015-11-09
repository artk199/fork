package pl.fork.place

import grails.transaction.Transactional
import org.apache.commons.collections.CollectionUtils
import pl.fork.auth.User
import pl.fork.file.ForkFile

import javax.servlet.http.HttpServletRequest
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
                ilike("name", "%"+name+"%")
            }

            if(timeAfter != null) {
                gt("dateCreated", dateAfter)
            }

            if(timeBefore != null) {
                lt("dateCreated", dateBefore)
            }

            if(town != null && !"".equals(town)) {
                ilike("town", "%"+town+"%")
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
        List<Place> places = Place.createCriteria().list {
            if (query) {
                ilike("name", "%" + query + "%")
            }
        }
        /*
        zabytek_1['id'] = 10
        zabytek_1['name'] = 'Fontanna Neptuna'
        zabytek_1['description'] = 'Sika na wszystkich przechodniow od poczatku istnienia tego miasta'
         */
        places
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

    ForkFile addPhotoToPlace(Place place, HttpServletRequest request) {
        def f = request.getFile('image')
        ForkFile file = new ForkFile();
        file.source = f.bytes
        file.fileType = f.contentType
        file.title = request.getParameter('title');
        file.description = request.getParameter('description');
        file.place = place
        file.owner = User.findByUsername(springSecurityService.currentUser)
        file.validate()
        if( file && !file.hasErrors() ) {
            place.addToImages(file);
            file.save flush: true;
            place.save(flush: true)
        }
        else if (file) {
            file.errors.each { println it }
        }

        file;
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

    public String getGoogleMapString(Place place){
        String result
        if(place.town.empty || place.address.empty){
            result = place.name
        }
        else{
            result = place.town + "," + place.address
        }
        result = result.replaceAll(' ', '+')

        return result
    }


}
