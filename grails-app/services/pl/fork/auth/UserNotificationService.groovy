package pl.fork.auth

import org.springframework.messaging.simp.SimpMessagingTemplate
import reactor.spring.context.annotation.*
import reactor.bus.Event
import org.grails.web.json.JSONObject

@Consumer
class UserNotificationService {

    SimpMessagingTemplate brokerMessagingTemplate
    def springSecurityService

    @Selector("userNotification")
    void message(Event<String> event) {
        JSONObject eventData = new JSONObject(event.data)
        println eventData.notification
        brokerMessagingTemplate.convertAndSendToUser eventData.receiver, "/queue/notification", "${eventData.notification}"
    }

}
