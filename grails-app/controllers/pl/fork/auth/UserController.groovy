package pl.fork.auth

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.grails.core.io.ResourceLocator
import org.springframework.core.io.Resource
import grails.converters.JSON

class UserController {

    UserService userService
    ResourceLocator grailsResourceLocator

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userCount: User.count()]
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

    def getImage(int userID, int imageID){
        //byte[] image = user.images(imageID).file
        //response.outputStream << image
        //TODO: move this togeter with resourceLocator to service
        def template
        if( imageID == 13 ){
            template = g.resource(dir:"images",file:"stock_2.png", absolute:"true")
        }
        else if( imageID == 22 ){
            template = g.resource(dir:"images",file:"background-new_york.png", absolute:"true")
        }
        else{
            template = g.resource(dir:"images",file:"stock.png", absolute:"true")
        }

        Resource r = grailsResourceLocator.findResourceForURI(template)
        render(file: r.inputStream,fileName: "stock.pdf")
    }

    def getAllImages(int userID){
       // render user.images as JSON
        def ids = [1,13,22,23, 77, 106, 450, 2001]
        render ids as JSON
    }

}
