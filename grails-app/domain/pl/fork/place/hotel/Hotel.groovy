package pl.fork.place.hotel

import pl.fork.place.Place

class Hotel extends Place{

    static constraints = {
    }

    static hasMany = [rooms:Room]

    int roomsAmount
    int stars
}
