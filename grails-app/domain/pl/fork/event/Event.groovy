package pl.fork.event

import grails.databinding.BindingFormat
import pl.fork.auth.User
import pl.fork.place.Place


enum Visibility{
    PUBLIC,
    FOR_FRIENDS,
    PRIVATE
}

class Event {

    static constraints = {
        place nullable: true
        visibility nullable: true
        participants nullable: true
        startDate min: new Date()
        endDate (validator: { val, obj ->
            val > obj.properties['startDate']
        })
    }

    static hasMany = [comments:Comment, participants:User]
    static belongsTo = [place:Place]

    String title
    String description

    @BindingFormat('yyyy/MM/dd HH:mm')
    Date startDate
    @BindingFormat('yyyy/MM/dd HH:mm')
    Date endDate

    Visibility visibility

    static transients = ['participantsAmount']

    def getParticipantsAmount(){
        return participants.size()
    }

}
