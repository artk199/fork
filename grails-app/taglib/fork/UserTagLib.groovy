package fork

class UserTagLib {

    def springSecurityService

    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def loggedInUser = { attrs, body ->
        out << springSecurityService.principal.username
    }
}
