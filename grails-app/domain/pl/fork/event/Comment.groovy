package pl.fork.event

import pl.fork.auth.User
import pl.fork.place.other.Report

class Comment {

    static constraints = {
    }

    static belongsTo = [event:Event, owner: User]

    String title
    String description
    String language

    Date dateCreated

}
