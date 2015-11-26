import pl.fork.auth.Role
import pl.fork.auth.User
import pl.fork.auth.UserService
import pl.fork.place.Place
import grails.converters.JSON
import pl.fork.place.Score
import pl.fork.place.other.PricedElement
import pl.fork.place.other.Pricing
import pl.fork.place.PlaceType
import grails.util.Environment

class BootStrap {

    UserService userService

    def init = { servletContext ->
        if (Environment.current == Environment.DEVELOPMENT) {
            /* Dodanie przyk�adowych rol do aplikacji */
            Role.findOrSaveWhere(authority: 'ROLE_USER')
            Role.findOrSaveWhere(authority: 'ROLE_ADMIN')
            Role.findOrSaveWhere(authority: 'ROLE_MODERATOR')

            /** Dodanie kilku atrakcji */
            Place grzybowo = new Place()
            grzybowo.with {
                name = "Nazwa przykladowa"
                description = "Jakas dluzsza deskrypcja"
                address = "Grzybowo 4, 83-406 W�glikowice"
                email = "emajl@polska.pl"
                phone = "661-891-571"
                website = "fork.pl"
                x = 54.370532
                y = 18.610021
            }

            User u = new User()
            u.with {
                username = "Testowy Rysiek"
                password = "test1"
                password_confirm = "test1"
                email = "blabla@blabla.com"
            }
            u.save(flush: true)

            User u2 = new User()
            u2.with {
                username = "Testowy Tomek"
                password = "test1"
                password_confirm = "test1"
                email = "blabla1@blabla.com"
            }
            u2.save(flush: true)

            User u3 = new User()
            u3.with {
                username = "Testowy Przemo"
                password = "test1"
                password_confirm = "test1"
                email = "blabla3@blabla.com"
            }
            u3.save(flush: true)

            User u4 = new User()
            u4.with {
                username = "Testowy tester"
                password = "test1"
                password_confirm = "test1"
                email = "blabla4@blabla.com"
            }
            u4.save(flush: true)

            Place ratusz = new Place()
            ratusz.with {
                name = "Ratusz Nowego Miasta"
                description = "Ten ładniejszy ratusz często pokazywany na pocztówkach."
                x = 54.373132
                y = 18.614021
            }

            Place fontanna = new Place()
            fontanna.with {
                name = "Fontanna Neptuna"
                description = "Fontanna Neptuna przy Dworze Artusa."
                x = 54.370542
                y = 18.620021
            }

            Place artus = new Place()
            artus.with {
                name = "Dwór artusa"
                description = "Kamienica przy Fontannie Neptuna."
                x = 54.360932
                y = 18.608821
            }

            grzybowo.save(flush: true)
            ratusz.save(flush: true)
            fontanna.save(flush: true)
            artus.save(flush: true)

            // Dodanie kilku menu do atrakcji
            Place dagrasso = new Place()
            dagrasso.with {
                name = "Da Grasso"
                description = "Opis da Grasso"
                town = "Gdańsk"
                address = "Grunwaldzka"
                x = 54.370232
                y = 18.610321
            }
            dagrasso.save(flush: true)

            // MENU 1
            Pricing pricing = new Pricing();
            pricing.with {
                title = "Pizze tradycyjne"
                description = "Do każdej pizzy dorzucane są dwa sosy (czosnkowy i pomidorowy) GRATIS."
            }
            pricing.save(flush: true)

            PricedElement element = new PricedElement();
            element.with {
                name = "MARGHERITA"
                description = "ser, sos pomidorowy, oregano"
                price = 19
            }
            element.save(flush: true)
            pricing.addToElements(element);

            element = new PricedElement();
            element.with {
                name = "CAPRICIOSA"
                description = "ser, sos pomidorowy, szynka, pieczarki, oregano"
                price = 21
            }
            element.save(flush: true)
            pricing.addToElements(element);

            element = new PricedElement();
            element.with {
                name = "CALIFFO"
                description = "ser, sos pomidorowy, szynka, kabanosy, papryka konserwowa, oliwki zielone, oregano"
                price = 31
            }
            element.save(flush: true)
            pricing.addToElements(element);

            dagrasso.addToPricing(pricing)

            // MENU 2
            pricing = new Pricing();
            pricing.with {
                title = "Pizze dla juniora"
                description = "Tutaj są pozycje dla najmłodszych."
            }
            pricing.save(flush: true)

            element = new PricedElement();
            element.with {
                name = "HAVAI JUNIOR + CAPPY 0,33L"
                description = "ser, sos pomidorowy, szynka, ananasy, oregano"
                price = 15
            }
            element.save(flush: true)
            pricing.addToElements(element);

            dagrasso.addToPricing(pricing);

            // Dodanie kilku typów dla atrakcji
            PlaceType type = new PlaceType();
            type.with {
                tag = "Restauracje"
                description = "Opis"
            }
            type.save(flush: true)

            dagrasso.addToTypes(type);

            type = new PlaceType();
            type.with {
                tag = "Hotele"
                description = "Opis"
            }
            type.save(flush: true)

            dagrasso.addToTypes(type);
        }

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
                    id : user.id,
                    profilePicture : user.profilePicture ? user.profilePicture.id : null,
                    email : user.email,
                    role : user.authorities
            ]
        }


        JSON.registerObjectMarshaller( Place ) { Place place ->
            return place.properties + [avgScore: place.avgScore]
        }


        println "Deployed."
    }
    def destroy = {
    }
}
