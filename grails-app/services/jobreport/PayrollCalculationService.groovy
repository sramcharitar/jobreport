package jobreport

import grails.gorm.transactions.Transactional
import groovy.time.Duration
import groovy.time.TimeCategory
import groovy.time.TimeDuration
import java.text.SimpleDateFormat

@Transactional
class PayrollCalculationService {

    def jobId(JobReport jobReport) {
        return jobReport.workOrderNumber
    }

    def jobLocation(JobReport jobReport){
        return jobReport.jobLocation
    }

    def jobDescription(JobReport jobReport){
        return jobReport.jobDescription
    }

    def employeesForPayPeriod(startDate, endDate){
        def employees = TimeSheet.createCriteria(){
            projections{
                worker {
                    distinct("id")
                }
            }
            and {
                ge("startDateTime", startDate)
                le("endDateTime", endDate)
            }
        }
        return employees
    }

    def employeeTimeSheets(String start, String end){
        List timeSheets = []
        BigDecimal overTimeThreshold = General.findByNameEnumAndActive(GeneralEnum.OVER_TIME_THRESHOLD, true)?.value?.toBigDecimal()
        def teamLeaderPay = General.findByNameEnumAndActive(GeneralEnum.TEAM_LEADER_PAY, true)?.value?.toBigDecimal()
        def payrollPeriodStart = new SimpleDateFormat("M/d/yy").parse(start)
        def payrollPeriodEnd = new SimpleDateFormat("M/d/yy").parse(end)
        List<TimeSheet> timeSheetWorkerList = timeSheetWorkerList(payrollPeriodStart, payrollPeriodEnd)
        if (timeSheetWorkerList){
            timeSheetWorkerList.each{ worker ->
                List timeSheetList = timeSheetList(worker, start, end)
                List weekOneJobDates = []
                List weekTwoJobDates = []
                Map workerTimeSheet = workerTimeSheet()
                ChbUsers me = ChbUsers.get(worker)

                BigDecimal weekOneTotalPsfForUser = totalSqFt(me, payrollPeriodStart, payrollPeriodStart.plus(6))
                BigDecimal weekTwoTotalPsfForUser = totalSqFt(me, payrollPeriodStart.plus(7), payrollPeriodEnd)
                BigDecimal totalPsfForUser = weekOneTotalPsfForUser + weekTwoTotalPsfForUser

                BigDecimal weekOneTotalRegularPay = 0
                BigDecimal weekTwoTotalRegularPay = 0
                BigDecimal totalRegularPay = 0

                BigDecimal weekOneTotalOvertimePay = 0
                BigDecimal weekTwoTotalOvertimePay = 0
                BigDecimal totalOvertimePay = 0

                BigDecimal weekOneTotalPsfPay = 0
                BigDecimal weekTwoTotalPsfPay = 0
                BigDecimal totalPsfPay = weekOneTotalPsfPay + weekTwoTotalPsfPay

                BigDecimal weekOneTotalRegularHours = 0
                BigDecimal weekTwoTotalRegularHours = 0
                BigDecimal totalRegularHours = 0

                BigDecimal weekOneTotalOvertimeHours = 0
                BigDecimal weekTwoTotalOvertimeHours = 0
                BigDecimal totalOvertimeHours = 0

                BigDecimal weekOneTotalTeamLeaderPay = 0
                BigDecimal weekTwoTotalTeamLeaderPay = 0
                BigDecimal totalTeamLeaderPay = 0

                SiteReport currentSiteReport

                if (timeSheetList){
                    List detailsList = []
                    timeSheetList.each { TimeSheet timeSheet ->
                        currentSiteReport = timeSheet.siteReport
                        Map timeSheetDetails = timeSheetDetails()
                        def isTeamLeader = timeSheet.worker.isTeamLeader
                        TimeDuration hrs = TimeCategory.minus(timeSheet.endDateTime, timeSheet.startDateTime)
                        def workHoursForTimeSheet = timeSheet.regularHours()
                        def overtimeRateForTimeSheet = timeSheet.overtimeRate()
                        def regularPayForTimeSheet = timeSheet.regularPay()
                        def overtimeHoursForTimeSheet = timeSheet.overtimeHours()
                        def overTimePayForTimeSheet = calcOvertimePay(overtimeHoursForTimeSheet, overtimeRateForTimeSheet)

                        if (timeSheet.startDateTime?.clearTime() >= payrollPeriodStart && timeSheet.startDateTime?.clearTime() <= payrollPeriodStart.plus(6)){
                            //println "Date is within week one (${payrollPeriodStart} - ${payrollPeriodStart.plus(6)}) : ${timeSheet.startDateTime.clearTime()}"
                            weekOneTotalRegularPay += regularPayForTimeSheet
                            weekOneTotalOvertimePay += overTimePayForTimeSheet
                            weekOneTotalRegularHours += workHoursForTimeSheet
                            weekOneTotalOvertimeHours += overtimeHoursForTimeSheet
                            weekOneTotalTeamLeaderPay += teamLeaderPayCalc(isTeamLeader, timeSheet, weekOneJobDates, teamLeaderPay)
                            weekOneJobDates.add(timeSheet.startDateTime)
                        }
                        else{
                            //println "Date is within week two (${payrollPeriodStart.plus(7)} - ${payrollPeriodEnd}) : ${timeSheet.startDateTime.clearTime()}"
                            weekTwoTotalRegularPay += regularPayForTimeSheet
                            weekTwoTotalOvertimePay += overTimePayForTimeSheet
                            weekTwoTotalRegularHours += workHoursForTimeSheet
                            weekTwoTotalOvertimeHours += overtimeHoursForTimeSheet
                            weekTwoTotalTeamLeaderPay += teamLeaderPayCalc(isTeamLeader, timeSheet, weekTwoJobDates, teamLeaderPay)
                            weekTwoJobDates.add(timeSheet.startDateTime)
                        }

                        totalRegularPay += regularPayForTimeSheet
                        totalRegularHours = (weekOneTotalRegularHours + weekTwoTotalRegularHours)
                        totalOvertimeHours = totalRegularHours.minus(overTimeThreshold) > 0 ? totalRegularHours.minus(overTimeThreshold) : 0
                        totalOvertimePay = calcOvertimePay(totalOvertimeHours, overtimeRateForTimeSheet)
                        totalTeamLeaderPay = (weekOneTotalTeamLeaderPay + weekTwoTotalTeamLeaderPay)

                        timeSheetDetails.jobNumber = timeSheet?.siteReport?.jobReport?.workOrderNumber
                        timeSheetDetails.clientName = timeSheet?.siteReport?.jobReport?.client
                        timeSheetDetails.jobLocation = timeSheet?.siteReport?.jobReport?.jobLocation?.street
                        timeSheetDetails.startDate = timeSheet?.startDateTime
                        timeSheetDetails.timeIn = timeSheet?.startDateTime
                        timeSheetDetails.timeOut = timeSheet?.endDateTime
                        timeSheetDetails.regularHours = workHoursForTimeSheet
                        timeSheetDetails.overtimeHours = overtimeHoursForTimeSheet
                        timeSheetDetails.wageType = WageType.findByTypeEnum(timeSheet?.worker?.wageTypeEnum)
                        timeSheetDetails.basis = RateType.findByRateTypeEnum(timeSheet?.worker?.rateTypeEnum)
                        timeSheetDetails.rate = timeSheet?.worker?.payRate
                        timeSheetDetails.otRate = overTimeRateCalc()
                        timeSheetDetails.regularPay = regularPayForTimeSheet
                        timeSheetDetails.overTimePay = overTimePayForTimeSheet
                        timeSheetDetails.teamLeaderPay = isTeamLeader ? teamLeaderPay : ''
                        timeSheetDetails.id = timeSheet?.id
                        detailsList.add(timeSheetDetails)
                    }

                    BigDecimal weekOneTotalPay = weekOneTotalRegularPay + weekOneTotalOvertimePay
                    BigDecimal weekTwoTotalPay = weekTwoTotalRegularPay + weekTwoTotalOvertimePay
                    BigDecimal totalPay = weekOneTotalPay + weekTwoTotalPay

                    BigDecimal weekOneTotalPayWithTeamLeaderBonus = weekOneTotalPay + weekOneTotalTeamLeaderPay
                    BigDecimal weekTwoTotalPayWithTeamLeaderBonus = weekTwoTotalPay + weekTwoTotalTeamLeaderPay
                    BigDecimal totalPayWithTeamLeaderBonus = totalPay + totalTeamLeaderPay

                    workerTimeSheet.worker = me
                    workerTimeSheet.siteReport = currentSiteReport.id
                    workerTimeSheet.payrollDetails = detailsList
                    workerTimeSheet.payrollPeriodStart = payrollPeriodStart
                    workerTimeSheet.payrollPeriodEnd = payrollPeriodEnd

                    workerTimeSheet.weekOneTotalRegularPay = weekOneTotalRegularPay
                    workerTimeSheet.weekTwoTotalRegularPay = weekTwoTotalRegularPay
                    workerTimeSheet.totalRegularPay = totalRegularPay

                    workerTimeSheet.weekOneTotalOverTimePay = weekOneTotalOvertimePay
                    workerTimeSheet.weekTwoTotalOverTimePay = weekTwoTotalOvertimePay
                    workerTimeSheet.totalOverTimePay = totalOvertimePay

                    workerTimeSheet.weekOneTotalPay = weekOneTotalPay
                    workerTimeSheet.weekTwoTotalPay = weekTwoTotalPay
                    workerTimeSheet.totalPay = totalPay

                    workerTimeSheet.weekOneTotalTeamLeaderPay = weekOneTotalTeamLeaderPay
                    workerTimeSheet.weekTwoTotalTeamLeaderPay = weekTwoTotalTeamLeaderPay
                    workerTimeSheet.totalTeamLeaderPay = totalTeamLeaderPay

                    workerTimeSheet.weekOneTotalPayWithTeamLeaderBonus = weekOneTotalPayWithTeamLeaderBonus
                    workerTimeSheet.weekTwoTotalPayWithTeamLeaderBonus = weekTwoTotalPayWithTeamLeaderBonus
                    workerTimeSheet.totalPayWithTeamLeaderBonus = totalPayWithTeamLeaderBonus

                    workerTimeSheet.weekOneTotalPsfForUser = weekOneTotalPsfForUser
                    workerTimeSheet.weekTwoTotalPsfForUser = weekTwoTotalPsfForUser
                    workerTimeSheet.totalPsfForUser = totalPsfForUser

                    workerTimeSheet.weekOneTotalPsfPay = weekOneTotalPsfPay
                    workerTimeSheet.weekTwoTotalPsfPay = weekTwoTotalPsfPay
                    workerTimeSheet.totalPsfPay = totalPsfPay

                    workerTimeSheet.weekOneTotalRegularHours = weekOneTotalRegularHours
                    workerTimeSheet.weekTwoTotalRegularHours = weekTwoTotalRegularHours
                    workerTimeSheet.totalRegularHours = totalRegularHours

                    workerTimeSheet.weekOneTotalOverTimeHours = weekOneTotalOvertimeHours
                    workerTimeSheet.weekTwoTotalOverTimeHours = weekTwoTotalOvertimeHours
                    workerTimeSheet.totalOverTimeHours = totalOvertimeHours

                    timeSheets.add(workerTimeSheet)
                }
            }
        }
        return timeSheets
    }

