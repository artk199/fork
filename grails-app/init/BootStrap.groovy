import pl.fork.auth.Role
import pl.fork.auth.User
import pl.fork.auth.UserService
import pl.fork.place.Place
import grails.converters.JSON
import pl.fork.place.Score
import pl.fork.place.other.PricedElement
import pl.fork.place.other.Pricing
import pl.fork.place.PlaceType

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
                    id : user.id,
                    profilePicture : user.profilePicture ? user.profilePicture.id : null
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

        //dagrasso.addToPricing(pricing);
        //dagrasso.save();
        /*
              // Dodanie kilku menu do atrakcji

        Place dagrasso = new Place()
        dagrasso.with{
            name = "Da Grasso"
            description = "Opis da Grasso"
        }

        dagrasso.pricing = new HashSet<Pricing>();
        dagrasso.types = new HashSet<PlaceType>();

        Pricing pricing = new Pricing();
        pricing.elements = new HashSet<PricedElement>();

        pricing.with{
            title = "Pizze tradycyjne"
            description = "Do każdej pizzy dorzucane są dwa sosy (czosnkowy i pomidorowy) GRATIS."
        }

        PricedElement element = new PricedElement();
        element.with {
            name = "MARGHERITA"
            description = "ser, sos pomidorowy, oregano"
            price = 19
        }
        pricing.elements.add(element);

        element = new PricedElement();
        element.with {
            name = "CAPRICIOSA"
            description = "ser, sos pomidorowy, szynka, pieczarki, oregano"
            price = 21
        }
        pricing.elements.add(element);

        element = new PricedElement();
        element.with {
            name = "CALIFFO"
            description = "ser, sos pomidorowy, szynka, kabanosy, papryka konserwowa, oliwki zielone, oregano"
            price = 31
        }
        pricing.elements.add(element);

        dagrasso.pricing.add(pricing);

        pricing = new Pricing();
        pricing.elements = new HashSet<PricedElement>();

        pricing.with{
            title = "Pizze dla juniora"
            description = "Tutaj są pozycje dla najmłodszych."
        }

        element = new PricedElement();
        element.with {
            name = "HAVAI JUNIOR + CAPPY 0,33L"
            description = "ser, sos pomidorowy, szynka, ananasy, oregano"
            price = 15
        }
        pricing.elements.add(element);

        dagrasso.pricing.add(pricing);

        // Dodanie kilku typów dla atrakcji
        PlaceType type = new PlaceType();

        type.with{
            tag = "Restauracje"
            description = "Opis"
        }

        dagrasso.types.add(type);

        type = new PlaceType();

        type.with{
            tag = "Hotele"
            description = "Opis"
        }

        dagrasso.types.add(type);

        dagrasso.save(flush:true)
         */
        println "Deployed."
    }
    def destroy = {
    }
}
