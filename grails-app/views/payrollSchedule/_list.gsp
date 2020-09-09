<table class="contentframework">
    <thead>
    <tr>
        <th class="contentframework-dataheadertop" scope="col" colspan="2"></th>
        <th class="contentframework-dataheadertop" scope="col" colspan="2"><strong><g:message code="payrollSchedule.hours.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"></th>
        <th class="contentframework-dataheadertop" scope="col"></th>
        <th class="contentframework-dataheadertop" scope="col" colspan="2"><strong><g:message code="fieldTeam.payRate.title"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col" colspan="2"><strong><g:message code="payrollSchedule.pay.label"/></strong></th>
    </tr>
    <tr>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="jobReport.workOrderNumber.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="payrollSchedule.date.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="payrollSchedule.reg.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="payrollSchedule.ot.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="fieldTeam.wageAndBasis.title"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="fieldTeam.teamLeader.title"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="payrollSchedule.reg.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="payrollSchedule.ot.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="payrollSchedule.reg.label"/></strong></th>
        <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="payrollSchedule.ot.label"/></strong></th>
    </tr>
    </thead>
    <tbody class="contentframework-stripedtable">
    <g:each in="${timeSheetList}" var="timeSheet" status="i">
        <g:if test="${timeSheet.size()>0}">
        <tr class="contentframework-expandcollapserow">
            <td colspan="10" class="contentframework-formdatalabel"><a onclick="toggleIcon('fieldAgent${i}_${weekOne?'weekOne':'weekTwo'}','fieldAgent_${i}_icon_${weekOne?'weekOne':'weekTwo'}');return false" id="fieldAgent_${i}_icon_${weekOne?'weekOne':'weekTwo'}" href="#" class="toggleiconlink"><asset:image src="contentframework/icon-collapse.gif" alt="Collapse" /><span class="toggleiconlink-label"><strong>${timeSheet.worker}</strong></span></a></td>
        </tr>
        <g:each var="timeSheetDetail" in="${timeSheet.payrollDetails}" status="j">
            <g:if test="${weekOne && (timeSheetDetail?.startDate < Date.parse('MM/dd/yyyy', params.startDate)?.plus(7))}">
                <tr class="fieldAgent${i}_${weekOne?'weekOne':'weekTwo'}">
                    <td>
                        <a href="#" id="_timeSheetData_${j}__${weekOne?'weekOne':'weekTwo'}" onclick="timeSheetData(${timeSheetDetail.id}, event)">
                            <span title="${timeSheetDetail.clientName}">#${timeSheetDetail.jobNumber}</span>
                        </a>
                    </td>
                    <td><g:formatDate type="date" date="${timeSheetDetail.startDate}" style="MEDIUM"/></td>
                    <td><span title="<g:message code="payrollSchedule.timeIn.label"/>: <g:formatDate type="time" date="${timeSheetDetail.timeIn}" style="SHORT"/> | <g:message code="payrollSchedule.timeOut.label"/>: <g:formatDate type="time" date="${timeSheetDetail.timeOut}" style="SHORT"/>"><g:formatNumber number="${timeSheetDetail.regularHours}" type="number" groupingUsed="false" maxFractionDigits="2"/></span></td>
                    <td>
                        <g:if test="${timeSheetDetail.overtimeHours}">
                            <g:formatNumber number="${timeSheetDetail.overtimeHours}" type="number" groupingUsed="false" maxFractionDigits="2"/>
                        </g:if>
                    </td>
                    <td>${timeSheetDetail.wageType} / ${timeSheetDetail.basis}</td>
                    <td>
                        <g:if test="${timeSheetDetail.teamLeaderPay}">
                            <g:formatNumber number="${timeSheetDetail.teamLeaderPay?.toBigDecimal()}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.rate}">
                            <g:formatNumber number="${timeSheetDetail.rate}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.otRate}">
                            <g:formatNumber number="${timeSheetDetail.otRate}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.regularPay}">
                            <g:formatNumber number="${timeSheetDetail.regularPay}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.overTimePay}">
                            <g:formatNumber number="${timeSheetDetail.overTimePay}" type="currency"/>
                        </g:if>
                    </td>
                </tr>
            </g:if>
            <g:if test="${!weekOne && (timeSheetDetail?.startDate >= Date.parse('MM/dd/yyyy', params.startDate)?.plus(7))}">
                <tr class="fieldAgent${i}_${weekOne?'weekOne':'weekTwo'}">
                    <td>
                        <a href="#" id="_timeSheetData" onclick="timeSheetData(${timeSheetDetail.id}, event)">
                            <span title="${timeSheetDetail.clientName}">#${timeSheetDetail.jobNumber}</span>
                        </a>
                    </td>
                    <td><g:formatDate type="date" date="${timeSheetDetail.startDate}" style="MEDIUM"/></td>
                    <td><span title="<g:message code="payrollSchedule.timeIn.label"/>: <g:formatDate type="time" date="${timeSheetDetail.timeIn}" style="SHORT"/> | <g:message code="payrollSchedule.timeOut.label"/>: <g:formatDate type="time" date="${timeSheetDetail.timeOut}" style="SHORT"/>"><g:formatNumber number="${timeSheetDetail.regularHours}" type="number" groupingUsed="false" maxFractionDigits="2"/></span></td>
                    <td>
                        <g:if test="${timeSheetDetail.overtimeHours}">
                            <g:formatNumber number="${timeSheetDetail.overtimeHours}" type="number" groupingUsed="false" maxFractionDigits="2"/>
                        </g:if>
                    </td>
                    <td>${timeSheetDetail.wageType} / ${timeSheetDetail.basis}</td>
                    <td>
                        <g:if test="${timeSheetDetail.teamLeaderPay}">
                            <g:formatNumber number="${timeSheetDetail.teamLeaderPay?.toBigDecimal()}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.rate}">
                            <g:formatNumber number="${timeSheetDetail.rate}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.otRate}">
                            <g:formatNumber number="${timeSheetDetail.otRate}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.regularPay}">
                            <g:formatNumber number="${timeSheetDetail.regularPay}" type="currency"/>
                        </g:if>
                    </td>
                    <td>
                        <g:if test="${timeSheetDetail.overTimePay}">
                            <g:formatNumber number="${timeSheetDetail.overTimePay}" type="currency"/>
                        </g:if>
                    </td>
                </tr>
            </g:if>
        </g:each>
        <tr class="fieldAgent${i}_${weekOne?'weekOne':'weekTwo'}">
            <td class="contentframework-totalrow"></td>
            <td class="contentframework-totalrow"></td>
            <g:if test="${weekOne}">
                <td class="contentframework-totalrow">
                    <g:if test="${timeSheet.weekOneTotalRegularHours > 0}">
                        <strong><g:formatNumber number="${timeSheet.weekOneTotalRegularHours}" type="number" groupingUsed="false" maxFractionDigits="2"/></strong>
                    </g:if>
                </td>
            </g:if>
            <g:else>
                <td class="contentframework-totalrow">
                    <g:if test="${timeSheet.weekTwoTotalRegularHours > 0}">
                        <strong><g:formatNumber number="${timeSheet.weekTwoTotalRegularHours}" type="number" groupingUsed="false" maxFractionDigits="2"/></strong>
                    </g:if>
                </td>
            </g:else>
            <g:if test="${weekOne}">
                <td class="contentframework-totalrow">
                    <g:if test="${timeSheet.weekOneTotalOverTimeHours > 0}">
                        <strong><g:formatNumber number="${timeSheet.weekOneTotalOverTimeHours}" type="number" groupingUsed="false" maxFractionDigits="2"/></strong>
                    </g:if>
                </td>
            </g:if>
            <g:else>
                <td class="contentframework-totalrow">
                    <g:if test="${timeSheet.weekTwoTotalOverTimeHours > 0}">
                        <strong><g:formatNumber number="${timeSheet.weekTwoTotalOverTimeHours}" type="number" groupingUsed="false" maxFractionDigits="2"/></strong>
                    </g:if>
                </td>
            </g:else>
            <td class="contentframework-totalrow"></td>
            <g:if test="${weekOne}">
                <td class="contentframework-totalrow">
                    <g:if test="${timeSheet.weekOneTotalTeamLeaderPay}">
                        <strong><g:formatNumber number="${timeSheet.weekOneTotalTeamLeaderPay}" type="currency"/></strong>
                    </g:if>
                </td>
            </g:if>
            <g:else>
                <td class="contentframework-totalrow">
                    <g:if test="${timeSheet.weekTwoTotalTeamLeaderPay}">
                        <strong><g:formatNumber number="${timeSheet.weekTwoTotalTeamLeaderPay}" type="currency"/></strong>
                    </g:if>
                </td>
            </g:else>
            <td class="contentframework-totalrow"></td>
            <td class="contentframework-totalrow"></td>
            <g:if test="${weekOne}">
                <td class="contentframework-totalrow"><strong><g:formatNumber number="${timeSheet.weekOneTotalRegularPay}" type="currency"/></strong></td>
            </g:if>
            <g:else>
                <td class="contentframework-totalrow"><strong><g:formatNumber number="${timeSheet.weekTwoTotalRegularPay}" type="currency"/></strong></td>
            </g:else>
            <td class="contentframework-totalrow">
                <g:if test="${timeSheet.totalOverTimePay}">
                    <strong><g:formatNumber number="${timeSheet.totalOverTimePay}" type="currency"/></strong>
                </g:if>
            </td>
        </tr>
        <tr class="fieldAgent${i}_${weekOne?'weekOne':'weekTwo'}">
            <td class="contentframework-totalrow" colspan="8" style="text-align: right">
                <strong><g:message code="reports.label.totalPay"/></strong>
            </td>
            <g:if test="${weekOne}">
                <td class="contentframework-totalrow" colspan="2" style="text-align: right">
                    <strong><g:formatNumber number="${timeSheet.weekOneTotalPayWithTeamLeaderBonus}" type="currency"/></strong>
                </td>
            </g:if>
            <g:else>
                <td class="contentframework-totalrow" colspan="2" style="text-align: right">
                    <strong><g:formatNumber number="${timeSheet.weekTwoTotalPayWithTeamLeaderBonus}" type="currency"/></strong>
                </td>
            </g:else>
        </tr>
        </g:if>
    </g:each>
    </tbody>
</table>
<div><p>&nbsp;</p></div>