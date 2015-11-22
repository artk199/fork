package pl.fork.admin

import grails.transaction.Transactional
import pl.fork.file.FileStatus
import pl.fork.file.ForkFile
import pl.fork.file.ImageService

@Transactional
class AdminService {
    ImageService imageService;

    def rejectImage(id){
        ForkFile image = imageService.getImage(id);
        image.status = FileStatus.REJECTED;
        image.save();
    }

    def acceptImage(id){
        ForkFile image = imageService.getImage(id);
        image.status = FileStatus.APPROVED;
        image.save();
    }

    List<ForkFile> getImagesWaitingForDecision(){
        List<ForkFile> images = ForkFile.createCriteria().list {
            eq("status", FileStatus.PENDING);
        }
        return images;
    }

}
