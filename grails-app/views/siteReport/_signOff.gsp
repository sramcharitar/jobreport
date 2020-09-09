<%@ page import="grails.converters.JSON" %>

<table class="contentframework">
    <tbody>
    <tr>
        <th class="contentframework-dataheadertop" scope="col">
            <div><strong><g:message code="siteReport.signOff.title" /></strong></div>
        </th>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="siteReport.signOff.title"/></legend>
                <table class="contentframework" style="width:100%;">
                    <colgroup>
                        <col width="30%">
                        <col width="30%">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="jobReport.clientName.label"/></strong>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="siteReport.clientAgent.label"/></strong>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="siteReport.jobAddress.label"/></strong>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">${jobReport?.client}</td>
                        <td class="contentframework-formdatalabel">${jobReport?.client?.contact}</td>
                        <td class="contentframework-formdatalabel">${jobReport?.jobLocation}</td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="siteReport.signOff.title"/></legend>
                <table class="contentframework" style="width: 100%">
                    <colgroup>
                        <col style="width:60%;">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="jobReport.jobDescription.label"/></strong>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.workCompletionDate.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">${jobReport.jobDescription}</td>
                        <td class="contentframework-formdatalabel">
                            <g:textField name="workCompletionDate" value="${siteReport?.workCompletionDate ?:new Date()}" />
                            <script>jQuery('#workCompletionDate').datetimepicker({value:'${formatDate(date:siteReport?.workCompletionDate ?:new Date(), type:'date', style: 'medium')}', format:'m/d/Y', step:60, timepicker:false});</script>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="siteReport.signOff.title"/></legend>
                <table class="contentframework" style="width: 100%">
                    <tbody>
                    <tr>
                        <colgroup>
                            <col style="width:30%;">
                            <col style="width:30%;">
                            <col>
                        </colgroup>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="siteReport.workInspection.info"/></strong>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="siteReport.workSatisfaction.info"/></strong>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label for="notes"><strong><g:message code="siteReport.notes.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <label><g:radio value="true" name="isWorkInspected" checked="${siteReport?.isWorkInspected}"/>: <g:message code="default.booleanYes.text"/></label>&nbsp;
                            <label><g:radio value="false" name="isWorkInspected" checked="${!siteReport?.isWorkInspected}"/>: <g:message code="default.booleanNo.text"/></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <g:radio value="true" name="isWorkSatisfactory" checked="${siteReport?.isWorkSatisfactory}"/>: <g:message code="default.booleanYes.text"/>&nbsp;
                            <g:radio value="false" name="isWorkSatisfactory" checked="${!siteReport?.isWorkSatisfactory}"/>: <g:message code="default.booleanNo.text"/>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <g:textArea name="notes" value="${siteReport?.notes}" cols="50" rows="4"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="siteReport.signOff.title"/></legend>
                <table class="contentframework" style="width: 100%">
                    <tbody>
                    <tr>
                        <colgroup>
                            <col style="width:30%;">
                            <col>
                        </colgroup>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="siteReport.jobCompletion.info"/></strong>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="siteReport.jobCompletionNo.info"/></strong>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <label><g:radio value="true" name="isJobComplete" checked="${siteReport?.isJobComplete}"/>: <g:message code="default.booleanYes.text"/></label>&nbsp;
                            <label><g:radio value="false" name="isJobComplete" checked="${!siteReport?.isJobComplete}"/>: <g:message code="default.booleanNo.text"/></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <g:textArea name="outstandingWork" value="${siteReport?.outstandingWork}" cols="60" rows="4"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="siteReport.signOff.title"/></legend>
                <table class="contentframework" style="width: 100%">
                    <tbody>
                    <tr>
                        <colgroup>
                            <col style="width:30%;">
                            <col style="width:30%;">
                            <col>
                        </colgroup>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label for="statusEnum"><strong><g:message code="siteReport.status.label"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <strong><g:message code="company.name.title"/></strong>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label for="clientSignOffName"><strong><g:message code="siteReport.clientAgent.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <g:select
                                    class=""
                                    from="${jobreport.SiteReportStatus.all}"
                                    name="statusEnum"
                                    optionKey="statusEnum"
                                    value="${siteReport?.statusEnum}"/>
                        </td>
                        <td class="contentframework-formdatalabel">
                            ${jobReport.getTeamLeader()}
                        </td>
                        <td class="contentframework-formdatalabel">
                            <g:textField name="clientSignOffName" value="${siteReport?.clientSignOffName}" size="40"/>&nbsp;
                            <a href="#" onclick="sigPanelShow()"><asset:image src="icons/drawing-tablet.png"/></a>
                            <g:hiddenField name="clientSignatureString" value="${siteReport?.clientSignatureString}"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td>
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

<script type="text/javascript">
    var sig_data;
    $(document).ready(function() {

       <g:if test="${siteReport?.clientSignatureString}">
        sig_data = JSON.parse($("#clientSignatureString").val());
        console.log(sig_data);
        $("#my-target").signaturePanel("drawClickstreamToCanvas", sig_data);
        setTimeout(
            function (){
                $("#my-target").signaturePanel("drawClickstreamToCanvas", sig_data);
                //console.log("Load completed...");
                },
            5000
        );
        </g:if>
    });
</script>