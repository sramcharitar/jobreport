    <g:if test="${!jobReport.isPayrollComplete}">
    <table class="contentframework">
        <body>
        <tr>
            <g:if test="${!jobReport.isCompleted}">
            <td class="contentframework-formdatalabel">
                <strong><g:message code="siteReport.allowFieldAgents.label"/>:</strong>
                <g:checkBox name="isReadyForInstaller"
                            value="true"
                            checked="${jobReport?.isReadyForInstaller}"
                            onclick="setInstallerAccess(${jobReport.id})"/>
            </td>
            </g:if>
            <td class="contentframework-formdatalabel">
                <strong><g:message code="jobReport.completion.label"/>:</strong>
                <g:radio   name="isCompleted"
                           value="true"
                           checked="${jobReport?.isCompleted}"
                           onclick="setJobStatus(${jobReport.id}, true)"/>
                <g:message code="default.boolean.true"/>&nbsp;
                <g:radio   name="isCompleted"
                           value="false"
                           checked="${!jobReport?.isCompleted}"
                           onclick="setJobStatus(${jobReport.id}, false)"/>
                <g:message code="default.boolean.false"/>
            </td>
        </tr>
        </body>
    </table>
    </g:if>