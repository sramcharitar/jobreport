<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<g:if test="${priorPeriodAdjustmentsList?.size()}">
    <table class="contentframework">
        <thead>
        <tr>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.date"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.jobId"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.wageAndRateType"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.regular"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.overtime"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.teamLeader"/></strong></th>
        </tr>
        </thead>
        <tbody class="contentframework-stripedtable">
            <g:each in="${priorPeriodAdjustmentsList}" var="item" status="i">
                <tr class="contentframework-expandcollapserow">
                    <td colspan="6" class="contentframework-formdatalabel"><a onclick="toggleIcon('fieldAgent_${i}','fieldAgent_icon_${i}');return false" id="fieldAgent_icon_${i}" href="#" class="toggleiconlink"><asset:image src="contentframework/icon-collapse.gif" alt="Collapse" /><span class="toggleiconlink-label"><strong>${item?.employee}</strong></span></a></td>
                </tr>
                <g:each in="${item?.details}" var="priorAdj" status="j">
                    <tr class="fieldAgent_${i}" title="${priorAdj?.location}">
                        <td nowrap><g:formatDate type="date" date="${priorAdj?.workDate}" style="MEDIUM"/></td>
                        <td>${priorAdj?.jobId}</td>
                        <td>${priorAdj.wageTypeEnum}/${priorAdj.rateTypeEnum}</td>
                        <td nowrap><g:message code="reports.label.hrp" args="${[priorAdj?.regularHours, g.formatNumber(number:priorAdj?.regularRate, type:'currency', maxFractionDigits:2, minFractionDigits:2), g.formatNumber(number:priorAdj?.regularPay, type:'currency', maxFractionDigits:2, minFractionDigits:2)]}"/></td>
                        <td nowrap>
                            <g:if test="${priorAdj?.overtimeHours}">
                                <g:message code="reports.label.hrp" args="${[priorAdj?.overtimeHours, g.formatNumber(number:priorAdj?.overtimeRate, type:'currency', maxFractionDigits:2, minFractionDigits:2), g.formatNumber(number:priorAdj?.overtimePay, type:'currency', maxFractionDigits:2, minFractionDigits:2)]}"/>
                            </g:if>
                        </td>
                        <td><g:formatNumber type="currency" number="${priorAdj?.teamLeaderPay}" maxFractionDigits="2" minFractionDigits="2"/></td>
                    </tr>
                </g:each>
            </g:each>
        </tbody>
    </table>
    <div><p>&nbsp;</p></div>
</g:if>