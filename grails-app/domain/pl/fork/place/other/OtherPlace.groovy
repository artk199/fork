package pl.fork.place.other

import pl.fork.place.Place

class OtherPlace extends Place{

    static constraints = {
    }

    static hasMany = [pricings: Pricing, hours:OpenHours]

    boolean entranceFee

}
