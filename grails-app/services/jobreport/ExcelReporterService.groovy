package jobreport

import grails.gorm.transactions.Transactional
import com.jameskleeh.excel.Excel
import com.jameskleeh.excel.ExcelBuilder

import java.text.SimpleDateFormat
import org.apache.poi.ss.usermodel.BorderStyle

@Transactional
class ExcelReporterService extends AbstractReportService {

    def createPayrollStub(OutputStream stream, List timeSheetList, List specialHoursList, List priorPeriodList, String startDate, String endDate) {
        def employeeList = mergeEmployeeNames(timeSheetList, specialHoursList, priorPeriodList)
        def payrollPeriodStart = new SimpleDateFormat("M/d/yy").parse(startDate)
        def payrollPeriodEnd = new SimpleDateFormat("M/d/yy").parse(endDate)
        SimpleDateFormat formatter = new SimpleDateFormat("M/d/yyyy")
        Excel.registerCellFormat(BigDecimal, "[Black]#,##0.00;[Red](#,##0.00)")
        Map defaultHeadingStyle = [font: [bold: true, size: 10], border: [style: BorderStyle.THIN], backgroundColor: "#ccd4e5"]
        Map headingStyleOne = [font: [bold: true, size: 10], border: [style: BorderStyle.THIN], backgroundColor: "#ccd4e5", alignment: "right"]
        Map headingStyleTwo = [font: [bold: true, size: 10], border: [style: BorderStyle.THIN], backgroundColor: "#ccd4e5", alignment: "center"]
        Map defaultTotalRow = [font: [bold: true, size: 10], border: [style: BorderStyle.THIN], backgroundColor: "#ede9db"]
        Map defaultBold = [font: [bold: true, size: 10], alignment: "center"]
        Map alignmentRight = [alignment: "right"]
        Map alignmentCenter = [alignment: "center"]
        Map wrapCell = [wrapped:true]
        List rowHeaderText = [[heading:'date', hStyle:headingStyleTwo],
                            [heading:'jobId', hStyle:headingStyleOne],
                            [heading:'jobLocation', hStyle:headingStyleOne],
                            [heading:'regularHours', hStyle:headingStyleOne],
                            [heading:'overtimeHours', hStyle:headingStyleOne],
                            [heading:'specialHours', hStyle:headingStyleOne],
                            [heading:'', hStyle:headingStyleOne],
                            [heading:'rate', hStyle:headingStyleOne],
                            [heading:'overtimeRate', hStyle:headingStyleOne],
                            [heading:'regularTotal', hStyle:headingStyleOne],
                            [heading:'overtimeAmount', hStyle:headingStyleOne],
                            [heading:'specialAmount', hStyle:headingStyleOne],
                            [heading:'teamLeader', hStyle:headingStyleOne]]

        ExcelBuilder.output(stream) {
            try {
                def payrollPeriod = msg("payrollPeriod") + " " + formatter.format(payrollPeriodStart) + " - " + formatter.format(payrollPeriodEnd)
                def specialHoursPayrollPeriod = msg("specialHoursPayPeriod") + " " + formatter.format(payrollPeriodStart) + " - " + formatter.format(payrollPeriodEnd)
                def priorPeriodPayrollPeriod = msg("priorPeriodPayPeriod") + " " + formatter.format(payrollPeriodStart) + " - " + formatter.format(payrollPeriodEnd)
                employeeList.each { employee ->
                    sheet(employee) {
                        row {
                            merge {
                                cell(payrollPeriod, defaultBold)
                                skipCells(12)
                            }
                        }
                        row {
                            merge {
                                cell(msg("payrollStub"), defaultBold)
                                skipCells(12)
                            }
                        }
                        row {
                            merge {
                                cell(employee.toUpperCase(), defaultBold)
                                skipCells(12)
                            }
                        }

                        skipRows(2)

                        if (priorPeriodList?.size()) {
                            priorPeriodList.each { pp ->
                                if (employee.toString() == pp.employee.toString()) {
                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        merge {
                                            cell(priorPeriodPayrollPeriod)
                                            skipCells(12)
                                        }
                                    }
                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        rowHeaderText.each{ rowHeader ->
                                            cell(msg(rowHeader.heading), rowHeader.hStyle)
                                        }
                                    }
                                    pp.details.each { detail ->
                                        row {
                                            cell(formatter.format(detail?.workDate).toString(), alignmentCenter)
                                            cell(detail?.jobId, alignmentRight)
                                            cell(detail?.location, alignmentRight)
                                            cell(detail?.regularHours, alignmentRight)
                                            cell(detail?.overtimeHours, alignmentRight)
                                            cell(detail?.specialHours, alignmentRight)
                                            cell("", [width: 50])
                                            cell(detail?.regularRate, alignmentRight)
                                            cell(detail?.overtimeRate, alignmentRight)
                                            cell(detail?.regularPay, alignmentRight)
                                            cell(detail?.overtimePay, alignmentRight)
                                            cell(detail?.specialPay, alignmentRight)
                                            cell(detail?.teamLeaderPay, alignmentRight)
                                        }
                                    }
                                    skipRows(2)
                                }
                            }
                        }

                        /*
                        if (specialHoursList?.size()){
                            specialHoursList.each{ sh ->
                                if (employee.toString() == sh.employee.toString()){
                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        merge {
                                            cell(specialHoursPayrollPeriod)
                                            skipCells(12)
                                        }
                                    }
                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        rowHeaderText.each{ rowHeader ->
                                            cell(msg(rowHeader.heading), rowHeader.hStyle)
                                        }
                                    }
                                    sh.details.each { detail ->
                                        row {
                                            cell(detail.date, alignmentCenter)
                                            skipCells(1)
                                            cell(detail.typeEnum, alignmentRight)
                                            skipCells(2)
                                            cell(detail.hours, alignmentRight)
                                            cell("", [width: 50])
                                            //cell(detail.rate, alignmentCenter)
                                            skipCells(4)
                                            cell(detail.pay, alignmentCenter)
                                            skipCells(1)
                                        }
                                    }
                                    skipRows(2)
                                }
                            }
                        }
                         */

                        if (timeSheetList?.size()) {
                            timeSheetList.each { ts ->
                                if (employee.toString() == ts.worker.toString()) {
                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        merge {
                                            cell(msg("payrollWeek") + " " + formatter.format(ts.payrollPeriodStart) + " - " + formatter.format(ts.payrollPeriodStart.plus(6)))
                                            skipCells(12)
                                        }
                                    }
                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        rowHeaderText.each{ rowHeader ->
                                            cell(msg(rowHeader.heading), rowHeader.hStyle)
                                        }
                                    }

                                    def weekOne = false
                                    ts.payrollDetails.each { detail ->
                                        if (detail.startDate.clearTime() <= ts.payrollPeriodStart.plus(6)) {
                                            weekOne = true
                                            row {
                                                cell(detail.startDate, alignmentCenter)
                                                cell(detail.jobNumber, alignmentRight)
                                                cell(detail.jobLocation, alignmentRight)
                                                cell(detail.regularHours ?: '')
                                                cell(detail.overtimeHours ?: '')
                                                cell(detail.specialHours ?: '')
                                                cell("", [width: 50])
                                                cell(detail.rate ?: '')
                                                cell(detail.otRate ?: '')
                                                cell(detail.regularPay ?: '')
                                                cell(detail.overtimePay ?: '')
                                                cell(detail.specialPay ?: '')
                                                cell(detail.teamLeaderPay ?: '')
                                            }
                                        }
                                    }

                                    if (weekOne) {
                                        row {
                                            defaultStyle(defaultTotalRow)
                                            merge {
                                                cell()
                                                skipCells(2)
                                            }
                                            defaultStyle(defaultTotalRow)
                                            cell(ts.weekOneTotalRegularHours ?: '')
                                            cell(ts.weekOneTotalOverTimeHours ?: '')
                                            cell(ts.weekOneTotalSpecialHours ?: '')
                                            cell("", [width: 50])
                                            cell()
                                            cell()
                                            cell(ts.weekOneTotalRegularPay ?: '')
                                            cell(ts.totalOverTimePay ?: '')
                                            cell(ts.weekOneTotalSpecialPay ?: '')
                                            cell(ts.weekOneTotalTeamLeaderPay ?: '')
                                        }

                                        row {
                                            defaultStyle(defaultTotalRow)
                                            merge {
                                                cell(msg("totalPayForWeek"), alignmentRight)
                                                skipCells(11)
                                            }
                                            defaultStyle(defaultTotalRow)
                                            cell(ts.weekOneTotalSpecialPay ? ts.weekOneTotalSpecialPay.plus(ts.weekOneTotalPayWithTeamLeaderBonus) : ts.weekOneTotalPayWithTeamLeaderBonus?:'')
                                        }
                                    }

                                    skipRows(2)

                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        merge {
                                            cell(msg("payrollWeek") + " " + formatter.format(ts.payrollPeriodStart.plus(7)) + " - " + formatter.format(ts.payrollPeriodStart.plus(13)))
                                            skipCells(12)
                                        }
                                    }
                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        rowHeaderText.each{ rowHeader ->
                                            cell(msg(rowHeader.heading), rowHeader.hStyle)
                                        }
                                    }

                                    def weekTwo = false
                                    ts.payrollDetails.each { detail ->
                                        if (detail.startDate.clearTime() > ts.payrollPeriodStart.plus(6)) {
                                            weekTwo = true
                                            row {
                                                cell(detail.startDate, alignmentCenter)
                                                cell(detail.jobNumber, alignmentRight)
                                                cell(detail.jobLocation, alignmentRight)
                                                cell(detail.regularHours ?: '')
                                                cell(detail.overtimeHours ?: '')
                                                cell(detail.specialHours ?: '')
                                                cell("", [width: 50])
                                                cell(detail.rate ?: '')
                                                cell(detail.otRate ?: '')
                                                cell(detail.regularPay ?: '')
                                                cell(detail.overtimePay ?: '')
                                                cell(detail.specialPay ?: '')
                                                cell(detail.teamLeaderPay ?: '')
                                            }
                                        }

                                    }

                                    if (weekTwo) {
                                        row {
                                            defaultStyle(defaultTotalRow)
                                            merge {
                                                cell()
                                                skipCells(2)
                                            }
                                            defaultStyle(defaultTotalRow)
                                            cell(ts.weekTwoTotalRegularHours ?: '')
                                            cell(ts.weekTwoTotalOverTimeHours ?: '')
                                            cell(ts.weekTwoTotalSpecialHours ?: '')
                                            cell("", [width: 50])
                                            cell()
                                            cell()
                                            cell(ts.weekTwoTotalRegularPay ?: '')
                                            cell(ts.weekTwoTotalOverTimePay ?: '')
                                            cell(ts.weekTwoTotalSpecialPay ?: '')
                                            cell(ts.weekTwoTotalTeamLeaderPay ?: '')
                                        }

                                        row {
                                            defaultStyle(defaultTotalRow)
                                            merge {
                                                cell(msg("totalPayForWeek"), alignmentRight)
                                                skipCells(11)
                                            }
                                            defaultStyle(defaultTotalRow)
                                            cell(ts.weekTwoTotalSpecialPay ?  ts.weekTwoTotalSpecialPay.plus(ts.weekTwoTotalPayWithTeamLeaderBonus) : ts.weekTwoTotalPayWithTeamLeaderBonus?:'')
                                        }
                                    }

                                    skipRows(2)

                                    row {
                                        defaultStyle(defaultHeadingStyle)
                                        merge {
                                            cell(msg("total"), wrapCell + alignmentRight)
                                            skipCells(2)
                                        }
                                        defaultStyle(defaultHeadingStyle)
                                        cell(msg("regularHours"), wrapCell + alignmentRight)
                                        cell(msg("overtimeHours"), wrapCell + alignmentRight)
                                        cell(msg("specialHours"), wrapCell + alignmentRight)
                                        cell("", [width: 50])
                                        defaultStyle(defaultHeadingStyle)
                                        merge {
                                            cell(msg("regularTotal"), wrapCell + alignmentRight)
                                            skipCells(2)
                                        }
                                        defaultStyle(defaultHeadingStyle)
                                        cell(msg("overtimeAmount"), wrapCell + alignmentRight)
                                        cell(msg("specialAmount"), wrapCell + alignmentRight)
                                        cell(msg("teamLeader"), alignmentRight)
                                    }

                                    row {
                                        defaultStyle(defaultTotalRow)
                                        merge {
                                            cell(ts.totalRegularHours ?: '')
                                            skipCells(3)
                                        }
                                        defaultStyle(defaultTotalRow)
                                        cell(ts.totalOverTimeHours ?: '')
                                        cell(ts.totalSpecialHours ?: '')
                                        cell("", [width: 50])
                                        defaultStyle(defaultTotalRow)
                                        merge {
                                            cell(ts.totalRegularPay ?: '')
                                            skipCells(2)
                                        }
                                        defaultStyle(defaultTotalRow)
                                        cell(ts.totalOverTimePay ?: '')
                                        cell(ts.totalSpecialPay ?: '')
                                        cell(ts.totalTeamLeaderPay ?: '')
                                    }

                                    row {
                                        defaultStyle(defaultTotalRow)
                                        merge {
                                            cell(msg("totalPay"), alignmentRight)
                                            skipCells(11)
                                        }
                                        defaultStyle(defaultTotalRow)
                                        cell(ts.totalPayWithTeamLeaderBonus ?: '')
                                    }
                                }
                            }
                        }

                        sheet.autoSizeColumn(0)
                        sheet.autoSizeColumn(1)
                        sheet.autoSizeColumn(2)
                        sheet.autoSizeColumn(3)
                        sheet.autoSizeColumn(4)
                        sheet.autoSizeColumn(5)
                        sheet.autoSizeColumn(6)
                        sheet.autoSizeColumn(7)
                        sheet.autoSizeColumn(8)
                        sheet.autoSizeColumn(9)
                        sheet.autoSizeColumn(10)
                        sheet.autoSizeColumn(11)
                        sheet.autoSizeColumn(12)
                    }
                }

            } catch (Throwable t) {
                log.error("Error in calculation", t)
                sheet("ERROR!") {
                    row {
                        cell(t.toString())
                    }
                    StackTraceElement[] trace = t.stackTrace
                    trace.each { StackTraceElement element ->
                        row {
                            cell(element.toString())
                        }
                    }
                }
            }
        }
    }

    List mergeEmployeeNames(List timeSheetList, List specialHoursList, List priorPeriodList){
        List employeeList = []

        timeSheetList.each{ ts ->
            //println ts.worker.toString()
            if (!employeeList.contains(ts.worker.toString())){
                //println "adding employee from timesheet : ${ts.worker.toString()}"
                employeeList.add(ts.worker.toString())
            }
        }
        specialHoursList.each{ specialHours ->
            //println specialHours.employee.toString()
            if (!employeeList.contains(specialHours.employee.toString())){
                //println "adding employee from special hours : ${specialHours.employee.toString()}"
                employeeList.add(specialHours.employee.toString())
            }
        }
        priorPeriodList.each{ priorPeriod ->
            //println priorPeriod.employee.toString()
            if (!employeeList.contains(priorPeriod.employee.toString())){
                //println "adding employee from prior period : ${priorPeriod.employee.toString()}"
                employeeList.add(priorPeriod.employee.toString())
            }
        }
        employeeList
    }
}
