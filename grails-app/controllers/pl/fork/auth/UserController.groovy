package pl.fork.auth

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class UserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    UserService userService


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        render(view:'index', model:[userList: User.list(params), userCount: User.count()])
    }

    def show(User user) {
        render(view:'show', model:[user:user])
    }

    def register() {
        render(view:'create', model:[user:new User(params)])
    }

    def save(User user) {

        /* Przypisanie z rêki potwierdzenia has³a, automatycznie nie chce przypisaæ... dunno why.*/
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
}
