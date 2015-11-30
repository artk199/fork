package pl.fork.place.other

import pl.fork.place.Place

class Pricing {

    static mapping = {
        place lazy:false
    }

    static constraints = {
    }

    static belongsTo = [place:Place]
    static hasMany = [elements:PricedElement]

    String title
    String description

}
