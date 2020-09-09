package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class PaymentMethod {
    Date dateCreated
    Date lastUpdated
    String paymentType
    String messageCode
    PaymentMethodEnum paymentMethodEnum

    static constraints = {
        paymentType nullable: false, blank: false
        messageCode nullable: false, blank: false
        paymentMethodEnum nullable: false, blank: false
    }

    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, paymentType, LocaleContextHolder.getLocale())
        }else{
            println "MessageSource for Payment Method is null - need to fix this."
            return paymentType
        }
    }

    String getPaymentMethodEnumKey(){ name() }
}
