package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class ExpenseItems {
    Date dateCreated
    Date lastUpdated
    String item
    String messageCode
    ExpenseItemsEnum itemEnum

    static mapping = {

    }

    static constraints = {
        item nullable: false, blank: false
        messageCode nullable: false, blank: false
        itemEnum nullable: false, blank: false
    }

    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, item, LocaleContextHolder.getLocale())
        }else{
            println "MessageSource for Expense Items is null - need to fix this."
            return item
        }
    }

    String getItemEnumKey(){ name() }
}
