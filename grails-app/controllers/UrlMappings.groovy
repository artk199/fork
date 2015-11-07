class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/place/search"(controller:"place", action:"search")
        "/place/search/all"(controller:"place", action:"searchAll")
        "/place/$id/score"{
            controller = "place"
            action = [GET:'getScores', POST:'addScore']
        }
        "/user/$userID/image/$imageID"{
            controller = "user"
            action = [GET:'getImage']
        }
        "/user/$userID/image"{
            controller = "user"
            action = [GET:'getAllImages']
        }
        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
