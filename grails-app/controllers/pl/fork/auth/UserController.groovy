package pl.fork.auth

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.core.io.ResourceLocator
import grails.converters.JSON
import org.grails.web.json.JSONObject
class UserController {

    UserService userService
    ResourceLocator grailsResourceLocator

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        /*params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userCount: User.count()]*/
        render User.list() as JSON

    }

    def search(){
        if( params.query ){
            render userService.search(params.query) as JSON
        }
        else{
            render ''
        }
    }

    def addFriend(int id){
        UserFriend u = userService.addFriend(id)
        if( !u ){
            response.status = 500
            render "FAIL"
            return
        }
        render "OK"
    }

    def modifyFriend(int id){
        JSONObject parameters = request.JSON
        userService.resolveFriendship(id,parameters)
        render "OK"
    }

    def getFriends(){
        List<User> friends = userService.getFriends()
        List<User> requests = userService.getFriendRequests()
        List<User> invitations = userService.getInvitations()
        Map data = ['friends': friends, 'requests':requests, 'invitations': invitations]
        render data as JSON
    }

    def show(User user) {
        SortedSet activities = userService.getFriendsActivities()
        respond user, model:[activities: activities]
    }

    def register() {
        render(view:'create', model:[user:new User(params)])
    }

    def save(User user) {

        /* Przypisanie z r�ki potwierdzenia has�a, automatycznie nie chce przypisa�... dunno why.*/
        user.password_confirm = params.password_confirm

        userService.register(user)
        println user.errors

        if (user == null) {
            notFound()
            return
        }

        if (user.hasErrors()) {
            respond user.errors, view:'create'
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])

        redirect(uri:'/')

    }

    def editPassword(User user){
        if( userService.isValid(user) )
            respond user
        else{
            response.status = 403
            render view :"/errors/error403"
        }
    }

    def submitChange(User user){
        def message = userService.changePassword(user,params)
        if( message != "OK"){
            flash.message = message
            redirect(uri:"/user/editPassword/${user.id}")
        }
        else {
            flash.message = "user.changed.success"
            redirect(uri: "/user/show/${user.id}")
        }
    }

    def edit(User user) {
        if( userService.isValid(user) )
            respond user
        else{
            response.status = 403
            render view :"/errors/error403"
        }
    }

    @Transactional
    def update(User user) {

        /*  */
        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (user.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond user.errors, view: 'edit'
            return
        }
        if (userService.isValid(user)){
            /* Update roles*/
            def roles = params.list('authorities');
            UserRole.removeAll(user,true);
            roles?.each { role ->
                userService.addRoleToUser(user,role)
            }
            user.save flush: true
        }
        else{
            response.status = 403
            render view :"/errors/error403"
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    def getAllImages(int userID){
       // render user.images as JSON
        def ids = User.findById(userID).images.collect{ it.id }
        render ids as JSON
    }

    def setProfile(int userID, int imageID){
        User user = User.findById(userID)

        if( !user ){
            response.status = 404
        }

        if( userService.isValid(user) ){
            user.profilePicture = user.images.find{ it.id == imageID }
            user.save flush:true
            user.validate()
            if( user.hasErrors() ){
                response.status = 404
            }
            render "OK"
        }
        else{
            response.status = 403
            render "FORBIDDEN"
        }

    }

    def getActivities(int id){
        List activities = userService.getActivities(id,params.offset.toInteger(), params.max.toInteger())
        render activities as JSON
    }

    def getFriendsActivities(int id){
        List activities = userService.getFriendsActivities(id,params.offset.toInteger(), params.max.toInteger())
        render activities as JSON
    }
}
