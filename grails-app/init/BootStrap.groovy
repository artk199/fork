import pl.fork.auth.Role

class BootStrap {

    def init = { servletContext ->

        Role.findOrSaveWhere(authority: 'ROLE_USER')
        Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
        Role.findOrSaveWhere(authority: 'ROLE_MODERATOR')

        println "Deployed."
    }
    def destroy = {
    }
}
