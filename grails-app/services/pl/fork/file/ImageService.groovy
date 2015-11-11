package pl.fork.file

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.transaction.Transactional
import pl.fork.auth.Role
import pl.fork.auth.RoleType
import pl.fork.auth.User
import grails.web.servlet.mvc.GrailsParameterMap
import org.grails.web.json.JSONObject
import pl.fork.place.Place

@Transactional
class ImageService {

    def springSecurityService
    ImageScaleService imageScaleService

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
        create(parameters, null);
    }

    ForkFile create(GrailsParameterMap parameters, Place place) {
        def f = parameters.get('file')
        ForkFile file = new ForkFile();
        User user = User.findByUsername(springSecurityService.currentUser)
        file.source = f.bytes
        file.fileType = f.contentType
        file.title = parameters.get('title');
        file.description = parameters.get('description');
        file.owner = user;
        file.mini = imageScaleService.scale(file.source, 200)

        //jeżeli rola użytkownika różna od zwykłego użytkownika to zdjęcie od razu akceptowane
        if (!SpringSecurityUtils.ifAnyGranted(RoleType.ROLE_USER.name())) {
            file.status=FileStatus.APPROVED;
        }
        if (place) {
            file.place = place;
        }
        file.validate()
        if( file && !file.hasErrors() ) {
            user.addToImages(file)
            file.save flush: true
            user.save flush: true
        }
        else{
            file.errors.each{
                println it
            }
        }
        file
    }

    ForkFile update(ForkFile image, JSONObject parameters){
        image[parameters.get('fieldName')] = parameters.get('value')
        image.save flush: true
    }




}
