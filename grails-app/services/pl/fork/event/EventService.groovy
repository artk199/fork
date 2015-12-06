package pl.fork.event;

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.transaction.Transactional
import org.apache.commons.collections.CollectionUtils
import pl.fork.activity.ActivityService
import pl.fork.auth.User
import pl.fork.event.Event

import java.text.DateFormat
import java.text.SimpleDateFormat

/**
 * Created by Patryk on 15.11.2015.
 */
@Transactional
public class EventService {

    def springSecurityService;
    ActivityService activityService

    Event join(Event event) {
        User user = springSecurityService.currentUser;
        event.addToParticipants(user)
        user.addToEvents(event)
        event.validate();
        if (!event.hasErrors()) {
            user.save flush:true;
            event.save flush:true;
            activityService.createEventActivity(event)
        }
        event
    }

    Event unjoin(Event event) {
        User user = springSecurityService.currentUser;
        event.removeFromParticipants(user)
        user.removeFromEvents(event)
        event.validate();

        if (!event.hasErrors()) {
            user.save flush:true;
            event.save flush:true;
        }
        event
    }

    List<Comment> getComments(Event event){
        event.comments.isEmpty() ? [] : event.comments.asList()
    }

    boolean isUserSigned(Event event) {
        User user = User.findByUsername(springSecurityService.currentUser);
        event.participants.contains(user);
    }

    Comment addCommentToEvent(Event event, parameters){
        Comment comment = new Comment(parameters);
        User currentUser = User.findByUsername(springSecurityService.currentUser);
        comment.language = 'PL';
        comment.owner = currentUser;
        comment.event = event;
        comment.validate();
        if( comment && !comment.hasErrors() ){
            event.addToComments(comment);
            comment.save(flush:true)
            event.save(flush:true)
        }
        else{
            return null
        }
        comment
    }

    Comment getUserComment(Event event) {
        User currentUser = User.findByUsername(springSecurityService.currentUser);
        List<Comment> comments = Comment.createCriteria().list {
            if (currentUser) {
                eq("owner", currentUser)
            }

            if(event) {
                eq("event", event)
            }
        }
        if (!CollectionUtils.isEmpty(comments)) {
            return comments.get(0);
        }
        return null;
    }

    List<Event> filter(String name, String timeAfter, String timeBefore) {

        DateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm", Locale.ENGLISH);
        String minDate = "1000/01/01 00:00";
        String maxDate = "3000/12/31 23:59"

        Date dateAfter = timeAfter != null && !"".equals(timeAfter) ? format.parse(timeAfter) : format.parse(minDate);
        Date dateBefore = timeBefore != null && !"".equals(timeBefore) ? format.parse(timeBefore) : format.parse(maxDate);

        List<Event> events = Event.createCriteria().list {
            if (name != null && !"".equals(name)) {
                ilike("title", "%"+name+"%")
            }

            if(timeAfter != null && !timeBefore) {
                ge("endDate", dateAfter)
            }

            if(timeBefore != null && !timeAfter) {
                le("startDate", dateBefore)
            }

            if(timeAfter != null && timeBefore != null) {
                or{
                    and {
                        ge("endDate", dateAfter)
                        le("endDate", dateBefore)
                    }
                    and {
                        ge("startDate", dateAfter)
                        le("startDate", dateBefore)
                    }
                }
            }
        }
        return events.unique();
    }
}
