package pl.fork.place

import pl.fork.auth.User
import pl.fork.event.Event

class Place {

    static constraints = {
        address nullable:true
        town nullable:true
        email nullable:true
        phone nullable:true
        website nullable:true
        owner nullable:true
        types minSize: 1
    }


    /*TODO: Uncomment services and sucessfully compile project */
    static hasMany = [scores: Score, types:PlaceType, /*services:AdditionalService,*/ events: Event]
    static transients = ['avgScore']

    String name
    String description
    String address
    String town
    String email
    String phone
    String website
    User owner

    //date is automatically filled with current timestamp
    Date dateCreated;

    boolean verified

    int x
    int y

    double getAvgScore(){
        double scoresAmount, scoresTotal

        if( this.scores.isEmpty() ){
            return -1;
        }
        scoresAmount = this.scores.size()
        scoresTotal = 0
        scores.each { Score score ->
            scoresTotal += score.score
        }

        return scoresTotal / scoresAmount
    }

    //Point coordinates
}
