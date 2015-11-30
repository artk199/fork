package fork

import pl.fork.auth.UserRole
import pl.fork.place.Place
import pl.fork.place.PlaceService

class CheckPermissionTagLib {
    static namespace = "permission"
    static defaultEncodeAs = "raw"

    def springSecurityService
    PlaceService placeService

    def hasAccess = { attrs, body ->
        def isAdmin = false;
        def isOwner = attrs.boolean('isOwner');
        isOwner = isOwner as Boolean;

        UserRole.withTransaction {
            def roles = springSecurityService.getPrincipal().getAuthorities();
            for(def role in roles){ if(role.getAuthority() == "ROLE_ADMIN") isAdmin = true };
        }

        def displayNoPermInfo = attrs.boolean('displayNoPermInfo');

        // Check if user can see this content
        if(isAdmin || isOwner){
            out << body()
        }
        // Check if user should be notified when he cant see this content
        else if(displayNoPermInfo){
            out << render(template:"/noPermissions")
        }
    }
}
