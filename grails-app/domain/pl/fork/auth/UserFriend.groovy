package pl.fork.auth

class UserFriend {

    static constraints = {
    }

    static belongsTo = [requester:User,receiver:User]
    FriendshipStatus status = FriendshipStatus.PENDING

}
