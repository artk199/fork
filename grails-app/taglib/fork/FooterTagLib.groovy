package fork

import grails.converters.JSON
import pl.fork.auth.User
import pl.fork.auth.UserService
import pl.fork.place.Place
import pl.fork.place.PlaceService

import java.text.DecimalFormat

class FooterTagLib {
    static namespace = "foot"
    static returnObjectForTags = ['getTopScoredPlaces']
    static defaultEncodeAs = "raw"

    PlaceService placeService
    UserService userService

    def getTopScoredPlaces = { attrs ->
        int size = Integer.parseInt(attrs.maxSize)
        size = (size == 0 ? 0 : size - 1);

        def places = placeService.getTopScoredPlaces(size);

        out << "<ul>";
        for(Place p : places){
            out << "<li>";
            if(p.town != null){
                out << "<a href='/place?town=" + p.town + "'>" + p.town + "</a>";
                out << " - ";
            }
            out << "<a href='/place/show/" + p.id + "'>" + p.name + "</a>";
            out << " - " + (p.avgScore > 0 ? p.avgScore : 0);
            out << "</li>";
        }
        out << "</ul>";
    }

    def getNewestUsers = { attrs ->
        int maxSize = Integer.parseInt(attrs.maxSize)
        maxSize = (maxSize == 0 ? 0 : maxSize - 1);
        def users = userService.getNewestUsers(maxSize);

        out << "<ul>";
        for(User u : users){
            out << "<li>";
            out << "<a href='/user/show/" + u.id + "'>" + u.username + "</a>";
            out << "</li>";
        }
        out << "</ul>";
    }
}
