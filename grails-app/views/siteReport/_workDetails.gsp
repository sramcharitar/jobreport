<%@ page import="jobreport.WorkDetailsCompleted" %>

    <table class="contentframework">
        <tbody class="contentframework-stripedtable">
            <tr>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.workType.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.qtyDimension.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.totalLnFt.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.qtyCompleted.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.completedLnFt.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.highScaffold.label"/></th>
                <td class="contentframework-dataheadertop" scope="col" style="font-weight: bold"></td>
            </tr>

            <g:set var="idx" value="0"/>
            <g:set var="siteRep" value="${jobReport.siteReport}"/>
            <g:each var="detail" in="${jobReport.workDetails}" status="i">

            <tr class="subcopy">
                <td><g:fieldValue field="workTypes"     bean="${detail}" /></td>
                <td>
                    <div style="width: 30px; float: left;"><g:fieldValue field="quantity"      bean="${detail}" /></div>
                    <div style="width: 80px; float: left;" title="${g.message(code:'jobReport.widthTimesLength.title', args:[detail.width, detail.length])}">(<g:fieldValue field="width" bean="${detail}" /> X <g:fieldValue field="length" bean="${detail}" />)</div>
                </td>
                <td><g:formatNumber number="${detail.totalLinearFt()}" type="number"/></td>
                <td><g:formatNumber number="${detail.qtyCompleted()}" type="number" maxFractionDigits="0" minFractionDigits="0"/></td>
                <td><g:formatNumber number="${detail.totalCompletedLnFt()}" type="number" maxFractionDigits="2" minFractionDigits="0"/></td>
                <td>
                    <g:if test="${detail.highScaffold}">
                        <g:message code="default.booleanYes.text"/>
                    </g:if>
                    <g:else>
                        <g:message code="default.booleanNo.text"/>
                    </g:else>
                </td>
                <td style="text-align: center">
                    <a href="#" title="${g.message(code:'default.addWorkDetail.title')}" onclick="addWorkDetail(${detail.id});"><asset:image src="/icons/worker.png" width="20px" height="20px"/></a>
                </td>
            </tr>

            </g:each>
        </tbody>
    </table>

<g:if test="${siteReport?.id}">
    <g:set var="wd" value="${jobreport.WorkDetailsCompleted.findAllBySiteReport(siteReport).size()}"/>
</g:if>
<g:else>
    <g:set var="wd" value="0"/>
</g:else>
<script>var workDetailsCounter = ${wd};</script>