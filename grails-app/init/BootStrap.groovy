import pl.fork.auth.Role
import pl.fork.auth.User
import pl.fork.auth.UserService
import pl.fork.place.Place

class BootStrap {

    UserService userService

    def init = { servletContext ->

        /* Dodanie przyk³adowych rol do aplikacji */
        Role.findOrSaveWhere(authority: 'ROLE_USER')
        Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
        Role.findOrSaveWhere(authority: 'ROLE_MODERATOR')

        /** Dodanie kilku atrakcji */
        Place place = new Place()
        place.with{
            name = "Nazwa przykladowa"
            description = "Jakas dluzsza deskrypcja"
            address = "Grzybowo 4, 83-406 W¹glikowice"
            email = "emajl@polska.pl"
            phone = "661-891-571"
            website = "fork.pl"
            x = 11
            y = 99
        }


        place = new Place()
        place.with{
            name = "Nazwa przykladowa2"
            description = "Jakas dluzsza deskrypcja2"
            address = "Grzybowo 4, 83-406 W¹glikowice2"
            email = "emajl@polska2.pl"
            phone = "661-891-5721"
            website = "fork.pl"
            x = 21
            y = 99
        }
        place.save(flush:true)


        place.save(flush:true)

        println "Deployed."
    }
    def destroy = {
    }
}
