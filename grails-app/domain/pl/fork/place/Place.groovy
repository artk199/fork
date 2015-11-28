package pl.fork.place

import pl.fork.auth.Status
import pl.fork.auth.User
import pl.fork.event.Event
import pl.fork.file.ForkFile
import pl.fork.place.other.Pricing

class Place {

    static mapping = {
        images lazy:false
        pricing lazy:false
        description type: 'text'
    }

    static constraints = {
        address nullable:true
        town nullable:true
        email nullable:true
        phone nullable:true
        website nullable:true
        owner nullable:true
        types minSize: 0
        mainImage nullable:true
        pricing nullable:true
    }

    List scores
    ForkFile mainImage

    /*TODO: Uncomment services and sucessfully compile project */
    static hasMany = [scores: Score, types:PlaceType, /*services:AdditionalService,*/ events: Event, images: ForkFile,  pricing: Pricing]
    static transients = ['avgScore']


    String name
    String description
    String address
    String town
    String email
    String phone
    String website
    User owner
    Status status = Status.APPROVED;

    //date is automatically filled with current timestamp
    Date dateCreated;

    boolean verified

    double x
    double y

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
