package jobreport

import grails.util.Holders
import org.springframework.context.i18n.LocaleContextHolder

class RateType {
    Date dateCreated
    Date lastUpdated
    String type
    WageTypeEnum wageTypeEnum
    RateTypeEnum rateTypeEnum
    String messageCode

    static constraints = {
        type nullable: true, blank: true
        wageTypeEnum nullable: true, blank: true
        rateTypeEnum nullable: true, blank: true
        messageCode nullable: true, blank: false
    }

    def getWageType(){
        return WageType.findByTypeEnum(wageTypeEnum)
    }

    @Override
    String toString(){
        def messageSource = Holders.grailsApplication.mainContext.getBean('messageSource')
        if(messageSource){
            return messageSource.getMessage(messageCode, null, type, LocaleContextHolder.getLocale())
        }else{
            println "MessageSource for RateType is null - need to fix this."
            return type
        }
    }

    String getRateTypeEnumKey() { rateTypeEnum.name() }

    String getWageTypeEnumKey() { wageTypeEnum.name() }
}
