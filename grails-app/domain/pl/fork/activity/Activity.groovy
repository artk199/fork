package pl.fork.activity

import pl.fork.auth.User
import pl.fork.place.Score
import pl.fork.file.ForkFile

class Activity implements Comparable {

	static belongsTo = [user:User]

	ActivityType activityType

	Date dateCreated
	Score score
	Long friend
	ForkFile image

	static constraints = {
		score(nullable:true)
		friend(nullable:true)
		image(nullable:true)
	}

	@Override
	int compareTo(Object o) {
		Activity a = (Activity) o
		return -this.dateCreated.compareTo(a.dateCreated)
	}
}
