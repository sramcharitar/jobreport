package jobreport

import grails.util.Holders
import org.springframework.context.MessageSource

class MessageSourceHolder {

    static MessageSource messageSource

    static MessageSource getMessageSource() {
        if (messageSource == null) {
            messageSource = (MessageSource) Holders.grailsApplication.mainContext.getBean('messageSource')
        }
        return messageSource
    }
}
