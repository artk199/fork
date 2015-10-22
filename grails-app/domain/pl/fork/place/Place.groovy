package pl.fork.place

import pl.fork.event.Event

class Place {

    static constraints = {
        address nullable:true
        email nullable:true
        phone nullable:true
        website nullable:true
        types minSize: 1
    }

    /*TODO: Uncomment services and sucessfully compile project */
    static hasMany = [scores: Score, types:PlaceType, /*services:AdditionalService,*/ events: Event]

    String name
    String description
    String address
    String email
    String phone
    String website

    boolean verified

    int x
    int y
    //Point coordinates
}
