package pl.fork.file

import grails.converters.JSON
import org.grails.web.json.JSONObject
import pl.fork.activity.Activity
import pl.fork.auth.UserService

class ImageController {

    ImageService imageService;
    UserService userService

    def getImage(int id){
        ForkFile image = imageService.getImage(id)
        render(file: image.source, contentType:  image.fileType)
    }

    def getMiniImage(int id){
        ForkFile image = imageService.getImage(id)
        render(file: image.mini, contentType:  image.fileType)
    }

    def getImageDetails(int id){
        ForkFile image = imageService.getImage(id)
        render image as JSON
    }

    def uploadImage(){
        ForkFile image = imageService.create(params)
        render image.id
    }

    def deleteImage(int id){
        String accepts = request.getHeader('accept')
        ForkFile image = imageService.getImage(id)
        if( !userService.isValid(image.owner) ){
            render status: 403
        }
        else {
            def owner = image.owner
            if (owner.profilePicture == image) {
                owner.profilePicture = null
            }
            Activity.findByImage(image).delete flush:true
            imageService.delete(id)
            owner.save flush:true
            if (accepts.contains('html')) {
                render '/user/show/' + owner.id
            } else {
                render status: 204
            }
        }
    }

    def editImage(int id){
        ForkFile image = imageService.getImage(id)
        if( userService.isValid(image.owner) ) {
            render view: "edit", model: [image: image]
        }
        else{
            response.status = 403
            render view :"/errors/error403"
        }
    }


    def updateImage(int id){
        ForkFile image = imageService.getImage(id)
        JSONObject parameters = new JSONObject(request.reader.text)
        imageService.update(image, parameters)
        render "OK"
    }

}
