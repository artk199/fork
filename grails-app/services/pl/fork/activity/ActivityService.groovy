package pl.fork.activity

import grails.transaction.Transactional
import pl.fork.auth.User
import pl.fork.auth.UserFriend
import pl.fork.event.Event
import pl.fork.file.ForkFile
import pl.fork.place.Place
import pl.fork.place.Score

@Transactional
class ActivityService {

    def springSecurityService

    Activity createReviewActivity(Score score){
        Activity activity = new Activity()
        activity.activityType = ActivityType.REVIEW
        activity.score = score
        User user = User.findByUsername(springSecurityService.currentUser)
        activity.user = user
        user.addToActivities(activity)
        user.save flush:true
        activity.save flush:true
        activity
    }

    Activity createImageActivity(ForkFile file){
        Activity activity = new Activity()
        activity.activityType = ActivityType.IMAGE
        activity.image = file
        User user = User.findByUsername(springSecurityService.currentUser)
        activity.user = user
        user.addToActivities(activity)
        user.save flush:true
        activity.save flush:true
        activity
    }

    Activity createFriendshipActivity(UserFriend friendship){
        this.createFriendActivity(friendship.receiver, friendship.requester)
        this.createFriendActivity(friendship.requester, friendship.receiver)
    }

    Activity createFriendActivity(User user, User friend){
        Activity activity = new Activity()
        activity.activityType = ActivityType.FRIEND
        activity.friend = friend.id
        activity.user = user
        user.addToActivities(activity)
        user.save flush:true
        activity.save flush:true
        activity
    }

    Activity createInviteActivity(User user, User friend){
        Activity activity = new Activity()
        activity.activityType = ActivityType.INVITE
        activity.friend = friend.id
        activity.user = user
        user.addToActivities(activity)
        user.save flush:true
        activity.save flush:true
        activity
    }

    Activity createEventActivity(Event event){
        Activity activity = new Activity()
        activity.activityType = ActivityType.EVENT
        activity.event = event
        User user = User.findByUsername(springSecurityService.currentUser)
        activity.user = user
        user.addToActivities(activity)
        user.save flush:true
        activity.save flush:true
        activity
    }

    void notifyUsers(Activity activity){
        switch ( activity.activityType ){
            case ActivityType.IMAGE :
            case ActivityType.REVIEW :
            case ActivityType.EVENT :
                activity.user.friends.each{ User friend ->
                    notify "userNotification", "{receiver: ${friend.username}, notification: activity }"
                }
                break
            case ActivityType.INVITE :
                User u = User.findById(activity.friend)
                notify "userNotification", "{receiver: ${u.username}, notification: friendInvite }"
                break
            case ActivityType.FRIEND:
                activity.user.friends.each{ User friend ->
                    notify "userNotification", "{receiver: ${friend.username}, notification: friend }"
                }
                break
        }
    }
}
