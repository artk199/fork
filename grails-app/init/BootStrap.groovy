import pl.fork.auth.Role
import pl.fork.auth.User
import pl.fork.auth.UserService

class BootStrap {

    UserService userService

    def init = { servletContext ->

        /* Dodanie przyk³adowych rol do aplikacji */
        Role.findOrSaveWhere(authority: 'ROLE_USER')
        Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
        Role.findOrSaveWhere(authority: 'ROLE_MODERATOR')


        println "Deployed."
    }
    def destroy = {
    }
}
