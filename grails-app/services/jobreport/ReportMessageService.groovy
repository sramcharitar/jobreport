package jobreport

import grails.gorm.transactions.Transactional
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder as LCH

@Transactional
class ReportMessageService {

    MessageSource messageSource

    def message(String key, List objs) {
        messageSource.getMessage(key, objs, LCH.getLocale());
    }
}
