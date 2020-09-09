
<table class="w3-table-all w3-hoverable">
    <thead>
        <tr class="w3-dark-grey">
            <th nowrap="true">
                <strong><g:message code="rider.installationDate.label" /></strong>
            </th>
            <th nowrap="true">
                <strong><g:message code="projectSummary.workOrderNumber.title" /></strong>
            </th>
            <th nowrap="true">
                <strong><g:message code="projectSummary.jobName.title" /></strong>
            </th>
            <th nowrap="true">
                <strong><g:message code="siteReport.jobAddress.label" /></strong>
            </th>
            <th nowrap="true">
                <strong><g:message code="default.lastUpdated.title" /></strong>
            </th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    <g:each var="report" in="${siteReportList}">
        <tr>
            <td nowrap="true" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:formatDate date="${report.rider.installationDate}" type="date" style="medium"/>
            </td>
            <td nowrap="true" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:fieldValue field="workOrderNumber" bean="${report}"/>
            </td>
            <td nowrap="true" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:fieldValue field="jobName" bean="${report}"/>
            </td>
            <td nowrap="true" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:fieldValue field="client.address.street" bean="${report}"/>
            </td>
            <td nowrap="true" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:formatDate date="${report.lastUpdated}" type="date" style="medium"/>
            </td>
            <td>
                <a href="/siteReport/show?id=${report.id}"><i class="fa fa-folder-open-o" style="font-size:24px"></i></a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
