package pl.fork.place.other

import pl.fork.place.Place

class OtherPlace extends Place{

    static constraints = {
    }

    static hasMany = [hours:OpenHours]

    boolean entranceFee

}
