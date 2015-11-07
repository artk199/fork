package fork

class UserTagLib {

    def springSecurityService

    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def loggedInUser = { attrs, body ->
        out << springSecurityService.principal.username
    }

    def currentUserID = { attrs, body ->
        out << springSecurityService.principal.id
    }

}
