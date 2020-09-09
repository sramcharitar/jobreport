package jobreport

class SiteReport {
    SiteReport(){
        this.isJobComplete = false
        this.isWorkInspected = false
        this.isWorkSatisfactory = false
        this.isPayrollComplete = false
        this.isApprovedForPayroll = false
    }

    Date dateCreated
    Date lastUpdated
    Date workCompletionDate
    boolean isJobComplete = false
    String outstandingWork
    boolean isWorkInspected = false
    boolean isWorkSatisfactory = false
    boolean isPayrollComplete = false
    boolean isApprovedForPayroll = false
    SiteReportStatusEnum statusEnum = SiteReportStatusEnum.WORK_IN_PROGRESS
    String notes
    String generalNotes
    String clientSignOffName
    List<WorkDetailsCompleted> workDetailsCompleted
    List<InventoryDetails> inventoryDetails
    List<TimeSheet> timeSheet
    List<Expenses> expenses
    List<Documents> siteImages
    byte[] clientSignature
    String clientSignatureString
    ChbUsers owner

    static belongsTo = [jobReport:JobReport]
    static hasMany = [workDetailsCompleted:WorkDetailsCompleted, inventoryDetails:InventoryDetails, timeSheet:TimeSheet, expenses:Expenses, siteImages:Documents, specialHours:SpecialHours, priorPeriodAdjustments:PriorPeriodAdjustments]
    static mapping = {
        notes type: "text"
        generalNotes type: "text"
        outstandingWork type: "text"
        workDetailsCompleted cascade: 'all-delete-orphan', index: 'sitereport_workdetailscompleted_idx'
        inventoryDetails cascade: 'all-delete-orphan', index: 'sitereport_inventorydetails_idx'
        timeSheet cascade: 'all-delete-orphan', index: 'sitereport_timesheet_idx'
        expenses cascade: 'all-delete-orphan', index: 'sitereport_expenses_idx'
        siteImages cascade: 'all-delete-orphan', index: 'sitereport_siteimages_idx'
        clientSignatureString type: "text"
        specialHours cascade: 'all-delete-orphan', index: 'sitereport_specialhours_idx'
        priorPeriodAdjustments cascade: 'all-delete-orphan', index: 'sitereport_priorperiod_idx'
    }
    static constraints = {
        workCompletionDate blank: false, nullable: false
        notes blank: true, nullable: true
        generalNotes blank: true, nullable: true
        outstandingWork blank: true, nullable: true
        clientSignOffName blank: true, nullable: true
        clientSignature blank: true, nullable: true
        clientSignatureString blank: true, nullable: true
    }
}
