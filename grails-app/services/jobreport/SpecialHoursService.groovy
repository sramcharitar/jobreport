package jobreport

import grails.gorm.transactions.Transactional

@Transactional
class SpecialHoursService {

    def saveSpecialHours(SpecialHours specialHours) {
        if (!save(specialHours).hasErrors()){
            List timeSheet = TimeSheet.withCriteria {
                createAlias('worker', 'wkr')
                and{
                    between('startDateTime', specialHours.date, specialHours.date.plus(1))
                    eq('wkr.worker', specialHours.employee)
                }
            }
            if (timeSheet?.size()){
                println "found a time sheet"
                SiteReport siteReport = timeSheet[0].siteReport
                specialHours.siteReport = siteReport
                siteReport.addToSpecialHours(specialHours)
                siteReport.save(flush:true)
            }
        }
        return specialHours
    }

    def deleteSpecialHours(SpecialHours specialHours) {
        delete(specialHours)
    }

    def specialHoursList(params){
        def employee = ChbUsers.get(params.chbEmployee)
        SpecialHours.findAllByEmployee(employee, params)
    }

    def save(SpecialHours specialHours){
        return specialHours.save(flush:true)
    }

    def delete(SpecialHours specialHours){
        specialHours.delete(flush: true)
    }
}