    def employeeSpecialHours(String start, String end){
        List specialHours = []
        def payrollPeriodStart = new SimpleDateFormat("M/d/yy").parse(start)
        def payrollPeriodEnd = new SimpleDateFormat("M/d/yy").parse(end)
        List specialHoursWorkerList = specialHoursWorkerList(payrollPeriodStart, payrollPeriodEnd)
        if (specialHoursWorkerList){
            specialHoursWorkerList.each{ employee ->
                BigDecimal weekOneTotalSpecialHours = 0
                BigDecimal weekTwoTotalSpecialHours = 0
                BigDecimal weekOneTotalSpecialPay = 0
                BigDecimal weekTwoTotalSpecialPay = 0
                BigDecimal totalSpecialHours = 0
                BigDecimal totalSpecialPay = 0
                List specialHoursList = SpecialHours.findAllByEmployeeAndDateBetween(employee, payrollPeriodStart, payrollPeriodEnd, [sort:'date', order:'desc'])
                if (specialHoursList){
                    List specialHoursDetails = []
                    specialHoursList.each{ sh ->
                        Map details = [:]
                        details.date = sh.date
                        details.typeEnum = sh.typeEnum
                        details.hours = sh.hours
                        details.rate = sh.rate
                        details.pay = sh.pay()
                        details.id = sh.id
                        specialHoursDetails.add(details)

                        if (sh.date?.clearTime() >= payrollPeriodStart && sh.date?.clearTime() <= payrollPeriodStart.plus(6)){
                            weekOneTotalSpecialHours += sh.hours
                            weekOneTotalSpecialPay += sh.pay()
                        }
                        else{
                            weekTwoTotalSpecialHours += sh.hours
                            weekTwoTotalSpecialPay += sh.pay()
                        }
                    }
                    totalSpecialHours += (weekOneTotalSpecialHours + weekTwoTotalSpecialHours)
                    totalSpecialPay += (weekOneTotalSpecialPay + weekTwoTotalSpecialPay)
                    specialHours.add([employee:employee,
                                      details:specialHoursDetails,
                                      weekOneTotalSpecialHours:weekOneTotalSpecialHours,
                                      weekOneTotalSpecialPay:weekOneTotalSpecialPay,
                                      weekTwoTotalSpecialHours:weekTwoTotalSpecialHours,
                                      weekTwoTotalSpecialPay:weekTwoTotalSpecialPay,
                                      totalSpecialHours:totalSpecialHours,
                                      totalSpecialPay:totalSpecialPay])
                }
            }
        }
        specialHours
    }

