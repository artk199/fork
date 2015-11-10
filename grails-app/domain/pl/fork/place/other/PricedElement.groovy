package pl.fork.place.other

class PricedElement {

    static constraints = {
    }

    static belongsTo = [pricing:Pricing]

    String name
    String description
    int price

}
