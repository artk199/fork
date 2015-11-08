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

}
