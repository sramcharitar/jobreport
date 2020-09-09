
<table class="w3-table-all">
    <thead>
    <tr>
        <th scope="col">
            <div><strong><g:message code="siteReport.signOff.title" /></strong></div>
        </th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>
                <table class="w3-table-all" style="width:100%;">
                    <colgroup>
                        <col width="30%">
                        <col width="30%">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <td>
                            <strong><g:message code="jobReport.clientName.label"/></strong>
                        </td>
                        <td>
                            <strong><g:message code="siteReport.clientAgent.label"/></strong>
                        </td>
                        <td>
                            <strong><g:message code="siteReport.jobAddress.label"/></strong>
                        </td>
                    </tr>
                    <tr>
                        <td>${jobReport?.client}</td>
                        <td>${jobReport?.client?.contact}</td>
                        <td>${jobReport?.jobLocation}</td>
                    </tr>
                    </tbody>
                </table>
        </td>
    </tr>
    <tr>
        <td>
                <table class="w3-table-all" style="width: 100%">
                    <colgroup>
                        <col style="width:60%;">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <td>
                            <strong><g:message code="jobReport.jobDescription.label"/></strong>
                        </td>
                        <td>
                            <label><strong><g:message code="siteReport.workCompletionDate.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td>${jobReport.jobDescription}</td>
                        <td>
                            <g:textField class="w3-input" name="workCompletionDate" value="${siteReport?.workCompletionDate ?:new Date()}" />
                            <script>jQuery('#workCompletionDate').datetimepicker({value:'${formatDate(date:siteReport?.workCompletionDate ?:new Date(), type:'date', style: 'medium')}', format:'m/d/Y', timepicker:false, step:60});</script>
                        </td>
                    </tr>
                    </tbody>
                </table>
        </td>
    </tr>
    <tr>
        <td>
                <table class="w3-table-all" style="width: 100%">
                    <tbody>
                    <tr>
                        <colgroup>
                            <col style="width:30%;">
                            <col style="width:30%;">
                            <col>
                        </colgroup>
                        <td>
                            <strong><g:message code="siteReport.workInspection.info"/></strong>
                        </td>
                        <td>
                            <strong><g:message code="siteReport.workSatisfaction.info"/></strong>
                        </td>
                        <td>
                            <label for="notes"><strong><g:message code="siteReport.notes.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><g:radio class="w3-radio" value="true" name="isWorkInspected" checked="${siteReport?.isWorkInspected}"/>: <g:message code="default.booleanYes.text"/></label>&nbsp;
                            <label><g:radio class="w3-radio" value="false" name="isWorkInspected" checked="${!siteReport?.isWorkInspected}"/>: <g:message code="default.booleanNo.text"/></label>
                        </td>
                        <td>
                            <g:radio class="w3-radio" value="true" name="isWorkSatisfactory" checked="${siteReport?.isWorkSatisfactory}"/>: <g:message code="default.booleanYes.text"/>&nbsp;
                            <g:radio class="w3-radio" value="false" name="isWorkSatisfactory" checked="${!siteReport?.isWorkSatisfactory}"/>: <g:message code="default.booleanNo.text"/>
                        </td>
                        <td>
                            <g:textArea class="w3-input" name="notes" value="${siteReport?.notes}" cols="50" rows="4"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
        </td>
    </tr>
    <tr>
        <td>
                <table class="w3-table-all" style="width: 100%">
                    <tbody>
                    <tr>
                        <colgroup>
                            <col style="width:30%;">
                            <col>
                        </colgroup>
                        <td>
                            <strong><g:message code="siteReport.jobCompletion.info"/></strong>
                        </td>
                        <td>
                            <strong><g:message code="siteReport.jobCompletionNo.info"/></strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label><g:radio class="w3-radio" value="true" name="isJobComplete" checked="${siteReport?.isJobComplete}"/>: <g:message code="default.booleanYes.text"/></label>&nbsp;
                            <label><g:radio class="w3-radio" value="false" name="isJobComplete" checked="${!siteReport?.isJobComplete}"/>: <g:message code="default.booleanNo.text"/></label>
                        </td>
                        <td>
                            <g:textArea class="w3-input" name="outstandingWork" value="${siteReport?.outstandingWork}" cols="60" rows="4"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
        </td>
    </tr>
    <tr>
        <td>
                <table class="w3-table-all" style="width: 100%">
                    <tbody>
                    <tr>
                        <colgroup>
                            <col>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <td>
                            <label for="statusEnum"><strong><g:message code="siteReport.status.label"/></strong></label>
                        </td>
                        <td>
                            <strong><g:message code="company.name.title"/></strong>
                        </td>
                        <td>
                            <label for="clientSignOffName"><strong><g:message code="siteReport.clientAgent.label"/></strong></label>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <g:select
                                    class="w3-select"
                                    from="${jobreport.SiteReportStatus.all}"
                                    name="statusEnum"
                                    optionKey="statusEnum"
                                    value="${siteReport?.statusEnum}"/>
                        </td>
                        <td>
                            ${jobReport.getTeamLeader()}
                        </td>
                        <td>
                            <g:textField class="w3-input" name="clientSignOffName" value="${siteReport?.clientSignOffName}" />
                        </td>
                        <td>
                            <a href="#" onclick="sigPanelShow()"><i class="fa fa-pencil-square-o" style="font-size:24px"></i></a>
                            <g:hiddenField name="clientSignatureString" value="${siteReport?.clientSignatureString}"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <div>
                                <div id="sigPanel" style="display: none;">
                                    <div id="sig-panel" style="width: 500px; height: 300px; border: 1px solid gray; float: left;"></div>
                                </div>
                                <div id="sigDisplay">
                                    <canvas id="my-target" height="300" width="500" style="border: 1px solid gray;"></canvas>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
        </td>
    </tr>
    </tbody>
</table>

<script type="text/javascript">
    $(document).ready(function() {

        <g:if test="${siteReport?.clientSignatureString}">
        sig_data = JSON.parse($("#clientSignatureString").val());
        $("#my-target").signaturePanel("drawClickstreamToCanvas", sig_data);
        setTimeout(function (){ $("#my-target").signaturePanel("drawClickstreamToCanvas", sig_data);
            console.log("Load completed...");}, 5000);
        </g:if>
    });
    var sig_data;
</script>