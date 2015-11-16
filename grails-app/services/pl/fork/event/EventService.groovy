package pl.fork.event;

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.transaction.Transactional
import pl.fork.auth.User
import pl.fork.event.Event;

/**
 * Created by Patryk on 15.11.2015.
 */
@Transactional
public class EventService {
    def springSecurityService;

    Event join(Event event) {
        User user = springSecurityService.currentUser;
        event.addToParticipants(user)
        event.validate();

        if (!event.hasErrors()) {
            event.save flush:true;
        }
        event
    }
}