    def employeePriorPeriodAdjustments(String start, String end){
        List priorAdjustments = []
        def payrollPeriodStart = new SimpleDateFormat("M/d/yy").parse(start)
        def payrollPeriodEnd = new SimpleDateFormat("M/d/yy").parse(end)
        List priorAdjWorkerList = priorPeriodWorkerList(payrollPeriodStart, payrollPeriodEnd)
        if (priorAdjWorkerList){
            List priorAdjDetailsList = []
            priorAdjWorkerList.each{ employee ->
                List priorAdjList = PriorPeriodAdjustments.findAllByEmployeeAndWorkDateBetween(employee, payrollPeriodStart, payrollPeriodEnd, [sort:'workDate', order:'desc'])
                if (priorAdjList){
                    priorAdjList.each { pa ->
                        Map priorAdjDetails = [:]
                        priorAdjDetails.workDate = pa.workDate
                        priorAdjDetails.jobId = pa.jobId
                        priorAdjDetails.wageTypeEnum = pa.wageTypeEnum
                        priorAdjDetails.rateTypeEnum = pa.rateTypeEnum
                        priorAdjDetails.regularHours = pa.regularHours
                        priorAdjDetails.overtimeHours = pa.overtimeHours
                        priorAdjDetails.specialHours = pa.specialHours
                        priorAdjDetails.regularRate = pa.regularRate
                        priorAdjDetails.overtimeRate = pa.overtimeRate
                        priorAdjDetails.specialRate = pa.specialRate
                        priorAdjDetails.regularPay = pa.regularPay
                        priorAdjDetails.overtimePay = pa.overtimePay
                        priorAdjDetails.specialPay = pa.specialPay
                        priorAdjDetails.teamLeaderPay = pa.teamLeaderPay
                        priorAdjDetails.location = pa.location
                        priorAdjDetailsList.add(priorAdjDetails)
                    }
                    priorAdjustments.add([employee:employee, details:priorAdjDetailsList])
                }
            }
        }
        priorAdjustments
    }

