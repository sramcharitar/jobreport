    <div class="clear">
    <table class="contentframework">
        <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><a href="/siteReport/index?sort=dateCreated&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                           title="${g.message(code:'default.dateCreated.title')}"
                           class="linkedtextandicon">
                    <span><g:message code="default.dateCreated.title" /></span>
                    <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
                </a>
                </strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><a href="/siteReport/index?sort=lastUpdated&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                           title="${g.message(code:'default.lastUpdated.title')}"
                           class="linkedtextandicon">
                    <span><g:message code="default.lastUpdated.title" /></span>
                    <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
                </a>
                </strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><a href="/siteReport/index?sort=model.client.name&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                           title="${g.message(code:'projectSummary.workOrderNumber.title')}"
                           class="linkedtextandicon">
                    <span><g:message code="projectSummary.workOrderNumber.title" /></span>
                    <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
                </a>
                </strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><a href="/siteReport/index?sort=model.description&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                           title="${g.message(code:'projectSummary.jobName.title')}"
                           class="linkedtextandicon">
                    <span><g:message code="jobReport.clientName.label" /></span>
                    <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
                </a>
                </strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><a href="#">
                    <span><g:message code="siteReport.status.label" /></span>
                    <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
                </a>
                </strong>
            </th>
            <g:if test="${!jobReport.isCompleted}">
            <th class="contentframework-dataheadertop" scope="col">
                <strong><a href="#">
                    <span title="<g:message code="siteReport.payrollApproval.label" />"><g:message code="siteReport.ap.label" /></span>
                    <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
                </a>
                </strong>
            </th>
            </g:if>
        </tr>
        <g:each var="report" in="${jobReport?.siteReport}">
            <tr class="subcopy">
                <td class="contentframework-formdatalabel" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/siteReport?id=${report?.id}');">
                    <g:formatDate date="${report?.dateCreated}" type="date" style="medium"></g:formatDate>
                </td>
                <td class="contentframework-formdatalabel" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/siteReport?id=${report?.id}');">
                    <g:formatDate date="${report?.lastUpdated}" type="date" style="medium"/>
                </td>
                <td class="contentframework-formdatalabel" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/siteReport?id=${report?.id}');">
                    <g:fieldValue field="workOrderNumber" bean="${jobReport}"/>
                </td>
                <td class="contentframework-formdatalabel" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/siteReport?id=${report?.id}');">
                    <g:fieldValue field="client.name" bean="${jobReport}"/>
                </td>
                <td class="contentframework-formdatalabel" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/siteReport?id=${report?.id}');">
                    ${jobreport.SiteReportStatus.findByStatusEnum(report.statusEnum)}
                </td>
                <g:if test="${!jobReport.isCompleted}">
                <td class="contentframework-formdatalabel" onmouseover="$(this).css('cursor','pointer');">
                    <g:checkBox name="isApprovedForPayroll" value="true" checked="${report?.isApprovedForPayroll}" onclick="setPayrollApproval(${report?.id}, \$(this).prop('checked'));"/>
                </td>
                </g:if>
            </tr>
        </g:each>
        </tbody>
    </table>
    </div>


