package jobreport

import grails.gorm.services.Service

@Service(PayrollSchedule)
interface PayrollScheduleService {

    PayrollSchedule get(Serializable id)

    List<PayrollSchedule> list(Map args)

    Long count()

    void delete(Serializable id)

    PayrollSchedule save(PayrollSchedule payrollSchedule)

}