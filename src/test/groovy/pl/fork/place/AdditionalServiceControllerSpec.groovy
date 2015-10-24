package pl.fork.place

import grails.test.mixin.*
import spock.lang.*

@TestFor(AdditionalServiceController)
@Mock(AdditionalService)
class AdditionalServiceControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.additionalServiceList
            model.additionalServiceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.additionalService!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def additionalService = new AdditionalService()
            additionalService.validate()
            controller.save(additionalService)

        then:"The create view is rendered again with the correct model"
            model.additionalService!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            additionalService = new AdditionalService(params)

            controller.save(additionalService)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/additionalService/show/1'
            controller.flash.message != null
            AdditionalService.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def additionalService = new AdditionalService(params)
            controller.show(additionalService)

        then:"A model is populated containing the domain instance"
            model.additionalService == additionalService
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def additionalService = new AdditionalService(params)
            controller.edit(additionalService)

        then:"A model is populated containing the domain instance"
            model.additionalService == additionalService
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/additionalService/index'
            flash.message != null

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def additionalService = new AdditionalService()
            additionalService.validate()
            controller.update(additionalService)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.additionalService == additionalService

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            additionalService = new AdditionalService(params).save(flush: true)
            controller.update(additionalService)

        then:"A redirect is issued to the show action"
            additionalService != null
            response.redirectedUrl == "/additionalService/show/$additionalService.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/additionalService/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def additionalService = new AdditionalService(params).save(flush: true)

        then:"It exists"
            AdditionalService.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(additionalService)

        then:"The instance is deleted"
            AdditionalService.count() == 0
            response.redirectedUrl == '/additionalService/index'
            flash.message != null
    }
}
