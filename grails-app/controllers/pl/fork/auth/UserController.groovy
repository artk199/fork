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
        render userService.search() as JSON
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
        respond user
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

    def edit(User user) {
        respond user
    }

    @Transactional
    def update(User user) {
        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (user.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond user.errors, view:'edit'
            return
        }

        user.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    @Transactional
    def delete(User user) {

        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        user.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
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
        user.profilePicture = user.images.find{ it.id == imageID }
        user.save flush:true
        user.validate()
        if( user.hasErrors() ){
            response.status = 404
        }
        render "OK"
    }

}
