package pl.fork.auth

import grails.transaction.Transactional
import pl.fork.activity.Activity
import pl.fork.activity.ActivityService
import pl.fork.file.ForkFile
@Transactional
class UserService {

    def springSecurityService
    ActivityService activityService

    def register(String username, String password,String password_confirm, String email ) {
        User u = new User()
        u.username = username
        u.password = password
        u.password_confirm = password_confirm
        u.email = email

        return register(u)
    }

    @Transactional
    def register(User user){


        if(user.password_confirm != user.password){
            user.errors.rejectValue("password","matching.passwords")
        }else{
            user.save(flush:true)
        }

        if(user.hasErrors()){
            return user
        }

        addRoleToUser(user,"ROLE_ADMIN");

        return user
    }

    def addRoleToUser(User user, String s) {
        Role role = Role.findWhere(authority:s)
        UserRole userRole = new UserRole(user,role)
        userRole.save( flush:true )

    }

    List<ForkFile> getUserImages(User user) {
        List<ForkFile> images = ForkFile.createCriteria().list {
            if (user) {
                eq("owner", user)
            }
        }
        return images;
    }

    List<User> search(){
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        List<User> users = User.list()
        users = users - currentUser - currentUser.allFriends
        println currentUser.friends
        users
    }

    UserFriend addFriend(int id){
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        User receiver = User.findById(id)

        UserFriend friendship = new UserFriend()
        friendship.requester = currentUser
        friendship.receiver = receiver

        friendship.validate()
        if( !friendship.hasErrors() ){
            currentUser.addToRequestedFriends(friendship)
            receiver.addToReceivedFriends(friendship)
            friendship.save flush:true
            notify "userNotification", "{receiver: ${receiver}, notification: friendInvite }"
        }
        friendship
    }

    UserFriend resolveFriendship(int id, parameters){
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        User requester = User.findById(id)

        UserFriend friendship = UserFriend.findByRequesterAndReceiver(requester, currentUser)

        if( !friendship ){
            friendship = UserFriend.findByRequesterAndReceiver(currentUser, requester)
            if( !friendship ) {
                return friendship
            }
        }

        println parameters['status']
        if( parameters['status'] ){
            if( parameters['status'] == 'accept' ){
                activityService.createFriendshipActivity(friendship)
                friendship.status = FriendshipStatus.ACCEPTED

            }
            else if( parameters['status'] == 'reject' ){
                friendship.status = FriendshipStatus.REJECTED
            }
        }
        friendship.save flush:true
    }

    List<User> getFriends(){
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        currentUser.friends
    }

    List<User> getFriendRequests(){
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        currentUser.friendInvitations
    }

    List<User> getInvitations(){
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        currentUser.yourInvitations
    }

    SortedSet<Activity> getFriendsActivities(){
        SortedSet<Activity> activities = new TreeSet()
        User currentUser = User.findByUsername(springSecurityService.currentUser)
        if( currentUser ) {
            currentUser.friends.each { User friend ->
                friend.activities.each { Activity activity ->
                    activities.add(activity)
                }
            }
        }
        activities
    }

}
