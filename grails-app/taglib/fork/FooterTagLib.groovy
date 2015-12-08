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

        def places = placeService.getTopScoredPlaces(size);

        if(places) {
            out << "<ul>";
            for (Place p : places) {
                out << "<li>";
                if (p.town != null) {
                    out << "<a href='/place?town=" + p.town + "'>" + p.town + "</a>";
                    out << " - ";
                }
                out << "<a href='/place/show/" + p.id + "'>" + p.name + "</a>";
                out << "</li>";
            }
            out << "</ul>";
        }
        else{
            out<<"<p class='text-left pull-left' style='margin-top:10px;'>"+g.message(code:'footer.mostPopular.noEntries')+"</p>";
        }
    }

    def getNewestUsers = { attrs ->
        int maxSize = Integer.parseInt(attrs.maxSize)
        def users = userService.getNewestUsers(maxSize);

        if(users){
            out << "<ul>";
            for(User u : users){
                out << "<li>";
                out << "<a href='/user/show/" + u.id + "'>" + u.username + "</a>";
                out << "</li>";
            }
            out << "</ul>";
        }
        else{
            out<<"<p class='text-left pull-left' style='margin-top:10px;'>Brak zarejestrowanych u¿ytkowników.</p>";
        }
    }
}
