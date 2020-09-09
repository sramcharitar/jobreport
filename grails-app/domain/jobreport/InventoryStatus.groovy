package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class InventoryStatus {
    Date dateCreated
    Date lastUpdated
    String status
    String messageCode
    InventoryStatusEnum statusEnum

    static constraints = {
        status nullable: false, blank: false
        messageCode nullable: false, blank: false
        statusEnum nullable: true, blank: false
    }

    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, status, LocaleContextHolder.getLocale())
        }else{
            println "MessageSource for InventoryStatus is null - need to fix this."
            return status
        }
    }

    String getStatusEnumKey() { statusEnum.name() }
}
