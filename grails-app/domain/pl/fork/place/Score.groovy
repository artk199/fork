package pl.fork.place

import pl.fork.auth.User

class Score {

    static constraints = {
    }

    static mapping = {
        review type: 'text'
    }

    static belongsTo = [place:Place, owner: User]

    String title
    String review
    String language
    int score

    Date dateCreated
}
