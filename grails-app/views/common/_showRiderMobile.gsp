<table class="w3-table-all">
    <thead>
    <tr class="w3-light-grey">
        <th><strong><g:message code="jobReport.salesRep.label"/></strong></th>
        <th><strong><g:message code="jobReport.workOrderNumber.label"/></strong></th>
        <th><strong><g:message code="rider.measuredBy.label"/></strong></th>
        <th><strong><g:message code="rider.measurementDate.label"/></strong></th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><g:fieldValue field="salesRep" bean="${jobReport}"/></td>
        <td><g:fieldValue field="workOrderNumber" bean="${jobReport}"/></td>
        <td><g:fieldValue field="rider.measuredBy" bean="${jobReport}"/></td>
        <td><g:formatDate date="${jobReport.dateCreated}" type="date" style="LONG"/></td>
    </tr>
    </tbody>
</table>

<p><g:message code="rider.introduction.info" args="${[formatDate(date:jobReport.dateCreated, type: 'date', style: 'LONG')]}"/></p>
<p><g:message code="rider.agreementList.info"/></p>
<p>
    <ul class="w3-ul w3-border">
        <li><strong><g:message code="jobReport.clientName.label"/>:</strong>&nbsp;&nbsp;<g:fieldValue field="client" bean="${jobReport}"/></li>
        <li><g:message code="rider.point1.info"/>&nbsp;&nbsp;<g:fieldValue field="jobLocation" bean="${jobReport}"/></li>
        <li><g:message code="rider.point2.info"/>&nbsp;&nbsp;${jobReport.getTeamLeader() ?: "TBD"}&nbsp;&nbsp;<g:message code="rider.chbCrew.info"/>&nbsp;&nbsp;${jobReport.fieldTeam ?: "TBD"}</li>
        <li><g:message code="rider.point3.info"/>&nbsp;&nbsp;${jobReport?.client?.contact},&nbsp;${jobReport?.client?.contact?.email}, &nbsp;${jobReport?.client?.contact?.phone}</li>
        <li><g:message code="rider.point4.info"/>&nbsp;&nbsp;<g:formatDate date="${jobReport?.rider?.installationDate}" type="DATE" style="LONG"/></li>
        <li><g:message code="rider.point5.info"/>&nbsp;&nbsp;${jobReport?.fieldTeam?.size() ?: "TBD"}</li>
        <li><g:message code="rider.point6.info"/>&nbsp;&nbsp;${jobReport?.rider?.specialInstructions}</li>
    </ul>
</p>
<p><g:message code="rider.final.info"/></p>

<table class="w3-table">
    <tbody>
    <tr>
        <td><g:message code="company.name.title"/></td>
        <td><g:message code="fieldTeam.fieldTeam.title"/></td>
    </tr>
    <tr>
        <td><g:message code="rider.amFaName.info" args="${[jobReport.owner]}"/></td>
        <td><g:message code="rider.amFaName.info" args="${[jobReport.getTeamLeader() ?: "TBD"]}"/></td>
    </tr>
    </tbody>
</table>

<p><g:message code="rider.siteCondition.info"/></p>
<p><g:message code="rider.picture.info"/></p>
<p><span style="text-decoration: underline; font-style: italic"><strong><g:message code="rider.important.info"/></strong></span></p>
<p><strong><g:message code="rider.workApproval.info"/></strong></p>