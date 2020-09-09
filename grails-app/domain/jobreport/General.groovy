package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class General {
    Date dateCreated
    Date lastUpdated
    GeneralEnum nameEnum
    String messageCode
    String value
    boolean active

    static constraints = {
    }

    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, value, LocaleContextHolder.getLocale())
        }else{
            println "MessageSource for InventoryStatus is null - need to fix this."
            return value
        }
    }

    String getNameEnumKey(){ name() }
}
