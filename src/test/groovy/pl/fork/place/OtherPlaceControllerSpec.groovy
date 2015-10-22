package pl.fork.place

import grails.test.mixin.TestFor
import pl.fork.place.other.OtherPlaceController
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(OtherPlaceController)
class OtherPlaceControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect: "fix me"
        true == false
    }
}
