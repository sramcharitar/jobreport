<table class="w3-table-all w3-hoverable">
    <thead>
    <tr class="w3-dark-grey">
        <th nowrap="true">
            <strong>
                <span><g:message code="default.dateCreated.title" /></span>
            </strong>
        </th>
        <th nowrap="true">
            <strong>
                <span><g:message code="document.name.title" /></span>
            </strong>
        </th>
        <th nowrap="true">
            <strong>
                <span><g:message code="document.type.title" /></span>
            </strong>
        </th>
        <th nowrap="true">
            <strong>
                <span><g:message code="document.size.title" /></span>
            </strong>
        </th>
        <th></th>
    </tr>
    <g:each var="document" in="${jobReport?.jobDocs}">
        <tr>
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
            <td>
                <i class="fa fa-arrow-circle-o-down" style="font-size:24px" onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/siteReport/downloadDoc?id=${document.id}','_blank');"></i>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
