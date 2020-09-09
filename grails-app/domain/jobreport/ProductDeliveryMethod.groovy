package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class ProductDeliveryMethod {
    Date dateCreated
    Date lastUpdated
    String method
    String messageCode

    static constraints = {
        method blank: false
        messageCode blank: false
    }

    @Override
    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, method, LocaleContextHolder.locale)
        }else {
            println "MessageSource for ProductDeliveryMethod is null - need to fix this."
            return method
        }
    }
}
