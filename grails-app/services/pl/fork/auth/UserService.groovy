package pl.fork.auth

import grails.transaction.Transactional

@Transactional
class UserService {

    def register(String username, String password, String email ) {
        User u = new User()

        u.username = username
        u.password = password
        u.email = email

        u.save(flush:true)

        if(u.hasErrors()){
            return u
        }

        Role r = Role.findWhere(authority:'ROLE_USER')
        UserRole userRole = new UserRole(u,r)

        userRole.save( flush:true )

        return u
    }

}
