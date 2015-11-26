package pl.fork.event

class Comment {

    static constraints = {
    }

    static belongsTo = [event:Event]

    static hasMany = [reports: Report]

    String content

}
