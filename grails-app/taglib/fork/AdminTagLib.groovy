package fork

import pl.fork.auth.User
import pl.fork.auth.UserService
import pl.fork.place.Place
import pl.fork.place.PlaceService

class AdminTagLib {
    static namespace = "admin"
    static defaultEncodeAs = "raw"

    PlaceService placeService

    def getAllPlaces = { attrs ->
        def places = placeService.filter(null, null, null, null, null, null);
        if (places.size() == 0) {
            out << "<p>" + g.message(code: "admin.tabs.places.noPlaces") + "</p>";
        } else {
            out << "<table class=\"table table-striped text-left sortable\" id=\"all-places-table\">";
            out << "<caption>";
            out << "<span class=\"pull-right\"><span class=\"glyphicon glyphicon-th\"></span>";
            out << g.message(code: "default.count", args: [places.size()]) + "</span></caption>";
            out << "<thead><tr><th class='col-md-3 col-sm-3 col-xs-3' data-defaultsort=\"asc\" data-firstsort=\"desc\">";
            out << "<span class=\"glyphicon glyphicon-list-alt\"></span>" + g.message(code: "admin.tabs.places.name") + "</th>";
            out << "<th class='col-md-5 col-sm-5 col-xs-5'><span class=\"glyphicon glyphicon-comment\"></span>";
            out << g.message(code: "admin.tabs.places.description") + "</th>";
            out << "<th class='col-md-2 col-sm-2 col-xs-2'><span class=\"glyphicon glyphicon-map-marker\"></span>";
            out << g.message(code: "admin.tabs.places.town") + "</th>";
            out << "<th class='col-md-2 col-sm-2 col-xs-2'><span class=\"glyphicon glyphicon-road\"></span>";
            out << g.message(code: "admin.tabs.places.address") + "</th></tr></thead><tbody>";
            for (Place p : places) {
                out << "<tr>";
                // place name column
                out << "<td class='col-md-3 col-sm-3 col-xs-3'><a href=\"/place/show/" + p.id + "\">";
                out << p.name + "</a><div class=\"pull-right\"><a href=\"/place/edit/" + p.id + "\">";
                out << "<g:message code=\"default.link.edit\"/>" + g.message(code: "default.link.edit") + "</a></div></td>";
                // description column
                out << "<td class='col-md-5 col-sm-5 col-xs-5'>" + p.description + "</td>";
                // town column
                out << "<td class='col-md-2 col-sm-2 col-xs-2'>";
                out << ((p.town?.size() > 0) ? p.town : g.message(code: "default.input.empty"));
                out << "</td>";
                // address column
                out << "<td class='col-md-2 col-sm-2 col-xs-2'>";
                out << ((p.town?.size() > 0) ? p.address : g.message(code: "default.input.empty"));
                out << "</td>";
                out << "</tr>"
            }
            out << "</tbody></table>"
        }
    }
}
