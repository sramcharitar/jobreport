package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class SiteReportStatus {
    Date dateCreated
    Date lastUpdated
    String status
    String messageCode
    SiteReportStatusEnum statusEnum

    static constraints = {
        status nullable: false, blank: false
        messageCode nullable: false, blank: false
        statusEnum nullable: false, blank: false
    }

    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, status, LocaleContextHolder.getLocale())
        }else{
            println "MessageSource for SiteReportStatus is null - need to fix this."
            return status
        }
    }

    String getStatusEnumKey(){ name() }
}
