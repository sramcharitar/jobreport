package jobreport

import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.core.userdetails.UserDetails

@Transactional
class JobReportService {

    /** Dependency injection for the jobReportService. */
    SpringSecurityService springSecurityService

    def save(JobReport jobReport) {
        jobReport?.clearErrors()
        jobReport?.client?.validate()

        if(jobReport.productInfo?.size() > 0)
            jobReport?.productInfo?.each{it.validate()}

        if(jobReport.rider)
            jobReport?.rider?.validate()

        jobReport?.validate()

        if(!jobReport.hasErrors()){
            jobReport.save(flush:true)
        }

        jobReport
    }

    def update(JobReport jobReport) {
        jobReport?.clearErrors()

        jobReport?.client?.validate()

        if (jobReport.productInfo.size() > 0)
            jobReport?.productInfo?.each { it?.validate() }


        if (jobReport.fieldTeam?.size() > 0)
            jobReport.fieldTeam.each { it?.validate() }

        if (jobReport.rider)
            jobReport?.rider?.validate()

        jobReport?.validate()

        if (!jobReport.hasErrors()) {
            jobReport.save(flush: true)
        }
        else{
            println "In Service Update"
            jobReport.errors.each{
                println it
            }
        }

        jobReport
    }

    def delete(JobReport jobReport){
        jobReport.isVisible = false
        jobReport.save(flush:true)
    }

    def installerAccess(JobReport jobReport){
        if(jobReport.isReadyForInstaller){
            jobReport.isReadyForInstaller = false
        }
        else{
            jobReport.isReadyForInstaller = true
        }

        jobReport.save(flush:true)
    }

    def jobStatus(JobReport jobReport, Map params){
        jobReport.isCompleted = params.isCompleted?.toBoolean()
        jobReport.save(flush:true)
    }

    def saveUpload(JobReport jobReport) {
        jobReport?.save(flush:true)
    }

    def updateView(ChbUsers chbUser){
        chbUser.save(flush:true)
    }

    def logUser(ChbUsers chbUser, String type){
        new UserLog([chbUser: chbUser, type: type]).save(flush:true)
    }
}
