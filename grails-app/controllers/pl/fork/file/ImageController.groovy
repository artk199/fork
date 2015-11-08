package pl.fork.file

import grails.converters.JSON

class ImageController {

    ImageService imageService;

    def getImage(int id){
        ForkFile image = imageService.getImage(id)
        render(file: image.source, contentType:  image.fileType)
    }

    def uploadImage(){
        ForkFile image = imageService.create(params)
        render image.id
    }

}
