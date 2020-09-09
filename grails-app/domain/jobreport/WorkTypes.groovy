package jobreport

import org.springframework.context.i18n.LocaleContextHolder
import grails.util.Holders

class WorkTypes {
    Date dateCreated
    Date lastUpdated
    String type
    String messageCode

    static constraints = {
        type blank: false
        messageCode blank: false
    }

    @Override
    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, type, LocaleContextHolder.getLocale())
        }else{
            println "MessageSource for WorkTypes is null - need to fix this."
            return type
        }
    }
}
