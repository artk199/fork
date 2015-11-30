package pl.fork.place

import pl.fork.auth.User
import pl.fork.place.other.Report

class Score {

    static constraints = {
        title matches: "[a-zA-Z].+"
        review matches: "[a-zA-Z].+"
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


    def springSecurityService
    // Returns true if currently logged user is owner of this score
    def isCurrentUserOwner(){
        String u = springSecurityService.currentUser
        if( u ) {
            User user = User.findByUsername(springSecurityService.currentUser);
            return (user.id == owner.id);
        }
        false
    }

    // Returns true if currently logged user has already reported this score
    def isAlreadyReportedByCurrentUser(){
        String u = springSecurityService.currentUser
        if( u ) {
            User user = User.findByUsername(u);
            for (Report r : user.reports) {
                if (r.score.id == this.id) {
                    return true;
                }
            }
        }
        false;
    }

}
