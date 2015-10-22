package pl.fork.event

class Comment {

    static constraints = {
    }

    static belongsTo = [event:Event]

    String content

}
