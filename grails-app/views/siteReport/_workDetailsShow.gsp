<%@ page import="jobreport.WorkDetailsCompleted" %>
<table class="contentframework">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.workType.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.quantity.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.width.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.length.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.wetGlaze.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.gullWing.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.frameGuard.label"/></th>
        </tr>
        <g:each var="detail" in="${jobReport.workDetails}" status="i">
        <tr class="subcopy">
            <td><g:fieldValue field="workTypes"     bean="${detail}" /></td>
            <td><g:fieldValue field="quantity"      bean="${detail}" /></td>
            <td><g:fieldValue field="width"         bean="${detail}" /></td>
            <td><g:fieldValue field="length"        bean="${detail}" /></td>
            <td><g:fieldValue field="wetGlaze"      bean="${detail}" /></td>
            <td><g:fieldValue field="gullWing"      bean="${detail}" /></td>
            <td><g:fieldValue field="frameGuard"    bean="${detail}" /></td>
        </tr>
        <tr>
            <td colspan="8">
                <fieldset>
                    <legend><g:fieldValue field="workTypes" bean="${detail}" /> - <g:fieldValue field="quantity" bean="${detail}" /> (<g:fieldValue field="width" bean="${detail}" /> X <g:fieldValue field="length" bean="${detail}" />)</legend>
                    <table id="workDetailsTable${i}" style="width: 100%;">
                        <tbody>
                        <tr class="subcopy">
                            <th class="contentframework-formdatalabel"><strong><g:message code="fieldTeam.fieldAgent.title" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.quantity.label" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.dateComplete.label" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.psfRate.label" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.plfRate.label" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.notes.label" /></strong></th>
                        </tr>
                        <g:set var="workCompletedList" value="${jobreport.WorkDetailsCompleted.findAllBySiteReportAndWorkDetails(siteReport, detail)}"/>
                            <g:each var="workCompleted" in="${workCompletedList}" status="j">
                            <tr class="subcopy">
                                <td class="contentframework-formdatalabel"><g:fieldValue bean="${workCompleted}" field="worker" /></td>
                                <td class="contentframework-formdatalabel"><g:fieldValue bean="${workCompleted}" field="qtyCompleted"/></td>
                                <td class="contentframework-formdatalabel"><g:formatDate date="${workCompleted.dateCompleted}" style="medium" type="date"/></td>
                                <td class="contentframework-formdatalabel"><g:textField class="contentframework-textfield"
                                                                                        name="psfRate"
                                                                                        value="${workCompleted?.psfRate}"
                                                                                        onchange="updatePsfPlfRate(${workCompleted?.id}, \$(this), 'psfRate')"/>&nbsp;
                                    <span id="statusIndicator_psfRate_${workCompleted?.id}"></span>
                                </td>
                                <td class="contentframework-formdatalabel"><g:textField class="contentframework-textfield"
                                                                                        name="plfRate"
                                                                                        value="${workCompleted?.plfRate}"
                                                                                        onchange="updatePsfPlfRate(${workCompleted?.id}, \$(this), 'plfRate')"/>&nbsp;
                                    <span id="statusIndicator_plfRate_${workCompleted?.id}"></span>
                                </td>
                                <td class="contentframework-formdatalabel"><g:fieldValue bean="${workCompleted}" field="notes"/></td>
                            </tr>
                            </g:each>
                        </tbody>
                    </table>
                </fieldset>
            </td>
        </tr>
        </g:each>
    </tbody>
</table>
