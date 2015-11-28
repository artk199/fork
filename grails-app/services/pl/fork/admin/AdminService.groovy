package pl.fork.admin

import grails.transaction.Transactional
import pl.fork.activity.Activity
import pl.fork.auth.Status
import pl.fork.file.ForkFile
import pl.fork.file.ImageService
import pl.fork.place.Place
import pl.fork.place.PlaceService
import pl.fork.place.Score
import pl.fork.place.other.Report

import static org.springframework.http.HttpStatus.NO_CONTENT

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

    def removeReports(scoreId){
        Score score = placeService.getScore(scoreId);
        for(Report r : score.reports){
            r.owner.reports.remove(r);
            r.owner.save(flush:true)
            score.reports.remove(r);
            r.delete(flush:true);
        }
        score.save(flush:true);
    }

    def removeScore(Score score){
        if (score == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        score.place.scores.remove(score);

        /* Quick fix, don't kill me for that*/
        def activities = Activity.findAllByScore(score);
        activities?.each{ Activity a ->
            a.delete(flush:true);
        }
        score.delete flush:true
    }
}
