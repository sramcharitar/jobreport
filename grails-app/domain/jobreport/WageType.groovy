package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class WageType {
    Date dateCreated
    Date lastUpdated
    String type
    WageTypeEnum typeEnum
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
            println "MessageSource for WageType is null - need to fix this."
            return type
        }
    }

    String getTypeEnumKey(){ name() }
}