    Map timeSheetDetails(){
        [   id:'',              jobNumber:'',       clientName:'',  startDate:'',   timeIn:'',  timeOut:'',
            regularHours:'',    overtimeHours:'',   wageType:'',    basis:'',       rate:'',    otRate:'',
            regularPay:'',      overTimePay:'',     teamLeaderPay:'']
    }

    Map workerTimeSheet() {
        [siteReport                 : '', worker                     : '', payrollPeriodStart   : '', payrollPeriodEnd  : '',
         weekOneTotalRegularHours   : '', weekTwoTotalRegularHours   : '', totalRegularHours    : '',
         weekOneTotalOverTimeHours  : '', weekTwoTotalOverTimeHours  : '', totalOvertimeHours   : '',
         weekOneTotalRegularPay     : '', weekTwoTotalRegularPay     : '', totalRegularPay      : '',
         weekOneTotalOverTimePay    : '', weekTwoTotalOverTimePay    : '', totalOverTimePay     : '',
         weekOneTotalPay            : '', weekTwoTotalPay            : '', totalPay             : '',
         weekOneTotalTeamLeaderPay  : '', weekTwoTotalTeamLeaderPay  : '', totalTeamLeaderPay   : '',
         weekOneTotalPsfForUser     : '', weekTwoTotalPsfForUser     : '', totalPsfForUser      : '',
         weekOneTotalPsfPay         : '', weekTwoTotalPsfPay         : '', totalPsfPay          : '',
         totalPayWithTeamLeaderBonus: '', payrollDetails             : []]
    }

