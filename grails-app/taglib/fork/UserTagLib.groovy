package fork

class UserTagLib {

    def springSecurityService

    static defaultEncodeAs = [taglib:'html']
    static returnObjectForTags = ['currentUserID']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def loggedInUser = { attrs, body ->
        out << springSecurityService.principal.username
    }

    def currentUserID = { attrs, body ->
        return springSecurityService.principal.id
    }

    def timeSince = { attrs ->
        use(groovy.time.TimeCategory) {
            def duration = new Date() - attrs.date
            if (duration.hours > 24)
                out << "Ponad dzien temu"
            else if( duration.hours < 24 && duration.hours > 6 )
                out << duration.hours + "godzin temu"
            else if( duration.hours < 6 && duration.hours >= 1 )
                out << duration.hours + " godzin " + duration.minutes + " minut temu"
            else if( duration.hours == 0 ){
                if( duration.minutes > 3 ){
                    out << duration.minutes + " minut temu"
                }
                else{
                    out << "dosłownie przed chwilą"
                }
            }
        }
    }

}
