package jobreport

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.apache.poi.sl.draw.binding.CTScale2D

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured("hasRole('ROLE_ACCOUNTING')")
class PayrollScheduleController {

    PayrollScheduleService payrollScheduleService
    PayrollCalculationService payrollCalculationService
    ExcelReporterService excelReporterService
    SpecialHoursService specialHoursService
    PriorPeriodAdjustmentsService priorPeriodAdjustmentsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 20)
        params.order = params.order ?: 'asc'
        params.img = params.img ?: 'down'
        params.sort = params.sort ?: 'lastUpdated'
        def now = new Date()
        def today = formatDate(date: now, type:'date', format: 'M/d/yy')
        def tomorrow = formatDate(date: now, type:'date', format: 'M/d/yy')
        params.pStartDate = today
        params.pEndDate = today
        if (params.startDate && params.endDate){
            params.pStartDate = formatDate(date:Date.parse('M/d/yy', params.startDate).minus(14), type: 'date', format: 'M/d/yy')
            params.pEndDate = formatDate(date:Date.parse('M/d/yy', params.startDate).minus(1), type: 'date', format: 'M/d/yy')
        }
        params.startDate = params.startDate ?: today
        params.endDate = params.endDate ?: today

        def timeSheetList = payrollCalculationService.employeeTimeSheets(params.startDate, params.endDate)
        def specialHoursList = payrollCalculationService.employeeSpecialHours(params.startDate, params.endDate)
        //combine(timeSheetList, specialHoursList)
        def priorPeriodAdjustmentsList = payrollCalculationService.employeePriorPeriodAdjustments(params.pStartDate, params.pEndDate)
        def timeSheets = payrollCalculationService.timeSheetPeriods(timeSheetList, Date.parse('MM/dd/yyyy', params.startDate))
        def timeSheetList1 = timeSheets[0]
        def timeSheetList2 = timeSheets[1]
        def timeSheetWorkerList = TimeSheet.findAllByPayrollCompleteAndStartDateTimeBetween(false, new SimpleDateFormat("M/d/yy").parse(params.startDate), new SimpleDateFormat('M/d/yy').parse(params.endDate).plus(1))*.worker.unique()
        [timeSheetWorkerList:timeSheetWorkerList, timeSheetList:timeSheetList, specialHoursList:specialHoursList, priorPeriodAdjustmentsList:priorPeriodAdjustmentsList, timeSheetList1:timeSheetList1, timeSheetList2:timeSheetList2, params:params, tab:0]
    }

    def specialHours(Integer max) {
        params.max = Math.min(max ?: 10, 20)
        params.order = params.order ?: 'asc'
        params.img = params.img ?: 'down'
        params.sort = params.sort ?: 'lastUpdated'
        def specialHoursList = specialHoursService.specialHoursList(params)
        render template: 'specialHoursList', model: [specialHoursList:specialHoursList, employee:ChbUsers.get(params.chbEmployee), params:params, tab:1]
    }

    def saveSpecialHours(SpecialHours specialHours){
        try {
            if (specialHours == null){
                specialHours = new SpecialHours(params)
            }
            specialHoursService.saveSpecialHours(specialHours)
        } catch (ValidationException e) {
            render template:'specialHoursErrors', model: [objectInstance:specialHours]
            return
        }
        def specialHoursList = specialHoursService.specialHoursList(params)
        render template:'specialHoursList', model: [specialHoursList:specialHoursList, employee:ChbUsers.get(params.chbEmployee), params:params, tab:1]
        return
    }

    def deleteSpecialHours(SpecialHours specialHours){
        def specialHoursList
        def employee = specialHours?.employee
        params.max = 20
        params.sort = 'date'
        params.order = 'desc'
        params.chbEmployee = employee?.id
        try {
            specialHoursService.delete(specialHours)
            specialHoursList = specialHoursService.specialHoursList(params)
        } catch (ValidationException e) {
            render template:'specialHoursErrors', model: [objectInstance:specialHours]
            return
        }
        render template:'specialHoursList', model: [specialHoursList:specialHoursList, employee:employee, params:params, tab:1]
        return
    }

    def priorAdjustments(Integer max){
        params.max = Math.min(max ?: 10, 20)
        params.order = params.order ?: 'desc'
        params.img = params.img ?: 'down'
        params.sort = params.sort ?: 'workDate'
        def priorAdjustmentsList = priorPeriodAdjustmentsService.priorAdjustmentsList(params)
        render template: 'priorAdjustmentsList', model: [priorAdjustmentsList:priorAdjustmentsList, employee:ChbUsers.get(params.chbEmployee), params:params, tab:2]
    }

    def saveAdjustments(PriorPeriodAdjustments priorPeriodAdjustments){
        try {
            if (priorPeriodAdjustments == null){
                priorPeriodAdjustments = new PriorPeriodAdjustments(params)
            }
            priorPeriodAdjustmentsService.saveAdjustments(priorPeriodAdjustments)
        } catch (ValidationException e) {
            render template:'specialHoursErrors', model: [objectInstance:priorPeriodAdjustments]
            return
        }
        def priorAdjustmentsList = priorPeriodAdjustmentsService.priorAdjustmentsList(params)
        render template:'priorAdjustmentsList', model: [priorAdjustmentsList:priorAdjustmentsList, employee:ChbUsers.get(params.chbEmployee), params:params, tab:1]
        return
    }

    def deletePriorAdjustment(PriorPeriodAdjustments priorPeriodAdjustments){
        def priorAdjustmentsList
        def employee = priorPeriodAdjustments?.employee
        params.max = 20
        params.sort = 'workDate'
        params.order = 'desc'
        params.chbEmployee = employee?.id
        try {
            priorPeriodAdjustmentsService.delete(priorPeriodAdjustments)
            priorAdjustmentsList = priorPeriodAdjustmentsService.priorAdjustmentsList(params)
        } catch (ValidationException e) {
            render template:'specialHoursErrors', model: [objectInstance:priorPeriodAdjustments]
            return
        }
        render template:'priorAdjustmentsList', model: [priorAdjustmentsList:priorAdjustmentsList, employee:employee, params:params, tab:1]
        return
    }

    def show(Long id) {
        respond payrollScheduleService.get(id)
    }

    def create() {
        respond new PayrollSchedule(params)
    }

    def save(PayrollSchedule payrollSchedule) {
        if (payrollSchedule == null) {
            notFound()
            return
        }

        try {
            payrollScheduleService.save(payrollSchedule)
        } catch (ValidationException e) {
            respond payrollSchedule.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'payrollSchedule.label', default: 'PayrollS chedule'), payrollSchedule.id])
                redirect payrollSchedule
            }
            '*' { respond payrollSchedule, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond payrollScheduleService.get(id)
    }

    def update(PayrollSchedule payrollSchedule) {
        if (payrollSchedule == null) {
            notFound()
            return
        }

        try {
            payrollScheduleService.save(payrollSchedule)
        } catch (ValidationException e) {
            respond payrollSchedule.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'payrollSchedule.label', default: 'Payroll Schedule'), payrollSchedule.id])
                redirect payrollSchedule
            }
            '*'{ respond payrollSchedule, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        payrollScheduleService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'payrollSchedule.label', default: 'Payroll Schedule'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'payrollSchedule.label', default: 'Payroll Schedule'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def searchPayPeriod(){
        SiteReport.findAllByIsReadyForAccountingAndNotIsPayrollComplete(true, false)
    }

    def excelPayrollStub() {
        def today = new Date()
        params.pStartDate = today
        params.pEndDate = today
        if (params.startDate && params.endDate){
            params.pStartDate = formatDate(date:Date.parse('M/d/yy', params.startDate).minus(14), type: 'date', format: 'M/d/yy')
            params.pEndDate = formatDate(date:Date.parse('M/d/yy', params.startDate).minus(1), type: 'date', format: 'M/d/yy')
        }
        OutputStream outputStream = new ByteArrayOutputStream()
        def timeSheetList = payrollCalculationService.employeeTimeSheets(params.startDate, params.endDate)
        def employeeSpecialHours = payrollCalculationService.employeeSpecialHours(params.startDate, params.endDate)
        combine(timeSheetList, employeeSpecialHours)
        def employeePriorPeriodAdjustments = payrollCalculationService.employeePriorPeriodAdjustments(params.pStartDate, params.pEndDate)
        try {
            excelReporterService.createPayrollStub(outputStream, timeSheetList, employeeSpecialHours, employeePriorPeriodAdjustments, params.startDate, params.endDate)
            response.setHeader "Content-disposition", "attachment; filename=Payroll Period ${params.startDate} - ${params.endDate}.xlsx"
            response.contentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        } catch(Throwable t){
            log.error("Failed to generate report: ${t.getMessage()}", t)
            render "Failed to generate report - please inform support\n\n${t.getMessage()}\n"
            return
        }
        response.outputStream << outputStream.toByteArray()
        response.outputStream.flush()
    }

    def timeSheetData(TimeSheet timeSheet){
        render template: "detail", model: [timeSheet: timeSheet]
    }

    def combine(def timeSheet, def specialHours){
        specialHours.each{ sh ->
           def exists = false
           timeSheet.each{ ts ->
               // loop thru all employee for a match
               if (ts.worker == sh.employee){ exists = true }
           }
           if (exists){
               // the employee exists - add to payroll details for employee
               timeSheet.collect().each{ ts ->
                   if (ts.worker == sh.employee){
                       sh.details.each{ d ->
                           ts.payrollDetails.add([startDate:d.date, jobLocation:d.typeEnum, specialHours: d.hours, specialPay:d.pay])
                       }
                       ts.weekOneTotalSpecialHours = sh.weekOneTotalSpecialHours
                       ts.weekOneTotalSpecialPay = sh.weekOneTotalSpecialPay
                       ts.weekTwoTotalSpecialHours = sh.weekTwoTotalSpecialHours
                       ts.weekTwoTotalSpecialPay = sh.weekTwoTotalSpecialPay
                       ts.totalSpecialHours = sh.totalSpecialHours
                       ts.totalSpecialPay = sh.totalSpecialPay
                       ts.totalPayWithTeamLeaderBonus = ts.totalPayWithTeamLeaderBonus + ts.totalSpecialPay
                   }
               }
           }
           else{
               timeSheet.add([worker:sh.employee])
               sh.details.each{ d ->
                   timeSheet.collect().each{ ts ->
                       if (ts.worker == sh.employee){
                           ts.payrollDetails = [[startDate:d.date, jobLocation:d.typeEnum, specialHours: d.hours, specialPay:d.pay]]
                           ts.weekOneTotalSpecialHours = sh.weekOneTotalSpecialHours
                           ts.weekOneTotalSpecialPay = sh.weekOneTotalSpecialPay
                           ts.weekTwoTotalSpecialHours = sh.weekTwoTotalSpecialHours
                           ts.weekTwoTotalSpecialPay = sh.weekTwoTotalSpecialPay
                           ts.totalSpecialHours = sh.totalSpecialHours
                           ts.totalSpecialPay = sh.totalSpecialPay
                           ts.totalPayWithTeamLeaderBonus = ts.totalPayWithTeamLeaderBonus + ts.totalSpecialPay
                       }
                   }
               }
           }
        }
        timeSheet.each{ ts ->
            ts.payrollDetails.sort{ t1, t2 ->
                t1.startDate <=> t2.startDate
            }
        }
    }
}
