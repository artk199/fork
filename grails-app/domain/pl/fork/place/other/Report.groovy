package pl.fork.place.other

import pl.fork.auth.User
import pl.fork.place.Score

class Report {

    Score score
    User owner
    Date dateCreated

    static belongsTo = [score: Score, owner : User]

    static constraints = {
    }
}
