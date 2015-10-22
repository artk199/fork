package pl.fork.place

class AdditionalService {

    static constraints = {
        places minSize: 1
    }

    static hasMany = [places:Place]
    static belongsTo = Place

    String title

}
