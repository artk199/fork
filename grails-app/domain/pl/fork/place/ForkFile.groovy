package pl.fork.place

import pl.fork.auth.User

class ForkFile {

    static constraints = {
        source(nullable:true, maxSize: 2147483600 /* 2M */)
        fileType(nullable:true)
        description(nullable:true)
        owner(nullable:false)
    }

    static belongsTo = [place:Place]

    static mappings = {
        source type: "blob"
    }

    byte[] source
    String fileType
    String title
    String description
    User owner
}
