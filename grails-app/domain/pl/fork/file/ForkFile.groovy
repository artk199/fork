package pl.fork.file

import pl.fork.auth.User
import pl.fork.place.Place

class ForkFile {

    static constraints = {
        source(nullable:true, maxSize: 2147483600 /* 2M */)
        fileType(nullable:true)
        description(nullable:true)
        place(nullable:true)
        title(nullable: true)
    }

    static belongsTo = [place:Place]

    static mappings = {
        source type: "blob"
        title defaultValue: "'No title'"
    }

    byte[] source
    String fileType
    String title
    String description
    User owner
}
