package pl.fork.place

class PlaceType {

    static constraints = {
    }

    static hasMany = [places:Place]
    static belongsTo = Place

    String tag
    String description

}
