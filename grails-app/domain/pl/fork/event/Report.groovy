package pl.fork.event

import pl.fork.auth.User

class Report {

    Comment comment
    User owner
    Date dateCreated

    static belongsTo = [comment: Comment, owner : User]

    static constraints = {
    }
}
