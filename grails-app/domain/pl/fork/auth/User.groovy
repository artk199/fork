package pl.fork.auth

import pl.fork.file.ForkFile
import pl.fork.place.Score

class User implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	List images
	static mappedBy = [requestedFriends: 'requester', receivedFriends: 'receiver']
	static hasMany = [images: ForkFile, scores: Score, requestedFriends: UserFriend, receivedFriends: UserFriend]

	String username
	String password
	String password_confirm
	String email

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

	static transients = ['springSecurityService','password_confirm','friends','friendInvitations','allFriends']

	static constraints = {
		username blank: false, unique: true, size: 3..25
		password size: 5..64, blank: false
		email email: true, blank: false, unique: true
		profilePicture nullable: true
	}

	List<User> getFriends(){
		List<User> friends = receivedFriends.findAll{ it.status == FriendshipStatus.ACCEPTED }.collect{ it.requester }
		friends += requestedFriends.findAll{ it.status == FriendshipStatus.ACCEPTED }.collect{ it.receiver }
		friends
	}

	List<User> getFriendInvitations(){
		List<User> friends = receivedFriends.findAll{ it.status == FriendshipStatus.PENDING }.collect{ it.requester }
		friends
	}

	List<User> getAllFriends(){
		List<User> friends = requestedFriends.collect{ it.receiver } + receivedFriends.collect{ it.requester }
		friends
	}

	static mapping = {
		password column: '`password`'

	}
}
