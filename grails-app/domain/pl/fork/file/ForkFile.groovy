package pl.fork.file

import pl.fork.auth.User
import pl.fork.place.Place

class ForkFile {

    static constraints = {
        source(nullable:true, size:0..5242880 /* 5M */)
        mini(nullable:true, size:0..5242880 /* 5M */)
        fileType(nullable:true)
        description(nullable:true)
        place(nullable:true)
        title(nullable: true)
    }

    static belongsTo = [place:Place]
    static transients = ['isProfile']

    byte[] source
    byte[] mini
    String fileType
    String title
    String description
    User owner
    FileStatus status = FileStatus.PENDING;

    boolean isProfile(){
        if( owner.profilePicture.id == this.id ){
            return true
        }
        return false
    }

}
