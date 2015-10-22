package pl.fork.place

import grails.test.mixin.TestFor
import pl.fork.place.other.OtherPlace
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(OtherPlace)
class OtherPlaceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect: "fix me"
        true == false
    }
}
