    <div class="clear">
    <table class="contentframework">
        <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><a href="/siteReport/index?sort=dateCreated&max=20&order=${params.order=='asc'?'desc':'asc'}&img=${params.img=='up'?'down':'up'}"
                           title="${g.message(code:'siteReport.dateComplete.label')}"
                           class="linkedtextandicon">
                    <span><g:message code="siteReport.dateComplete.label" /></span>
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
            <th class="contentframework-dataheadertop" scope="col"></th>
        </tr>
        <g:each var="report" in="${jobReport?.siteReport}">
            <tr class="subcopy">
                <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                    <g:formatDate date="${report?.workCompletionDate}" type="date" style="medium"></g:formatDate>
                </td>
                <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                    <g:formatDate date="${report?.lastUpdated}" type="datetime" style="medium"/>
                </td>
                <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                    <g:fieldValue field="workOrderNumber" bean="${jobReport}"/>
                </td>
                <td onmouseover="$(this).css('cursor','pointer');" onclick="$(location).attr('href','/siteReport/edit?id=${report?.id}');">
                    <g:fieldValue field="client.name" bean="${jobReport}"/>
                </td>
                <td onmouseover="$(this).css('cursor','pointer');" style="text-align: center">
                    <asset:image src="/icons/delete.png"
                                 alt="${g.message(code:'default.button.delete.label')}"
                                 title="${g.message(code:'default.button.delete.label')} ${jobReport?.workOrderNumber} ${jobReport?.client?.name}"
                                 style="width: 20px;height: 20px;"
                                 onclick="deleteSiteReport(${report?.id});"/>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    </div>