    List timeSheetPeriods(List timeSheetList, Date startDate){
        Date weekOneStartDate = startDate
        Date weekTwoStartDate = weekOneStartDate.plus(7)
        def timeSheetList1 = []
        def timeSheetList2 = []

        timeSheetList?.each{ ts ->
            def addToList1 = false
            def addToList2 = false
            ts.payrollDetails.each{ pd ->
                if (pd.startDate.clearTime() < weekTwoStartDate.clearTime()) {
                    addToList1 = true
                }
                if(pd.startDate.clearTime() >= weekTwoStartDate.clearTime()) {
                    addToList2 = true
                }
            }
            if (addToList1){ timeSheetList1.add(ts) }
            if (addToList2){ timeSheetList2.add(ts) }
        }
        [timeSheetList1, timeSheetList2]
    }

    def calcRegularPay(BigDecimal hours, BigDecimal totalWorkHours, TimeSheet timeSheet){
        def worker = timeSheet.worker
        def regularPay = BigDecimal.ZERO
        def overtimeThreshold = General.findByNameEnum(GeneralEnum.OVER_TIME_THRESHOLD).value?.toBigDecimal()
        if (worker.wageTypeEnum == WageTypeEnum.STANDARD_WAGE){
            switch (worker.rateTypeEnum){
                case RateTypeEnum.HOURLY :
                    if (totalWorkHours > overtimeThreshold){
                        regularPay = overtimeThreshold.multiply(worker.payRate)
                    }
                    else{ regularPay = hours.multiply(worker.payRate) }
                    break
                case RateTypeEnum.PREMIUM :

                    break
                case RateTypeEnum.PSF :
                        regularPay = calcPerSqFtPay(timeSheet)
                    break
                case RateTypeEnum.PLF :

                    break
                case RateTypeEnum.DAILY_MINIMUM :

                    break
                default :
                    log.debug("No matching rate type for standard wages!")
                    break
            }
        }
        if (worker.wageTypeEnum == WageTypeEnum.PREVAILING_WAGE){
            switch (worker.rateTypeEnum){
                case RateTypeEnum.NEW_YORK :

                    break
                case RateTypeEnum.NEW_YORK_R_AND_M :

                    break
                case RateTypeEnum.ILLINOIS :

                    break
                case RateTypeEnum.NEW_JERSEY :

                    break
                case RateTypeEnum.CONNECTICUT :

                    break
                default:
                    log.debug("No matching rate type for prevailing wages!")
                    break
            }
        }
        if (worker.wageTypeEnum == WageTypeEnum.UNION_WAGE){
            switch (worker.rateTypeEnum){
                case RateTypeEnum.NY_DC9_A_RATE_PLA :

                    break
                case RateTypeEnum.NY_DC9_B_RATE_FULL_RATE :

                    break
                case RateTypeEnum.IL_LOCAL_27 :

                    break
                default :
                    log.debug("No matching rate type for union wages!")
                    break
            }
        }
        regularPay
    }

