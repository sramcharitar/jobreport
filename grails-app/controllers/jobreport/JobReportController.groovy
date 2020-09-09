package jobreport

import grails.converters.JSON
import grails.gsp.PageRenderer
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Transactional(readOnly = false)
@Secured("IS_AUTHENTICATED_FULLY")
class JobReportController {
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def nav
    def jobReportService
    def springSecurityService
    PageRenderer groovyPageRenderer

    JobReportController(){
        this.nav = "summary"
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 20)
        params.order = params.order ?: 'asc'
        params.img = params.img ?: 'down'
        params.sort = params.sort ?: 'rider.installationDate'

        ChbUsers me = getAuthenticatedUser()
        def jobReportList
        def jobsCompletedList
        if(me.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN"))) {
            // Admin - All records are available
            // Viewable for the past 180 days
            jobReportList = JobReport.findAllByDateCreatedGreaterThanEquals(new Date()-180, params)
        }
        if(me.getAuthorities().contains(Role.findByAuthority("ROLE_ACCOUNTING"))) {
            // Accounting
            // redirect to new payroll controller
            redirect url: "/payrollSchedule/index"
            return
            // jobReportList = SiteReport.findAllByIsReadyForAccountingAndIsPayrollComplete(true, false)
        }
        if(me.getAuthorities().contains(Role.findByAuthority("ROLE_ACCOUNT_MANAGER"))) {
            // Account Manager
            jobReportList = JobReport.findAllByDateCreatedGreaterThanEqualsAndIsVisibleAndOwnerAndIsCompleted(new Date()-180, true, getAuthenticatedUser(), false, params)
            params.order = 'desc'
            jobsCompletedList = JobReport.findAllByDateCreatedGreaterThanEqualsAndIsVisibleAndOwnerAndIsCompleted(new Date()-180, true, getAuthenticatedUser(),true, params)
        }
        if(me.getAuthorities().contains(Role.findByAuthority("ROLE_PROJECT_MANAGER"))) {
            // Project Manager
            params.order = 'asc'
            jobReportList = JobReport.findAllByDateCreatedGreaterThanEqualsAndIsVisibleAndIsCompleted(new Date()-180, true, false, params)
            params.order = 'desc'
            jobsCompletedList = JobReport.findAllByDateCreatedGreaterThanEqualsAndIsVisibleAndIsCompleted(new Date()-180, true, true, params)
        }
        if(me.getAuthorities().contains(Role.findByAuthority("ROLE_FIELD_AGENT"))) {
            redirect url: "/siteReport"
            return
        }
        respond jobReportList, model:[jobReportList:jobReportList, jobsCompletedList:jobsCompletedList, params:params, nav:getNav(), calView:me?.calendar]
    }

    def show(JobReport jobReport) {
        params.max = Math.min(params.max ?: 10, 20)
        params.order = params.order ?: 'asc'
        params.img = params.img ?: 'down'
        ChbUsers me = getAuthenticatedUser()
        respond jobReport, model:[nav:getNav(), isEditable:jobReport.isEditable(me), enableInstallerOption: ChbUsersRole.exists(me.id, Role.findByAuthority('ROLE_PROJECT_MANAGER').id), tab:params.tab ?:0, params:params]
    }

    def quickAccessForTeam(JobReport jobReport) {
        ChbUsers me = getAuthenticatedUser()
        def viewable =  getViewable(me)
        jobReport.refresh()
        jobReport.clearErrors()
        respond jobReport, model:[nav:getNav(), viewable:viewable, isEditable:jobReport.isEditable(me), enableInstallerOption: ChbUsersRole.exists(me.id, Role.findByAuthority('ROLE_PROJECT_MANAGER').id), params:params]
    }

    def create(){
        ChbUsers me = getAuthenticatedUser()
        def viewable =  getViewable(me)
        if(ChbUsersRole.exists(me.id, Role.findByAuthority("ROLE_ADMIN").id) || ChbUsersRole.exists(me.id, Role.findByAuthority("ROLE_ACCOUNT_MANAGER").id)){
            respond new JobReport(params), model:[nav:getNav(), viewable:viewable]
        }
        else{
            redirect action: "index"
        }
    }

    def save(JobReport jobReport) {
        println params

        if (jobReport == null) {
            notFound()
            return
        }

        ChbUsers me = getAuthenticatedUser()
        def viewable =  getViewable(me)

        jobReport.owner = me

        removeNullables(jobReport)

        jobReport = jobReportService.save(jobReport)

        if (jobReport.hasErrors()) {
            respond jobReport.errors, view:'create', model:[nav:getNav(), viewable:viewable]
            return
        }

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'jobReport.label', default: 'JobReport'), jobReport.id])
                redirect jobReport
            }
            '*' { respond jobReport, [status: CREATED] }
        }
    }

    def edit(JobReport jobReport) {
        ChbUsers me = getAuthenticatedUser()
        def viewable =  getViewable(me)

        jobReport.clearErrors()

        if(jobReport.isEditable(me)){
            respond jobReport, model:[nav:getNav(), viewable:viewable]
        }
        else{
            redirect action: "index"
        }
    }

    def update(JobReport jobReport) {
        //JobReport jobReport = JobReport.get(params.id)
        params.each{
            println it
        }
        if (jobReport == null) {
            notFound()
            return
        }

        ChbUsers me = getAuthenticatedUser()
        println me
        def viewable =  getViewable(me)

        jobReport.fieldTeam.collect().each{
            if(it) {
                jobReport.removeFromFieldTeam(it)
                it?.delete()
            }
            jobReport.fieldTeam.clear()
        }

        jobReport.properties = params

        removeNullables(jobReport)

        teamLeaderPay(jobReport)

        jobReport = jobReportService.update(jobReport)

        if (jobReport.hasErrors()) {
            jobReport.errors.each{
                println it
            }
            respond jobReport.errors, view:'edit', model:[nav:getNav(), viewable:viewable]
            return
        }

        request.withFormat {
            form multipartForm {
                redirect jobReport
            }
            '*'{ respond jobReport, [status: OK] }
        }
    }

    def saveTeamInfo(JobReport jobReport) {
        //println params
        //params.each{
        //    println it
        //}
        //JobReport jobReport = JobReport.get(params.id)
        if (jobReport == null) {
            notFound()
            return
        }

        ChbUsers me = getAuthenticatedUser()
        def viewable =  getViewable(me)

        jobReport.fieldTeam.collect().each{
            if(it) {
                //println it
                jobReport.removeFromFieldTeam(it)
                it?.delete()
            }
        }
        jobReport.fieldTeam.clear()
        jobReport.clearErrors()

        jobReport.properties = params

        removeNullables(jobReport)

        teamLeaderPay(jobReport)

        jobReport = jobReportService.update(jobReport)

        if (jobReport.hasErrors()) {
            respond jobReport.errors, view:'edit', model:[nav:getNav(), viewable:viewable]
            return
        }

        request.withFormat {
            form multipartForm {
                redirect jobReport
            }
            '*'{ respond jobReport, [status: OK] }
        }
    }

    def delete(JobReport jobReport) {
        if (jobReport == null) {
            notFound()
            return
        }

        ChbUsers me = getAuthenticatedUser()
        if(jobReport?.owner != me){
            if (!ChbUsersRole.exists(me.id, Role.findByAuthority("ROLE_ADMIN").id)){
                redirect action: 'index'
            }
        }

        jobReportService.delete(jobReport)

        request.withFormat {
            form multipartForm {
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobReport.label', default: 'JobReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    private def removeNullables(JobReport jobReport){
        removeNullableFieldTeam(jobReport)
        removeNullableWorkDetails(jobReport)
        removeNullableProductInfo(jobReport)
        removeNullableRollDetails(jobReport)
    }

    private def removeNullableFieldTeam(JobReport jobReport){
        // remove non-relevant items
        jobReport.fieldTeam.collect().each{
            //println "For deletion: $it | _deleted: ${it._deleted}"
            if (it._deleted?.toBoolean()) {
                jobReport.removeFromFieldTeam(it)
                it?.delete()
            }
        }
    }

    private def removeNullableWorkDetails(JobReport jobReport){
        // remove non-relevant items
        List<WorkDetails> details = new ArrayList<WorkDetails>()
        jobReport.workDetails.each{
            if (it.toBeRemoved)
                details.add(it)
        }
        details.each{
            jobReport?.removeFromWorkDetails(it)
            it.delete()
        }
    }

    private def removeNullableRollDetails(JobReport jobReport){
        // remove non-relevant items
        jobReport.productInfo.each {product ->
            List<Rolls> details = new ArrayList<Rolls>()
            product.rolls.each {
                if (it.toBeRemoved)
                    details.add(it)
            }
            details.each{
                product?.removeFromRolls(it)
                it.delete()
            }
        }

    }

    private def removeNullableProductInfo(JobReport jobReport){
        // remove non-relevant items
        List<ProductInfo> products = new ArrayList<ProductInfo>()
        jobReport.productInfo.each{
            if (it.toBeRemoved)
                products.add(it)
        }
        products.each{
            jobReport?.removeFromProductInfo(it)
            it.delete()
        }
    }

    private def getNav(){
        //println this.nav
        return this.nav
    }

    def getRateTypeList(JobReport jobReport){
        def wageTypeInstance = WageType.findByTypeEnum(params.wageTypeEnum)
        jobReport.wageTypeEnum = wageTypeInstance.typeEnum
        //def rateTypeList = RateType.findAllByWageTypeEnum(params.wageTypeEnum)
        //println rateTypeList
        //render template: "/common/rateTypeSelectField", model: [rateTypeList:rateTypeList, cnt:params.cnt]
        render template: "/common/fieldTeam", model: [jobReport:jobReport]
    }

    def installerAccess(JobReport jobReport){
        jobReportService.installerAccess(jobReport)
    }

    def jobStatus(JobReport jobReport){
        jobReportService.jobStatus(jobReport, params)
    }

    def siteReportStatus(){
        SiteReport siteReport = SiteReport.get(params.id)
        if (siteReport){
            siteReport.isApprovedForPayroll = params.isApprovedForPayroll.toBoolean()
            siteReport.timeSheet.each{
                it.isApprovedForPayroll = params.isApprovedForPayroll.toBoolean()
            }
            siteReport.save(flush:true)
        }
    }

    def siteReport(){
        SiteReport siteReport = SiteReport.get(params.id)
        ChbUsers me = getAuthenticatedUser()
        if(siteReport){
            JobReport jobReportInstance = siteReport.jobReport
            respond siteReport, model:[jobReport:jobReportInstance, nav:getNav(), tab:0]
        }
        else{
            redirect controller: "jobReport", action: "index"
        }
    }

    def upload(JobReport jobReport) {
        ChbUsers me = getAuthenticatedUser()
        def viewable = getViewable(me)
        params.attachments.each{
            def d = new Documents([name:it.originalFilename, contentType:it.contentType, doc:it])
            jobReport.addToJobDocs(d)
        }

        jobReport = jobReportService.saveUpload(jobReport)

        if (jobReport.hasErrors()) {
            respond jobReport.errors, view:'edit', model:[nav:getNav(), viewable:viewable]
            return
        }

        request.withFormat {
            form multipartForm {
               redirect action:'show', id:jobReport.id, params:[tab:3]
            }
            '*' { respond jobReport, [status: CREATED] }
        }
    }

    def downloadDoc(Documents document){
        if (document == null || document.doc == null) {
            notFound()
            return
        }
        render file: document.doc, contentType: document.contentType, fileName: document.filename()
    }

    def deleteDocument(Documents doc){
        def jobReport = doc.jobReport
        jobReport.removeFromJobDocs(doc)
        doc.delete()
        redirect action:'show', id:jobReport.id, params:[tab:3]
    }

    def updateView(ChbUsers chbUser){
        chbUser.calendar = params.cal.toBoolean()
        jobReportService.updateView(chbUser)
        redirect(action: 'index')
    }

    def calEvents(){
        def jobReportList

        jobReportList = JobReport.findAllByIsCompletedAndIsVisible(false, true)

        def events = new ArrayList()
        jobReportList.each{
            Map event = [id:it.id,
                         title:it.jobName,
                         allDay:true,
                         start:it.rider.installationDate,
                         end:it.rider.installationDate,
                         url:"/jobReport/show/${it.id}",
                         editable:false,
                         overlap:false]
            events.add(event)
        }
        render events as JSON
    }

    static boolean getViewable(ChbUsers me){
        me.getAuthorities().contains(Role.findByAuthority("ROLE_ADMIN")) ||
        me.getAuthorities().contains(Role.findByAuthority("ROLE_ACCOUNTING")) ||
        me.getAuthorities().contains(Role.findByAuthority("ROLE_PROJECT_MANAGER"))
    }

    static teamLeaderPay(JobReport jobReport){
        jobReport.fieldTeam?.each{
            if (it.isTeamLeader){
                it.teamLeaderPay = General.findByNameEnum(GeneralEnum.TEAM_LEADER_PAY).value?.toBigDecimal()
            }
        }
    }

    def teamStatus(JobReport jobReport){
        jobReport.refresh()
        def title = message(code: 'jobReport.fieldTeam.size', args: [jobReport.fieldTeam.size() == 0 ? 'No' : jobReport.fieldTeam.size()])
        def content = groovyPageRenderer.render(template: '/jobReport/teamStatus', model: [report: jobReport])
        def result = [title: title, content: content]
        render result as JSON
        return
    }

    def updateRateList(){
        JobReport jobReport = new JobReport(params)
        def content = groovyPageRenderer.render(template: '/common/rateClassList', model: [jobReport: jobReport])
        def result = [content : content]
        render result as JSON
    }

    def updateTimesheetHourlyRate(TimeSheet timeSheet){
        def status = message(code: "success.msg.label")
        def statusIndicator = "<img src='/assets/icons/confirmed.gif' class='icon' alt='success' style='width:16px;height:16px'>"
        if (timeSheet && !timeSheet.hasErrors()){
            timeSheet.save(flush:true)
        }
        else{
            status = message(code: "error.msg.label")
            statusIndicator = "<img src='/assets/icons/error.gif' class='icon' alt='failed' style='width:16px;height:16px'>"
        }
        def result = [status: status, val: formatNumber(number: timeSheet.hourlyRate, maxFractionDigits: 2, minFractionDigits: 2), statusIndicator:statusIndicator]
        render result as JSON
    }
}
