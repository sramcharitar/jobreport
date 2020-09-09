<table class="contentframework">
    <tbody class="contentframework-stripedtable">
    <tr>
        <th class="contentframework-dataheadertop" scope="col">
            <strong>
                <span><g:message code="default.dateCreated.title" /></span>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong>
                <span><g:message code="document.name.title" /></span>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong>
                <span><g:message code="document.type.title" /></span>
            </strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong>
                <span><g:message code="document.size.title" /></span>
            </strong>
        </th>
    </tr>
    <g:each var="document" in="${jobReport?.jobDocs}">
        <tr class="subcopy">
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/siteReport/downloadDoc?id=${document.id}','_blank');">
                <g:formatDate date="${document.dateCreated}" type="date" style="medium"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/siteReport/downloadDoc?id=${document.id}','_blank');">
                ${document}
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/siteReport/downloadDoc?id=${document.id}','_blank');">
                ${document.fileExtension()}
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/siteReport/downloadDoc?id=${document.id}','_blank');">
                <g:formatNumber type="number" number="${document.doc.size() ? document.doc.size()/1024 : 0}" minFractionDigits="0" maxFractionDigits="0" groupingUsed="true"/>kb
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
