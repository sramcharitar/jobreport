<g:uploadForm name="attachment" url="[controller:'siteReport', action:'upload']">
    <table class="w3-table-all">
        <tbody>
        <tr>
            <td>
                <g:hiddenField name="id" value="${siteReport.id}"/>
                <strong><g:message code="document.image.title"/>:</strong> <input type="file" name="attachments" multiple="true" size="50"/>
            </td>
            <td>
                <div style="float: right">
                    <span>
                        <button class="w3-button w3-blue" type="submit">
                            <g:message code="document.upload.label" />
                        </button>
                    </span>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</g:uploadForm>

<table class="w3-table-all">
    <thead>
    <tr>
        <th scope="col">
            <strong>
                <span><g:message code="default.dateCreated.title" /></span>
            </strong>
        </th>
        <th scope="col">
            <strong>
                <span><g:message code="document.name.title" /></span>
            </strong>
        </th>
        <th scope="col">
            <strong>
                <span><g:message code="document.type.title" /></span>
            </strong>
        </th>
        <th scope="col">
            <strong>
                <span><g:message code="document.size.title" /></span>
            </strong>
        </th>
        <th scope="col"></th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <g:each var="document" in="${siteReport?.siteImages}">
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
            <td style="width:20px">
                <i class="fa fa-arrow-circle-o-down" style="font-size:24px" onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/siteReport/downloadDoc?id=${document.id}','_blank');"></i>
            </td>
            <td style="width:20px">
                <i class="fa fa-trash" style="font-size:24px" onmouseover="$(this).css('cursor','pointer');" onclick="$(location).prop('href', '/siteReport/deleteDocument?id=${document.id}');"></i>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
