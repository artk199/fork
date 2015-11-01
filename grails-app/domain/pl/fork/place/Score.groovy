package pl.fork.place

import pl.fork.auth.User

class Score {

    static constraints = {
    }

    static mapping = {
        review type: 'text'
    }

    static belongsTo = [place:Place]

    String title
    String review
    String language
    int score

    User owner
    Date dateCreated
}
