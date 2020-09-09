package jobreport

import grails.gorm.services.Service

@Service(Documents)
interface DocumentsService {

    Documents get(Serializable id)

    List<Documents> list(Map args)

    Long count()

    void delete(Serializable id)

    Documents save(Documents documents)

}