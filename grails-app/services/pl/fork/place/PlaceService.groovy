package pl.fork.place

import grails.transaction.Transactional
import org.apache.commons.collections.CollectionUtils
import pl.fork.activity.ActivityService
import pl.fork.auth.Status
import pl.fork.auth.User
import pl.fork.file.ForkFile
import pl.fork.file.ImageService

import java.text.DateFormat
import java.text.SimpleDateFormat

@Transactional
class PlaceService {
    private static final double START_DISTANCE = 0;
    private static final double MAX_DISTANCE = 1000;
    private static final double DISTANCE_DIFF = 200;
    private static final int MAX_PLACES_IN_NEAR = 20;

    def springSecurityService
    ImageService imageService
    ActivityService activityService

    Place get(int id){
        return Place.get(id)
    }

    Place get(Long id){
        return Place.get(id)
    }

    def toList(value) {
        [value].flatten().findAll { it != null }
    }

    List<Place> filter(String name, List<String> placeTypes, String town, String timeAfter, String timeBefore, String address) {
        filter(name, placeTypes, town, timeAfter, timeBefore, address, Status.APPROVED);
    }

    List<Place> findAllPending() {
        filter(null, null, null, null, null, null, Status.PENDING);
    }

    List<Place> filter(String name, List<String> placeTypes, String town, String timeAfter, String timeBefore, String address, Status status) {

        DateFormat format = new SimpleDateFormat("yyyy/MM/dd", Locale.ENGLISH);
        String minDate = "1000/01/01";
        String maxDate = "3000/12/31"

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

            if (address != null && !"".equals(address)) {
                ilike("address", "%"+address+"%")
            }

            if (status) {
                eq("status", status)
            }

            if(placeTypes != null && placeTypes.size() > 0){
                or {
                    placeTypes.each { str ->
                        types{
                            idEq(str.toLong())
                        }
                    }
                }
            }
        }
        return places.unique();
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

    List<Place> getNear(double latitude, double longitude){
        List<Place> list = new ArrayList<Place>();
        List<Place> allPlaces = filter(null, null, null, null, null, null, Status.APPROVED);

        // make sure max_places won't go out of index
        int max_places = allPlaces.size() > MAX_PLACES_IN_NEAR ? MAX_PLACES_IN_NEAR : allPlaces.size();
        double radius = START_DISTANCE;

        // iterate searching until it reached max_places or radius is too big
        while(list.size() < max_places && radius <= MAX_DISTANCE){
            for(Place p : allPlaces ){
                // Check this place only if it has set X and Y position
                if(p.getX() && p.getY()){
                    double distance = getDistance(p.getX(),p.getY(), latitude, longitude);

                    if(distance <= radius && !list.contains(p)){
                        list.add(p);
                    }
                }
            }
            radius += DISTANCE_DIFF;
        }

        return list;
    }

    private static double getDistance(double x1, double y1, double x2, double y2) {
        double longDifference = y1 - y2;
        double part1 = Math.sin(degreeToRadians(x1)) * Math.sin(degreeToRadians(x2));
        double part2 = Math.cos(degreeToRadians(x1)) * Math.cos(degreeToRadians(x2)) * Math.cos(degreeToRadians(longDifference));
        double distanceInKm = radiansToDegree(Math.acos(part1 + part2));
        distanceInKm = distanceInKm * 60 * 1.1515 * 1609.344;

        return (distanceInKm);
    }

    private static double degreeToRadians(double degree) {
        return (degree * Math.PI / 180.0);
    }

    private static double radiansToDegree(double radian) {
        return (radian * 180 / Math.PI);
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
            activityService.createReviewActivity(score)
        }
        else{
            return null
        }
        score
    }

    ForkFile addPhotoToPlace(Place place, Map parameters){
        if( !parameters.containsKey('image')){
            return null
        }
        ForkFile image = imageService.getImage(parameters.get('image'))

        if( !image ){
            return null
        }

        if( image.place ){
            image.place.images.remove(image)
        }

        image.place = place
        place.addToImages(image);
        image.save flish:true
        place.save flush:true
        image
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

    // Find all

    // Sort places list by descending score
    public List<Place> getTopScoredPlaces(int maxSize){
        def allPlaces = filter(null, null, null, null, null, null, Status.APPROVED);

        if(allPlaces.size() == 0){
            return null
        }

        allPlaces.sort{-it.getProperty("avgScore")};
        int size = maxSize >= allPlaces.size() ? allPlaces.size() -1 : maxSize;
        return allPlaces[0..size];
    }
}
