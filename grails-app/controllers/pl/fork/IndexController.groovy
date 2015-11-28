package pl.fork

import pl.fork.auth.Status
import pl.fork.place.Place

class IndexController {

    def index(){
        Place p
        if( Place.count() > 0 ) {
            p = Place.find("from Place as p where p.status=:status order by rand()", [status: Status.APPROVED])
        }
        render view :"/index", model:[randomPlace: p]
    }
}
