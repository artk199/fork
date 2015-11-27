package pl.fork.place

import pl.fork.auth.User
import pl.fork.place.other.Report

class Score {

    static constraints = {
    }

    static mapping = {
        review type: 'text'
    }

    static belongsTo = [place:Place, owner: User]

    static hasMany = [reports: Report]

    String title
    String review
    String language
    int score

    Date dateCreated
}
