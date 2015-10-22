package pl.fork.event

import pl.fork.place.Place


enum Visibility{
    PUBLIC,
    FOR_FRIENDS,
    PRIVATE
}

class Event {

    static constraints = {
    }

    static hasMany = [comments:Comment]
    static belongsTo = [place:Place]

    String title
    String description

    Date startDate
    Date endDate

    Visibility visibility

}
