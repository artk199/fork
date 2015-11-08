package pl.fork.file

import grails.transaction.Transactional
import pl.fork.auth.User
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class ImageService {

    def springSecurityService

    ForkFile getImage(Long id){
        ForkFile.get(id)
    }

    ForkFile getImage(int id){
        ForkFile.get(id)
    }

    ForkFile getImage(String id){
        this.getImage(id.toLong())
    }

    ForkFile delete(int id){
        this.getImage(id).delete(flush: true)
    }

    ForkFile create(GrailsParameterMap parameters) {
        def f = parameters.get('file')
        ForkFile file = new ForkFile();
        User u = User.findByUsername(springSecurityService.currentUser)
        file.source = f.bytes
        file.fileType = f.contentType
        file.owner = u

        file.validate()
        if( file && !file.hasErrors() ) {
            u.addToImages(file)
            file.save flush: true
            u.save flush: true
        }
        else{
            file.errors.each{
                println it
            }
        }
        file
    }

}
