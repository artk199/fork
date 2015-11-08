package pl.fork.file

import grails.converters.JSON
import org.grails.web.json.JSONObject

class ImageController {

    ImageService imageService;

    def getImage(int id){
        ForkFile image = imageService.getImage(id)
        render(file: image.source, contentType:  image.fileType)
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
        imageService.delete(id)
        render status:204
    }

    def editImage(int id){
        ForkFile image = imageService.getImage(id)
        render view: "edit", model:[image:image]
    }


    def updateImage(int id){
        ForkFile image = imageService.getImage(id)
        JSONObject parameters = new JSONObject(request.reader.text)
        imageService.update(image, parameters)
        render "OK"
    }

}