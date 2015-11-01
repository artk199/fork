import pl.fork.auth.Role
import pl.fork.auth.User
import pl.fork.auth.UserService
import pl.fork.place.Place

class BootStrap {

    UserService userService

    def init = { servletContext ->

        /* Dodanie przyk�adowych rol do aplikacji */
        Role.findOrSaveWhere(authority: 'ROLE_USER')
        Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
        Role.findOrSaveWhere(authority: 'ROLE_MODERATOR')

        /** Dodanie kilku atrakcji */
        Place grzybowo = new Place()
        grzybowo.with{
            name = "Nazwa przykladowa"
            description = "Jakas dluzsza deskrypcja"
            address = "Grzybowo 4, 83-406 W�glikowice"
            email = "emajl@polska.pl"
            phone = "661-891-571"
            website = "fork.pl"
            x = 11
            y = 99
        }


        Place ratusz = new Place()
        ratusz.with{
            name = "Ratusz Nowego Miasta"
            description = "Ten ładniejszy ratusz często pokazywany na pocztówkach."
        }

        Place fontanna = new Place()
        fontanna.with{
            name = "Fontanna Neptuna"
            description = "Fontanna Neptuna przy Dworze Artusa."
        }

        Place artus = new Place()
        artus.with{
            name = "Dwór artusa"
            description = "Kamienica przy Fontannie Neptuna."
        }

        grzybowo.save(flush:true)
        ratusz.save(flush:true)
        fontanna.save(flush:true)
        artus.save(flush:true)

        println "Deployed."
    }
    def destroy = {
    }
}