    def calcPerSqFtPay(TimeSheet timeSheet, ChbUsers me){
        BigDecimal psfRate = BigDecimal.ZERO
        SiteReport siteReport = timeSheet.siteReport
        List workDetailsCompletedList = siteReport.workDetailsCompleted
        BigDecimal totalSqFt = BigDecimal.ZERO
        workDetailsCompletedList.each{ wd ->
            if (wd.worker == me) {
                def width = wd.workDetails.width
                def length = wd.workDetails.length
                def quantity = wd.qtyCompleted
                def sqFt = (width * length) * quantity
                totalSqFt += sqFt
            }
        }
        println "Total Sq. Ft. : $totalSqFt"
        totalSqFt?totalSqFt*psfRate:BigDecimal.ZERO
    }

    def calcOvertimeHours(BigDecimal totalHours, TimeSheet timeSheet){
        def worker = timeSheet.worker
        def overtimeHours
        def workHours = timeSheet.regularHours() //calcRegularHours(timeSheet)
        def totalWorkHours = workHours + totalHours
        def overtimeThreshold = General.findByNameEnumAndActive(GeneralEnum.OVER_TIME_THRESHOLD, true)?.value?.toBigDecimal()
        if (worker.wageTypeEnum == WageTypeEnum.STANDARD_WAGE){
            switch (worker.rateTypeEnum){
                case RateTypeEnum.HOURLY :
                    if (totalWorkHours > overtimeThreshold){
                        overtimeHours = totalWorkHours.minus(overtimeThreshold)
                    }
                    break
                case RateTypeEnum.PREMIUM :

                    break
                case RateTypeEnum.PSF :

                    break
                case RateTypeEnum.PLF :

                    break
                case RateTypeEnum.DAILY_MINIMUM :

                    break
                default :
                    log.debug("No matching rate type for standard wages!")
                    break
            }
        }
        if (worker.wageTypeEnum == WageTypeEnum.PREVAILING_WAGE){
            switch (worker.rateTypeEnum){
                case RateTypeEnum.NEW_YORK :

                    break
                case RateTypeEnum.NEW_YORK_R_AND_M :

                    break
                case RateTypeEnum.ILLINOIS :

                    break
                case RateTypeEnum.NEW_JERSEY :

                    break
                case RateTypeEnum.CONNECTICUT :

                    break
                default:
                    log.debug("No matching rate type for prevailing wages!")
                    break
            }
        }
        if (worker.wageTypeEnum == WageTypeEnum.UNION_WAGE){
            switch (worker.rateTypeEnum){
                case RateTypeEnum.NY_DC9_A_RATE_PLA :

                    break
                case RateTypeEnum.NY_DC9_B_RATE_FULL_RATE :

                    break
                case RateTypeEnum.IL_LOCAL_27 :

                    break
                default :
                    log.debug("No matching rate type for union wages!")
                    break
            }
        }
        overtimeHours?:BigDecimal.ZERO
    }

    def calcOvertimePay(BigDecimal overtimeHours, BigDecimal overtimeRate){
        overtimeHours*overtimeRate
    }

    def overTimeRateCalc(){
        BigDecimal.ZERO
    }

