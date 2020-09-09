<table class="contentframework">
    <tbody class="contentframework-stripedtable">
    <tr>
        <th class="contentframework-dataheadertop" scope="col" colspan="${isCompleted?5:6}">
            <g:if test="${!isCompleted}">
                <strong><g:message code="jobReport.pendingJobs.title"/></strong>
            </g:if>
            <g:else>
                <strong><g:message code="jobReport.completedJobs.title"/></strong>
            </g:else>
        </th>
    </tr>
    <tr>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/jobReport/index?sort=rider.installationDate&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'rider.installationDate.label')}"
                       class="linkedtextandicon">
                <span><g:message code="rider.installationDate.label" /></span>
                <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/jobReport/index?sort=model.client.name&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'projectSummary.workOrderNumber.title')}"
                       class="linkedtextandicon">
                <span><g:message code="projectSummary.workOrderNumber.title" /></span>
                <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/jobReport/index?sort=model.description&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'projectSummary.jobName.title')}"
                       class="linkedtextandicon">
                <span><g:message code="projectSummary.jobName.title" /></span>
                <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/jobReport/index?sort=client.address.street&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'default.dateCreated.title')}"
                       class="linkedtextandicon">
                <span><g:message code="siteReport.jobAddress.label" /></span>
                <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/jobReport/index?sort=lastUpdated&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'default.lastUpdated.title')}"
                       class="linkedtextandicon">
                <span><g:message code="default.lastUpdated.title" /></span>
                <asset:image src="contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>

        <sec:ifAnyGranted roles='ROLE_PROJECT_MANAGER'>
            <g:if test="${!isCompleted}">
                <th class="contentframework-dataheadertop" scope="col"></th>
            </g:if>
        </sec:ifAnyGranted>

    </tr>
    <g:each var="report" in="${reportList}">
        <tr class="subcopy">
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/show?id=${report.id}');">
                <span style="background-color:  ${report?.salesRep?.color?:''}; width: 15px" title="${g.message(code: 'jobReport.salesAgent.name', args: [report?.salesRep])}">&nbsp;</span>
                <span><g:formatDate date="${report?.rider?.installationDate}" type="date" style="medium"/></span>
                <g:if test="${!isCompleted}">
                    <g:set var="isJobCompleted" value="${report?.siteReport?.find{it?.isJobComplete}}"/>
                    <g:if test="${isJobCompleted}">
                        <span> - </span>
                        <span style="color: green" title="${g.message(code: 'jobReport.completed.title', args: [report?.siteReport?.size(), report?.siteReport?.size()>1?'s':'', report?.siteReport?.findAll{it.isApprovedForPayroll}?.size(), report?.siteReport?.size()])}">
                            <g:message code="jobReport.jobCompleted.status"/>
                        </span>
                    </g:if>
                    <g:else>
                        <g:if test="${report?.siteReport?.size()>0}">
                            <span> - </span><span style="color: orange" title="${g.message(code: 'jobReport.pendingCompletion.title', args: [report?.siteReport?.size(), report?.siteReport?.size()>1?'s':'', report?.siteReport?.findAll{it.isApprovedForPayroll}?.size(), report?.siteReport?.size()])}">
                            <g:message code="jobReport.pending.status"/> (${report?.siteReport?.size()})</span>
                        </g:if>
                    </g:else>
                </g:if>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/show?id=${report.id}');">
                <g:fieldValue field="workOrderNumber" bean="${report}"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/show?id=${report.id}');">
                <g:fieldValue field="jobName" bean="${report}"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/show?id=${report.id}');">
                <g:fieldValue field="client.address.street" bean="${report}"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/jobReport/show?id=${report.id}');">
                <g:formatDate date="${report.lastUpdated}" type="date" style="medium"/>
            </td>
            <sec:ifAnyGranted roles='ROLE_PROJECT_MANAGER'>
                <g:if test="${!isCompleted}">
                    <td id="teamComponent_${report?.id}" title="${g.message(code: 'jobReport.fieldTeam.size', args: [report.fieldTeam.size() == 0 ? 'No' : report.fieldTeam.size()])}">
                        <g:if test="${report.fieldTeam.size()}">
                            <a href="#" id="quickAccess" onclick="teamConfig(${report.id}, event)"><asset:image src="/icons/team.png" width="20px" height="20px"/></a>
                        </g:if>
                        <g:else>
                            <a href="#" id="quickAccess" onclick="teamConfig(${report.id}, event)"><asset:image src="/icons/no_member.png" width="20px" height="20px"/></a>
                        </g:else>
                    </td>
                </g:if>
            </sec:ifAnyGranted>
        </tr>
    </g:each>
    </tbody>
</table>