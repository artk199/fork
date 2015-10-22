package pl.fork.place.hotel

class Room {

    static constraints = {
    }

    static belongsTo = [hotel:Hotel]

    String name
    int price
    int bedsAmount

    boolean kitchen
    boolean bathroom

}
