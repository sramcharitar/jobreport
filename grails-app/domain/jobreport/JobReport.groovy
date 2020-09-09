package jobreport

class JobReport {
    JobReport(){
        this.isVisible = true
        this.isCompleted = false
        this.isReadyForInstaller = false
        this.isPayrollComplete = false
    }

    Date dateCreated
    Date lastUpdated
    Client client
    String jobName
    Location jobLocation
    String jobDescription
    String workOrderNumber
    ChbUsers salesRep
    List<ProductInfo> productInfo
    List<WorkDetails> workDetails
    //List<Workers> fieldTeam
    List<SiteReport> siteReport
    List<ChbUsers> share
    ChbUsers owner
    Rider rider
    boolean isCompleted
    boolean isReadyForInstaller
    boolean isVisible // sets whether the report is marked visible to all users including owner - in place of delete
    boolean isPayrollComplete
    String rateCategory = WageTypeEnum.STANDARD_RATE.name()
    String rateClass = StandardRateTypeEnum.REGULAR.name()

    List<Documents> jobDocs

    static hasMany = [fieldTeam:Workers, siteReport:SiteReport, workDetails:WorkDetails, share:ChbUsers, jobDocs:Documents, productInfo:ProductInfo]
    static mapping = {
        fieldTeam  index: 'jobreport_fieldteam_idx'
        siteReport index: 'jobreport_sitereport_idx'
        workDetails index: 'jobreport_workdetails_idx'
        share index: 'jobreport_users_idx'
        jobDocs index: 'jobreport_jobdocs_idx'
        productInfo index: 'jobreport_productInfo_idx'
    }
    static constraints = {
        productInfo nullable: true, blank: true
        fieldTeam cascade:'all-delete-orphan'
        siteReport cascade:'all-delete-orphan'
        workDetails cascade:'all-delete-orphan'
        share cascade:'all-delete-orphan'
        jobDocs cascade: 'all-delete-orphan'
    }

    def getTeamLeader(){
        return fieldTeam.find{it?.isTeamLeader}
    }

    @Override
    String toString(){
        return jobName
    }

    def isEditable(ChbUsers me){
        def isEditable = false
        //println "Who am I: ${me}"
        //println "My role: ${me.role}"
        if(owner.id.is(me.id)){
           // println "I am the owner"
            if (!isCompleted){
                isEditable = true
            }
        }
        //println UserRoles.findByRole("Administrator")
        if(ChbUsersRole.exists(me.id, Role.findByAuthority("ROLE_ADMIN").id)){
            //println "I am the administrator"
            isEditable = true
        }
        //println UserRoles.findByRole("Project Manager")
        if(ChbUsersRole.exists(me.id, Role.findByAuthority("ROLE_PROJECT_MANAGER").id)){
            //println "I am the project manager"
            if (!isCompleted){
                isEditable = true
            }
        }
        //println "Can I edit: " + isEditable
        return isEditable
    }

    def workerForJobReport(JobReport jr, ChbUsers worker){
        Workers.findByJobReportAndWorker(jr, worker)
    }

    boolean isJobCompleted(){
        boolean completed = false
        siteReport.each{ siteReport ->
            if (siteReport.isJobComplete){
                completed = true
            }
        }
        return completed
    }
}
