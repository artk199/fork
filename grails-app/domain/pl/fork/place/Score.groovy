package pl.fork.place

import pl.fork.auth.User
import pl.fork.place.other.Report

class Score {

    static constraints = {
    }

    static mapping = {
        review type: 'text'
    }

    static belongsTo = [place:Place, owner: User]

    static hasMany = [reports: Report]

    String title
    String review
    String language
    int score

    Date dateCreated

    static transients = ['springSecurityService','isCurrentUserOwner','isAlreadyReportedByCurrentUser']


    // Returns true if currently logged user is owner of this score
    def isCurrentUserOwner(){
        User user = User.findByUsername(springSecurityService.currentUser);
        return (user.id == owner.id);
    }

    // Returns true if currently logged user has already reported this score
    def isAlreadyReportedByCurrentUser(){
        User user = User.findByUsername(springSecurityService.currentUser);

        for(Report r : user.reports){
            if(r.score.id == this.id){
                return true;
            }
        }
        return false;
    }

}
