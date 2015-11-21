package pl.fork.activity

import grails.transaction.Transactional
import pl.fork.auth.User
import pl.fork.auth.UserFriend
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
        Activity a = this.createFriendActivity(friendship.receiver, friendship.requester)
        Activity a2 = this.createFriendActivity(friendship.requester, friendship.receiver)
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

}
