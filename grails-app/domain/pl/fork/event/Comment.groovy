package pl.fork.event

import pl.fork.place.other.Report

class Comment {

    static constraints = {
    }

    static belongsTo = [event:Event]

    String content

}
