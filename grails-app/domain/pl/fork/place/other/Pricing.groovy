package pl.fork.place.other

class Pricing {

    static constraints = {
    }

    static belongsTo = [place:OtherPlace]
    static hasMany = [elements:PricedElement]

    String title
    String description

}
