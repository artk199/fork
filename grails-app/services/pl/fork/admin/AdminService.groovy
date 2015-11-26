package pl.fork.admin

import grails.transaction.Transactional
import pl.fork.auth.Status
import pl.fork.file.ForkFile
import pl.fork.file.ImageService
import pl.fork.place.Place
import pl.fork.place.PlaceService

@Transactional
class AdminService {
    ImageService imageService;
    PlaceService placeService;

    def rejectImage(id){
        ForkFile image = imageService.getImage(id);
        image.status = Status.REJECTED;
        image.save();
    }

    def acceptImage(id){
        ForkFile image = imageService.getImage(id);
        image.status = Status.APPROVED;
        image.save();
    }

    def rejectPlace(id){
        Place place= placeService.get(new Long(id));
        place.status = Status.REJECTED;
        place.save();
    }

    def acceptPlace(id){
        Place place= placeService.get(new Long(id));
        place.status = Status.APPROVED;
        place.save();
    }

    List<ForkFile> getImagesWaitingForDecision(){
        List<ForkFile> images = ForkFile.createCriteria().list {
            eq("status", Status.PENDING);
        }
        return images;
    }

}
