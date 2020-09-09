package jobreport

import grails.gorm.transactions.Transactional

@Transactional
class PriorPeriodAdjustmentsService {

    def priorAdjustmentsList(params) {
        def employee = ChbUsers.get(params.chbEmployee)
        PriorPeriodAdjustments.findAllByEmployee(employee, params)
    }

    def saveAdjustments(PriorPeriodAdjustments priorPeriodAdjustments){
        if (!save(priorPeriodAdjustments).hasErrors()){
            List timeSheet = TimeSheet.withCriteria {
                createAlias('worker', 'wkr')
                and{
                    between('startDateTime', priorPeriodAdjustments.workDate, priorPeriodAdjustments.workDate.plus(1))
                    eq('wkr.worker', priorPeriodAdjustments.employee)
                }
            }
            if (timeSheet?.size()){
                println "found a time sheet"
                SiteReport siteReport = timeSheet[0].siteReport
                priorPeriodAdjustments.siteReport = siteReport
                siteReport.addToPriorPeriodAdjustments(priorPeriodAdjustments)
                siteReport.save(flush:true)
            }
        }
        return priorPeriodAdjustments
    }

    def save(PriorPeriodAdjustments priorPeriodAdjustments){
        priorPeriodAdjustments.save(flush:true)
    }

    def delete(PriorPeriodAdjustments priorPeriodAdjustments){
        priorPeriodAdjustments.delete(flush: true)
    }
}
