package jobreport

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DocumentsServiceSpec extends Specification {

    DocumentsService documentsService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Documents(...).save(flush: true, failOnError: true)
        //new Documents(...).save(flush: true, failOnError: true)
        //Documents documents = new Documents(...).save(flush: true, failOnError: true)
        //new Documents(...).save(flush: true, failOnError: true)
        //new Documents(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //documents.id
    }

    void "test get"() {
        setupData()

        expect:
        documentsService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Documents> documentsList = documentsService.list(max: 2, offset: 2)

        then:
        documentsList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        documentsService.count() == 5
    }

    void "test delete"() {
        Long documentsId = setupData()

        expect:
        documentsService.count() == 5

        when:
        documentsService.delete(documentsId)
        sessionFactory.currentSession.flush()

        then:
        documentsService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Documents documents = new Documents()
        documentsService.save(documents)

        then:
        documents.id != null
    }
}
