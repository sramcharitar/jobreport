package jobreport

import grails.util.Holders
import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.AuthenticationSuccessEvent
import org.springframework.security.core.userdetails.UserDetails

class JobReportSecurityEventListener implements ApplicationListener<AuthenticationSuccessEvent> {
    JobReportService jobReportService = Holders.grailsApplication.mainContext.getBean('jobReportService')

    void onApplicationEvent(AuthenticationSuccessEvent event) {
        ChbUsers.withTransaction {
            UserDetails userDetails = (UserDetails) event.authentication.principal
            ChbUsers chbUser = ChbUsers.findByUsername(userDetails.username)
            jobReportService.logUser(chbUser, 'Login')
        }
    }
}
