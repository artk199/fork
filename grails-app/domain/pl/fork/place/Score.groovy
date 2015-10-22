package pl.fork.place

class Score {

    static constraints = {
    }

    static belongsTo = [place:Place]

    String title
    String review
    String language
    int score

}
