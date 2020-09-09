package jobreport

import grails.converters.JSON
import grails.gsp.PageRenderer
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional

@Secured('IS_AUTHENTICATED_FULLY')
@Transactional(readOnly = false)
class SiteReportController {
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def nav
    def userAgentIdentService
    def springSecurityService
    PageRenderer groovyPageRenderer

    SiteReportController(){
        this.nav = "summary"
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 20)
        params.order = params.order ?: 'asc'
        params.img = params.img ?: 'down'

        def siteReportList
        ChbUsers me = getAuthenticatedUser()
        siteReportList = JobReport.createCriteria().list(params) {
            and {
                eq("isCompleted", false)
                eq("isVisible",true )
                eq("isReadyForInstaller",true)
            }
            fieldTeam{
                eq("worker", me)
            }
        }

        if (userAgentIdentService.isMobile()) {
            render view:"mobile_index", model: [siteReportList: siteReportList, siteReportCount: JobReport.count(), params: params]
        }
        else {
            respond siteReportList, model: [siteReportList: siteReportList, siteReportCount: JobReport.count(), params: params, nav: getNav()]
        }
    }

    def show(JobReport jobReport) {
        params.max = Math.min(params.max ?: 10, 20)
        params.order = params.order ?: 'asc'
        params.img = params.img ?: 'down'
        params.sort = params.sort ?: 'workCompletionDate'

        if (userAgentIdentService.isMobile()) {
            render view:"mobile/show", model: [jobReport: jobReport, params: params]
        }
        else {
            respond jobReport, [params:params]
        }
    }

    def create(JobReport jobReport) {
        params.editMode = false

        if (userAgentIdentService.isMobile()) {
            render view:"mobile/create", model: [siteReport:new SiteReport([jobReport:jobReport]), jobReport:jobReport, tab:0, params:params]
        }
        else {
            respond new SiteReport([jobReport:jobReport]), model: [jobReport:jobReport, tab:0, params:params]
        }
    }

    @Transactional
    def save(SiteReport siteReport) {
        if (siteReport == null) {
            println "SiteReport is null!"
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        //siteReport.workCompletionDate = new SimpleDateFormat("MM/dd/yyyy").parse(params.workCompletionDate)
        //println params
        //params.each{println it}
        removeNullable(siteReport)
        siteReport.clearErrors()
        siteReport?.workDetailsCompleted?.collect()?.each{it?.validate()}
        siteReport?.inventoryDetails?.collect()?.each{it?.validate()}
        siteReport?.timeSheet?.collect()?.each{it?.validate()}
        siteReport?.expenses?.collect()?.each{it?.validate()}

        if (siteReport.hasErrors()) {
            siteReport.errors.each{println it}
            transactionStatus.setRollbackOnly()
            respond siteReport, view:'create', model: [siteReport:siteReport, jobReport:JobReport.get(params.jobReport.id), tab:0, params:params]
            return
        }

        try {
            //println "Saving sitereport!"
            siteReport.save flush: true
        }
        catch(Exception e){
            println "Error saving! ${siteReport.errors.allErrors}"
            println e
        }

        request.withFormat {
            form multipartForm {
                redirect action: 'show', id:siteReport?.jobReport?.id, params:[tab:2]
            }
            '*' { respond siteReport, [status: CREATED, tab:2] }
        }
    }

    def edit(SiteReport siteReport) {
        params.editMode = true
        if (userAgentIdentService.isMobile()) {
            render view:"mobile/edit", model: [siteReport: siteReport, jobReport: siteReport.jobReport, tab:params.tab?:0, params: params]
        }
        else {
            respond siteReport, model: [jobReport:siteReport.jobReport, tab:params.tab?:0, params:params]
        }
    }

    @Transactional
    def update(SiteReport siteReport) {
        if (siteReport == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        removeNullable(siteReport)
        siteReport?.clearErrors()
        siteReport?.workDetailsCompleted?.collect().each{it?.validate()}
        siteReport?.inventoryDetails?.collect().each{it?.validate()}
        siteReport?.timeSheet?.collect().each{it?.validate()}
        siteReport?.expenses?.collect().each{it?.validate()}

        if (siteReport.hasErrors()) {
            println siteReport.errors.allErrors
            params.editMode = true
            transactionStatus.setRollbackOnly()
            respond siteReport, view:'edit', model: [siteReport:siteReport, jobReport:JobReport.get(params.jobReport.id), tab:params.tab?:0, params:params]
            return
        }

        try {
            //println "Saving sitereport!"
            siteReport.save flush: true
        }
        catch(Exception e){
            println "Error Saving! ${siteReport.errors.allErrors}"
            println e
        }

        request.withFormat {
            form multipartForm {
                redirect action:"show", id:siteReport?.jobReport?.id, params:[tab:2]
            }
            '*'{ respond siteReport, [status: OK, tab:2] }
        }
    }

    @Transactional
    def delete(SiteReport siteReport) {
        ChbUsers me = getAuthenticatedUser()
        def canDelete = false

        if(siteReport?.owner.is(me)){
            // its me
            if(!canDelete){
                canDelete = true
            }
        }
        if(ChbUsersRole.exists(siteReport?.owner?.id, Role.findByAuthority("ROLE_ADMIN"))){
            // I am admin
            if(!canDelete){
                canDelete = true
            }
        }
        if(ChbUsersRole.exists(siteReport?.owner?.id, Role.findByAuthority("ROLE_PROJECT_MANAGER"))){
            // I am project manager
            if(!canDelete){
                canDelete = true
            }
        }

        if (siteReport == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if(canDelete){
            def jobReport = siteReport?.jobReport
            jobReport.removeFromSiteReport(siteReport)
            siteReport.delete flush:true
        }

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.deleted.message', args: [message(code: 'siteReport.label', default: 'SiteReport'), siteReport.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.not.found.message', args: [message(code: 'siteReport.label', default: 'SiteReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    private def getNav(){
        return this.nav
    }

    def addRow(){
        //println "Adding new row..."
        JobReport jobReport = JobReport.get(params.id)
        def item
        if(params.type == "expenses"){
            item = new Expenses()
        }
        if(params.type == "timesheet"){
            item = new TimeSheet()
        }
        render (template: params.tmpl, model:[i:params.count, item:item, jobReport:jobReport])
    }

    def addWorkDetailRow(){
        //params.each{println it}
        if (userAgentIdentService.isMobile()) {
            render (template: 'mobile/workDetailsCompleted', model:[i:params.count, jobReport:JobReport.get(params.id), detail:WorkDetails.get(params.wId)])
        }
        else {
            render (template: 'workDetailsCompleted', model:[i:params.count, jobReport:JobReport.get(params.id), detail:WorkDetails.get(params.wId)])
        }
    }

    def addWorkDetail(WorkDetails workDetails){
        def completedDetailsList = WorkDetailsCompleted.findAllByWorkDetails(workDetails)
        render template: 'detail', model: [detail:workDetails, detailList:completedDetailsList]
    }

    @Transactional
    def updateWorkDetails(SiteReport siteReport) {
        def result = [status: "success", error:"", content: ""]
        removeNullable(siteReport)
        siteReport?.clearErrors()
        siteReport?.workDetailsCompleted?.collect().each{it?.validate()}

        if (siteReport.hasErrors()) {
            siteReport.errors.allErrors.each{ error -> log.debug(error.toString()) }
            transactionStatus.setRollbackOnly()
            result.status = "failed"
            result.error = siteReport.errors.allErrors
        }
        else{
            try {
                siteReport.save flush: true
                result.content = groovyPageRenderer.render(template: '/siteReport/workDetails', model: [jobReport: siteReport.jobReport])
            }
            catch(Exception e){
                log.debug(e.toString())
            }
        }
        render result as JSON
    }

    private def removeNullable(SiteReport siteReport){
        // remove non-relevant items
        //List<WorkDetailsCompleted> workDetails = new ArrayList<WorkDetailsCompleted>()
        siteReport?.workDetailsCompleted?.collect()?.each{
            if (it.toBeRemoved) {
                siteReport.removeFromWorkDetailsCompleted(it)
                it.delete()
            }
        }
        //workDetails.each{
        //    siteReport?.removeFromWorkDetailsCompleted(it)
        //}

        //List<TimeSheet> timeSheets = new ArrayList<TimeSheet>()
        siteReport?.timeSheet?.collect()?.each{
            //println it.toBeRemoved
            if (it.toBeRemoved) {
                siteReport?.removeFromTimeSheet(it)
                it.delete()
            }
        }
        //timeSheets.each{
        //    siteReport?.removeFromTimeSheet(it)
        //}

        //List<Expenses> expenses = new ArrayList<Expenses>()
        //println "removing expense items marked for removal"
        //println "Expense size: " + siteReport?.expenses?.size()
        siteReport?.expenses?.collect()?.each{
            if (it.toBeRemoved) {
                //println "expense marked for removal"
                siteReport?.removeFromExpenses(it)
                it.delete()
            }
        }
        //expenses.each{
        //    siteReport?.removeFromExpenses(it)
            //println "expense removed"
        //}

        siteReport?.inventoryDetails?.collect()?.each {
            //println siteReport?.inventoryDetails?.size()
            if ( it && (it?.rollNumber == '' || it?.usedProduct == '' || it?.remainingProduct == '' || it?.inventoryStatusEnum == null) ) {
                println "removing empty inventory detail ${it?.rollNumber} ${it?.usedProduct} ${it?.remainingProduct} ${it?.inventoryStatusEnum}"
                siteReport?.removeFromInventoryDetails(it)
                it.delete()
            }
            //println siteReport?.inventoryDetails?.size()
        }
    }

    def upload(SiteReport siteReport) {
        params.attachments.each{
            def d = new Documents([name:it.originalFilename, contentType:it.contentType, doc:it])
            siteReport.addToSiteImages(d)
        }

        try{
            siteReport?.save()
        }
        catch (Exception e){
            println "Error Saving! ${siteReport.errors.allErrors}"
            println e
        }

        request.withFormat {
            form multipartForm {
                redirect action:'edit', id:siteReport.id, params:[tab:5]
            }
            '*' { respond siteReport, [status: CREATED] }
        }
    }

    def downloadImages(Documents document){
        if (document == null || document.doc == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        render file: document.doc, contentType: document.contentType, fileName: document.filename()
    }

    def deleteDocument(Documents doc){
        def siteReport = doc.siteReport
        siteReport.removeFromSiteImages(doc)
        doc.delete()
        redirect action:'edit', id:siteReport.id, params:[tab:5]
    }

    def downloadDoc(Documents document){
        if (document == null || document.doc == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        render file: document.doc, contentType: document.contentType, fileName: document.filename()
    }

    def updateWorkDetailRate(WorkDetailsCompleted workDetailsCompleted){
        params.each{ key, val ->
            log.debug("$key : $val")
        }
        def result = [status:"success", rate:0, statusIndicator:"<img src='/assets/icons/confirmed.gif' class='icon' alt='success' style='width:16px;height:16px'>"]
        if (workDetailsCompleted && !workDetailsCompleted.hasErrors()){
            workDetailsCompleted.save(flush: true)
            result.rate = formatNumber(number: workDetailsCompleted[params.psfRate ? 'psfRate' : 'plfRate'], maxFractionDigits: 2, minFractionDigits: 2)
        }
        else{
            workDetailsCompleted.errors.allErrors.each{ error ->
                log.debug(error.toString())
            }
            result.status = "failed"
            result.statusIndicator = "<img src='/assets/icons/error.gif' class='icon' alt='failed' style='width:16px;height:16px'>"
        }
        render result as JSON
    }

}
