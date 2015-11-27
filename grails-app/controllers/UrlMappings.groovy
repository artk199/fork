class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/place/$id/link"(parseRequest:false){
            controller = "place"
            action = [POST:'linkImage']
        }

        "/place" {
            controller = "place"
            action = "index"
        }

        "/image/$id/mini"{
            controller = "image"
            action = [GET:'getMiniImage']
        }
        "/image/$id"(parseRequest:false){
            controller = "image"
            action = [GET:'getImage', DELETE:'deleteImage', POST:'updateImage']
        }

        "/image/$id/edit"{
            controller = "image"
            action = [GET:'editImage']
        }

        "/image/$id/details"{
            controller = "image"
            action = [GET:'getImageDetails']
        }


        "/user/$id/activities"{
            controller = "user"
            action = [GET:'getActivities']
        }

        "/user/$id/friends/activities"{
            controller = "user"
            action = [GET:'getFriendsActivities']
        }

        "/user/upload"{
            controller = "image"
            action = [POST:'uploadImage']
        }

        "/user/friend"{
            controller = "user"
            action = [GET:'getFriends']
        }

        "/user/friend/$id"{
            controller = "user"
            action = [POST:'addFriend',PUT:'modifyFriend']
        }

        "/place/$placeID/image"(controller:"place",action:"getAllImages")

        "/place/search"(controller:"place", action:"search")
        "/place/search/all"(controller:"place", action:"searchAll")

        "/place/$id/metascore"(controller:"place",action:"getMetascore")
        "/place/$id/score"{
            controller = "place"
            action = [GET:'getScores', POST:'addScore']
        }
        "/user/$userID/image/$imageID"{
            controller = "user"
            action = [GET:'getImage',POST:'setProfile']
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
