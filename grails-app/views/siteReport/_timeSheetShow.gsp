
<table id="timeSheetTable" class="contentframework" style="width:100%;">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th nowrap="true" class="contentframework-dataheadertop" scope="col" colspan="4">
                <div style="float:left;"><strong><g:message code="tab.timeSheet.label" /></strong></div>
            </th>
        </tr>
        <tr>
            <th nowrap="true" class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.fieldAgent.title"/></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="timeSheet.startDateTime.label" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="timeSheet.endDateTime.label" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="timeSheet.hourlyRate.label" /></strong>
            </th>
        </tr>
        <g:each var="item" status="i" in="${siteReport?.timeSheet}">
            <g:render template="/siteReport/timeLogShow" model="${[i:i, jobReport:jobReport, item:item]}"/>
        </g:each>
    </tbody>
</table>