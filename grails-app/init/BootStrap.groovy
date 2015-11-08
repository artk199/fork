import pl.fork.auth.Role
import pl.fork.auth.User
import pl.fork.auth.UserService
import pl.fork.place.Place
import grails.converters.JSON
import pl.fork.place.Score

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

        User u = new User()
        u.with{
            username = "blabla"
            password = "blabla"
            password_confirm = "blabla"
            email = "blabla@blabla.com"
        }
        u.save(flush: true)

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

        JSON.registerObjectMarshaller( Score ) { Score score ->
            return [
                    owner : score.owner,
                    id : score.id,
                    score : score.score,
                    place : score.place,
                    review : score.review,
                    language : score.language,
                    title : score.title,
            ]
        }

        JSON.registerObjectMarshaller( User ) { User user ->
            return [
                    username : user.username,
                    id : user.id
            ]
        }

        JSON.registerObjectMarshaller( Place ) { Place place ->
            return [
                    adress : place.address,
                    description : place.description,
                    name : place.name,
                    id : place.id
            ]
        }

        println "Deployed."
    }
    def destroy = {
    }
}