    def calcRegularHours(TimeSheet timeSheet){
        def lunchPeriod = lunchPeriod()
        TimeDuration hrs = TimeCategory.minus(timeSheet.endDateTime, timeSheet.startDateTime)
        def newTime = hrs.plus(roundTimeUpToQuarterHour(hrs.minutes, 15))
        def workHours = newTime.hours + (newTime.minutes==0?0:newTime.minutes.div(60))
        timeSheet.lunchBreak ? workHours.minus(lunchPeriod) : workHours
    }

    def lunchPeriod(){
        General.findByNameEnumAndActive(GeneralEnum.LUNCH_PERIOD, true)?.value?.toBigDecimal()
    }

    def roundTimeUpToQuarterHour(Integer num, Integer quarter){
        //println "number for modulo : $num"
        //println "round up to quarter hour : $quarter"
        def modNum = num % quarter
        //println "modulo operation result : $modNum"
        def toAdd = modNum>0?(quarter-modNum):0
        //println "value to add : $toAdd"
        //println "final result : ${num.plus(toAdd)}"
        //num.plus(toAdd)
        new Duration(0,0,toAdd,0,0)
    }

    def teamLeaderPayCalc(boolean teamLeader, TimeSheet timeSheet, List jobDates, BigDecimal teamLeaderPay){
        def leaderPay = BigDecimal.ZERO
        if (teamLeader){
            if (jobDates.size() == 0 || !jobDates.contains(timeSheet.startDateTime)){
                leaderPay = teamLeaderPay
            }
        }
        leaderPay
    }

    List timeSheetWorkerList(Date payrollPeriodStart, Date payrollPeriodEnd){
        TimeSheet.withCriteria {
            projections{
                worker{
                    worker{
                        distinct('id')
                    }
                }
            }
            and {
                eq('isApprovedForPayroll', true)
                between('startDateTime', payrollPeriodStart, payrollPeriodEnd.plus(1))
            }
        }
    }

    List specialHoursWorkerList(Date payrollPeriodStart, Date payrollPeriodEnd){
        SpecialHours.withCriteria {
            projections{
                distinct('employee')
            }
            between('date', payrollPeriodStart, payrollPeriodEnd.plus(1))
        }
    }

    def priorPeriodWorkerList(Date payrollPeriodStart, Date payrollPeriodEnd){
        PriorPeriodAdjustments.withCriteria {
            projections{
                distinct('employee')
            }
            between('workDate', payrollPeriodStart, payrollPeriodEnd.plus(1))
        }
    }

    List timeSheetList(Long id, String start, String end){
        TimeSheet.createCriteria().list {
            createAlias('worker', 'wkr')
            createAlias('wkr.worker', 'usr')
            and {
                eq('usr.id', id)
                eq('isApprovedForPayroll', true)
                between('startDateTime', new SimpleDateFormat('M/d/yy').parse(start), new SimpleDateFormat('M/d/yy').parse(end).plus(1))
            }
        }
    }

    BigDecimal totalPsfForWeek(ChbUsers worker, SiteReport siteReport, Date start, Date end){
        List workDetailsCompletedList = siteReport.workDetailsCompleted
        BigDecimal totalSqFt = BigDecimal.ZERO
        workDetailsCompletedList.each{ wd ->
            if (wd.worker == worker) {
                def width = wd.workDetails.width==0?:wd.workDetails.width?.div(12)
                def length = wd.workDetails.length
                def quantity = wd.qtyCompleted
                def sqFt = (width * length) * quantity
                totalSqFt += sqFt
            }
        }
        println "Total Sq. Ft. : $totalSqFt"
        totalSqFt?totalSqFt*psfRate:BigDecimal.ZERO
    }

    BigDecimal totalSqFt(ChbUsers worker, Date start, Date end){
        List workDetailsCompletedList  = WorkDetailsCompleted.findAllByWorkerAndDateCompletedBetween(worker, start, end)
        def totalSqFt = 0
        workDetailsCompletedList?.each{ wd ->
            WorkDetails workDetails = wd?.workDetails
            totalSqFt = workDetails.width?.multiply(workDetails.length)?.multiply(workDetails.quantity)?.div(144)
        }
        totalSqFt
    }
}
