package pl.fork.register

import grails.transaction.Transactional

@Transactional(readOnly = true)
class RegisterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {

    }
}
