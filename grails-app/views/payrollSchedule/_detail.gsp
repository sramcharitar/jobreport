
<table class="contentframework">
    <thead>
        <tr>
            <th class="contentframework-dataheadertop" scope="col" colspan="4">
                <strong><g:message code="payrollSchedule.details.label"/></strong>
            </th>
        </tr>
    </thead>
    <tbody class="contentframework-stripedtable">
        <tr>
            <td class="contentframework-formdatalabel"><strong>Date</strong></td>
            <td class="contentframework-formdatalabel"><strong>Employee</strong></td>
            <td class="contentframework-formdatalabel"><strong>Client/Customer</strong></td>
            <td class="contentframework-formdatalabel"><strong>Job Number</strong></td>
        </tr>
        <tr>
            <td class="contentframework-formdatalabel"><g:formatDate date="${timeSheet.startDateTime}" dateStyle="medium" type="date"/></td>
            <td class="contentframework-formdatalabel"><g:fieldValue field="worker" bean="${timeSheet}"/></td>
            <td class="contentframework-formdatalabel"><g:fieldValue field="client" bean="${timeSheet.siteReport.jobReport}"/></td>
            <td class="contentframework-formdatalabel"><g:fieldValue field="jobName" bean="${timeSheet.siteReport.jobReport}"/></td>
        </tr>
        <tr>
            <td class="contentframework-formdatalabel"><strong>Time In</strong></td>
            <td class="contentframework-formdatalabel"><strong>Time Out</strong></td>
            <td class="contentframework-formdatalabel"><strong>Wage Type</strong></td>
            <td class="contentframework-formdatalabel"><strong>Basis</strong></td>
        </tr>
        <tr>
            <td class="contentframework-formdatalabel"><g:formatDate date="${timeSheet.startDateTime}" style="MEDIUM" type="time"/></td>
            <td class="contentframework-formdatalabel"><g:formatDate date="${timeSheet.endDateTime}" style="MEDIUM" type="time"/></td>
            <td class="contentframework-formdatalabel"><g:fieldValue field="wageTypeEnum" bean="${timeSheet.worker}"/></td>
            <td class="contentframework-formdatalabel"><g:fieldValue field="rateTypeEnum" bean="${timeSheet.worker}"/></td>
        </tr>
        <tr>
            <td class="contentframework-formdatalabel"><strong>Lunch Break</strong></td>
            <td class="contentframework-formdatalabel"><strong>Regular Rate</strong></td>
            <td class="contentframework-formdatalabel"><strong>Regular Hours</strong></td>
            <td class="contentframework-formdatalabel"><strong>Regular Pay</strong></td>
        </tr>
        <tr>
            <td class="contentframework-formdatalabel">
                <g:if test="${timeSheet.lunchBreak}">
                    <g:fieldValue field="value" bean="${jobreport.General.findByNameEnum(jobreport.GeneralEnum.LUNCH_PERIOD)}"/>
                </g:if>
                <g:else>
                    <g:message code="generalEnum.NO_LUNCH" default="No Lunch"/>
                </g:else>
            </td>
            <td class="contentframework-formdatalabel"><g:formatNumber number="${timeSheet.worker.payRate}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="contentframework-formdatalabel"><g:formatNumber number="${timeSheet.regularHours()}" type="number" maxFractionDigits="2" minFractionDigits="0"/></td>
            <td class="contentframework-formdatalabel"><g:formatNumber number="${timeSheet.regularPay()}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="contentframework-formdatalabel"><strong>Overtime Rate</strong></td>
            <td class="contentframework-formdatalabel"><strong>Overtime Hours</strong></td>
            <td class="contentframework-formdatalabel"><strong>Overtime Pay</strong></td>
            <td class="contentframework-formdatalabel"><strong>Total Pay</strong></td>
        </tr>
        <tr>
            <td class="contentframework-formdatalabel"><g:formatNumber number="${timeSheet.overtimeRate()}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="contentframework-formdatalabel">
                <g:if test="${timeSheet.overtimeHours()}">
                    <g:formatNumber number="${timeSheet.overtimeHours()}" type="number" maxFractionDigits="2" minFractionDigits="0"/>
                </g:if>
            </td>
            <td class="contentframework-formdatalabel">
                <g:if test="${timeSheet.overtimeHours()}">
                    <g:formatNumber number="${timeSheet.overtimePay()}" type="currency" maxFractionDigits="2" minFractionDigits="2"/>
                </g:if>
            </td>
            <td class="contentframework-formdatalabel"><g:formatNumber number="${timeSheet.regularPay()+timeSheet.overtimePay()}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
    </tbody>
</table>

