<table class="w3-table">
    <tbody>
    <tr>
        <td>
            <div style="float: right;">
                <button class="w3-button w3-blue" type="button" onclick="$(location).attr('href', '${createLink(controller:'siteReport', action: 'create', id:jobReport.id)}')">
                    <g:message code="default.button.createSiteReport.label" />
                    <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" />
                </button>
            </div>
        </td>
    </tr>
    </tbody>
</table>
<table class="w3-table-all">
    <thead>
        <tr class="w3-light-grey">
            <th><strong><g:message code="default.dateCreated.title" /></strong></th>
            <th><strong><g:message code="default.lastUpdated.title" /></strong></th>
            <th><strong><g:message code="projectSummary.workOrderNumber.title" /></strong></th>
            <th><strong><g:message code="jobReport.clientName.label" /></strong></th>
            <th style="width: 28px;"></th>
            <th style="width: 28px;"></th>
        </tr>
    </thead>
    <tbody>
     <g:each var="report" in="${jobReport?.siteReport}">
        <tr>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                <g:formatDate date="${report?.dateCreated}" type="datetime" style="short"></g:formatDate>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                <g:formatDate date="${report?.lastUpdated}" type="datetime" style="short"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                <g:fieldValue field="workOrderNumber" bean="${jobReport}"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                <g:fieldValue field="client.name" bean="${jobReport}"/>
            </td>
            <td><a href="/siteReport/edit?id=${report?.id}"><i class="fa fa-edit" style="font-size:24px"></i></a></td>
            <td><a href="deleteSiteReport(${report?.id});"><i class="fa fa-trash" style="font-size:24px"></i></a></td>
        </tr>
    </g:each>
    </tbody>
</table>


