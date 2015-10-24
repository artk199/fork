package pl.fork.auth

import grails.transaction.Transactional

@Transactional
class UserService {

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

}
