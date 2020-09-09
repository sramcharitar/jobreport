
<table class="contentframework">
    <tbody class="contentframework-stripedtable">
    <tr>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/siteReport/index?sort=rider.installationDate&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'rider.installationDate.label')}"
                       class="linkedtextandicon">
                <span><g:message code="rider.installationDate.label" /></span>
                <asset:image src="/contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/siteReport/index?sort=model.client.name&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'projectSummary.workOrderNumber.title')}"
                       class="linkedtextandicon">
                <span><g:message code="projectSummary.workOrderNumber.title" /></span>
                <asset:image src="/contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/siteReport/index?sort=model.description&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'projectSummary.jobName.title')}"
                       class="linkedtextandicon">
                <span><g:message code="projectSummary.jobName.title" /></span>
                <asset:image src="/contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/siteReport/index?sort=jobReport.client.address.street&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'siteReport.jobAddress.label')}"
                       class="linkedtextandicon">
                <span><g:message code="siteReport.jobAddress.label" /></span>
                <asset:image src="/contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><a href="/siteReport/index?sort=dateCreated&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                       title="${g.message(code:'default.lastUpdated.title')}"
                       class="linkedtextandicon">
                <span><g:message code="default.lastUpdated.title" /></span>
                <asset:image src="/contentframework/icon-order-${params.img}.gif" alt="" />
            </a>
            </strong>
        </th>
    </tr>
    <g:each var="report" in="${siteReportList}">
        <tr class="subcopy">
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:formatDate date="${report.rider.installationDate}" type="date" style="medium"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:fieldValue field="workOrderNumber" bean="${report}"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:fieldValue field="jobName" bean="${report}"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:fieldValue field="client.address.street" bean="${report}"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/show?id=${report.id}');">
                <g:formatDate date="${report.lastUpdated}" type="date" style="medium"/>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
