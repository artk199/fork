package pl.fork.register

import grails.transaction.Transactional
import pl.fork.auth.User
import pl.fork.auth.UserService

import static org.springframework.http.HttpStatus.NOT_FOUND

@Transactional
class RegisterController {
    UserService userService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    private static String REQUIRED_INFO_VIEW = "steps/required"
    private static String ADDITIONAL_INFO_VIEW = "steps/additional"
    private static String SUMMARY_VIEW = "steps/summary"
    private static String MAIN_VIEW = "index"

    def index() {
        render view: MAIN_VIEW
    }

    def showRequiredInfo(){
        render view: REQUIRED_INFO_VIEW, model:[user:new User(params)]
    }

    def validateRequiredInfo(User user){
        // check if user filled properly all fields
        user.password_confirm = params.password_confirm
        userService.validateFields(user)

        if (user == null) {
            notFound()
            return
        }

        if (user.hasErrors()) {
            respond user.errors, view: REQUIRED_INFO_VIEW, model:[user:user]
            return
        }

        session["user"] = user

        render view: ADDITIONAL_INFO_VIEW, model:[user:user]
    }

    def showSummaryView(){
        def user =  session["user"]
        user.properties = params

        render view: SUMMARY_VIEW, model:[user:user]
    }

    def finalizeRegistration(){
        def user =  session["user"]
        user.properties = params

        userService.register(user)
        println user.errors

        if (user == null) {
            notFound()
            return
        }

        if (user.hasErrors()) {
            render view: SUMMARY_VIEW, model:[user:user]
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])

        redirect(uri:'/')
    }

    def backToRequiredInfo(){
        def user =  session["user"]
        render view: REQUIRED_INFO_VIEW, model:[user:user]
    }

    def backToAdditionalInfo(){
        def user =  session["user"]
        render view: ADDITIONAL_INFO_VIEW, model:[user:user]
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
}
