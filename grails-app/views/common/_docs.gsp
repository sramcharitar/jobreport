<g:if test="${!jobReport.isCompleted}">
<g:uploadForm name="attachment" url="[controller:'jobReport', action:'upload']">
    <table class="contentframework">
        <tbody>
            <tr>
                <td>
                    <g:hiddenField name="jobReport.id" value="${jobReport.id}"/>
                    <g:message code="document.upload.title"/>: <input type="file" name="attachments" multiple="true" size="50"/>
                </td>
                <td>
                    <div class="contentframework" style="float: right">
                    <span class="button button-secondary">
                        <span>
                            <button type="submit">
                                <g:message code="document.upload.label" />
                            </button>
                        </span>
                    </span>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</g:uploadForm>
</g:if>

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
        <th class="contentframework-dataheadertop" scope="col">

        </th>
    </tr>
    <g:each var="document" in="${jobReport?.jobDocs}">
        <tr class="subcopy">
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/jobReport/downloadDoc?id=${document.id}','_blank');">
                <g:formatDate date="${document.dateCreated}" type="date" style="medium"/>
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/jobReport/downloadDoc?id=${document.id}','_blank');">
                ${document}
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/jobReport/downloadDoc?id=${document.id}','_blank');">
                ${document.fileExtension()}
            </td>
            <td onmouseover="$(this).css('cursor','pointer');" onclick="window.open('/jobReport/downloadDoc?id=${document.id}','_blank');">
                <g:formatNumber type="number" number="${document.doc.size() ? document.doc.size()/1024 : 0}" minFractionDigits="0" maxFractionDigits="0" groupingUsed="true"/>kb
            </td>
            <td style="width:20px">
                <asset:image src="icons/delete.png"
                             style="width:16px;height:16px;"
                             onmouseover="\$(this).css('cursor','pointer');"
                             onclick="\$(location).prop('href', '/jobReport/deleteDocument?id=${document.id}');" />
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
