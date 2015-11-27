package pl.fork.auth

import pl.fork.event.Comment
import pl.fork.place.other.Report
import pl.fork.file.ForkFile
import pl.fork.place.Score
import pl.fork.activity.Activity

class User implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	static mappedBy = [requestedFriends: 'requester', receivedFriends: 'receiver']
	static hasMany = [images: ForkFile, scores: Score, requestedFriends: UserFriend, receivedFriends: UserFriend, activities:Activity, reports:Report, comments:Comment]

	String username
	String password
	String password_confirm
	String email
	String firstName
	String lastName
	String about
	String town
	String address

	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	ForkFile profilePicture

	User(){

	}

	User(String username, String password) {
		this()
		this.username = username
		this.password = password
	}

	@Override
	int hashCode() {
		username?.hashCode() ?: 0
	}

	@Override
	boolean equals(other) {
		is(other) || (other instanceof User && other.username == username)
	}

	@Override
	String toString() {
		username
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this)*.role
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

	static transients = ['springSecurityService','password_confirm','friends','friendInvitations','yourInvitations','allFriends']

	static constraints = {
		username blank: false, unique: true, size: 3..25
		password size: 5..64, blank: false
		email email: true, blank: false, unique: true
		profilePicture nullable: true
		firstName nullable: true
		lastName nullable: true
		town nullable: true
		address nullable: true
		about type: 'text', nullable: true
	}

	/**
	 * Method returning list of your accepted friends
	 * @return
     */
	List<User> getFriends(){
		List<User> friends = receivedFriends.findAll{ it.status == FriendshipStatus.ACCEPTED }.collect{ it.requester }
		friends += requestedFriends.findAll{ it.status == FriendshipStatus.ACCEPTED }.collect{ it.receiver }
		friends
	}

	/**
	 * Method returning list of friend invitations from others for you
	 * @return
     */
	List<User> getFriendInvitations(){
		List<User> friends = receivedFriends.findAll{ it.status == FriendshipStatus.PENDING }.collect{ it.requester }
		friends
	}

	/**
	 * Method returning list of friend invitations from you to others
	 * @return
     */
	List<User> getYourInvitations(){
		List<User> friends = requestedFriends.findAll{ it.status == FriendshipStatus.PENDING }.collect{ it.receiver }
		friends
	}

	/**
	 * Method returning all your friends even though some of them may not have accepted (or you might have not accepted)
	 * @return
     */
	List<User> getAllFriends(){
		List<User> friends = requestedFriends.collect{ it.receiver } + receivedFriends.collect{ it.requester }
		friends
	}

	static mapping = {
		password column: '`password`'
		about type: 'text'
		images sort: 'dateCreated', order: 'desc'
		activities sort: 'dateCreated', order: 'desc'
	}
}
