package pl.fork.activity

import pl.fork.auth.User
import pl.fork.event.Event
import pl.fork.place.Score
import pl.fork.file.ForkFile
import org.grails.datastore.mapping.engine.event.*

class Activity implements Comparable {

	static belongsTo = [user:User]

	ActivityType activityType

	Date dateCreated
	Score score
	Long friend
	ForkFile image
	Event event

	static constraints = {
		score(nullable:true)
		friend(nullable:true)
		image(nullable:true)
		event(nullable:true)
	}

	@Override
	int compareTo(Object o) {
		Activity a = (Activity) o
		return -this.dateCreated.compareTo(a.dateCreated)
	}

	def activityService
	def afterInsert(){
		activityService.notifyUsers(this)
	}
}
