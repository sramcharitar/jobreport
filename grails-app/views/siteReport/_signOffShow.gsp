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
                            <label><strong><g:message code="jobReport.clientName.label"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.clientAgent.label"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.jobAddress.label"/></strong></label>
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
                    <tbody>
                    <tr>
                        <colgroup>
                            <col style="width:60%;">
                            <col>
                        </colgroup>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="jobReport.jobDescription.label"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.workCompletionDate.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">${jobReport.jobDescription}</td>
                        <td class="contentframework-formdatalabel">
                            <g:formatDate date="${siteReport?.workCompletionDate}" type="date" style="medium" />
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
                            <label><strong><g:message code="siteReport.workInspection.info"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.workSatisfaction.info"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.notes.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <g:if test="${siteReport?.isJobComplete}">
                                <g:message code="default.booleanYes.text"/>
                            </g:if>
                            <g:else>
                                <g:message code="default.booleanNo.text"/>
                            </g:else>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <g:if test="${siteReport?.isWorkSatisfactory}">
                                <g:message code="default.booleanYes.text"/>
                            </g:if>
                            <g:else>
                                <g:message code="default.booleanNo.text"/>
                            </g:else>
                        </td>
                        <td class="contentframework-formdatalabel">
                            ${siteReport?.notes}
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
                            <label><strong><g:message code="siteReport.jobCompletion.info"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.jobCompletionNo.info"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <g:if test="${siteReport?.isJobComplete}">
                                <g:message code="default.booleanYes.text"/>
                            </g:if>
                            <g:else>
                                <g:message code="default.booleanNo.text"/>
                            </g:else>
                       </td>
                        <td class="contentframework-formdatalabel">
                            ${siteReport?.outstandingWork}
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
                            <label><strong><g:message code="siteReport.status.label"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="company.name.title"/></strong></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label><strong><g:message code="siteReport.clientAgent.label"/></strong></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            ${jobreport.SiteReportStatus.findByStatusEnum(siteReport?.statusEnum)}
                        </td>
                        <td class="contentframework-formdatalabel">
                            ${jobReport.getTeamLeader()}
                        </td>
                        <td class="contentframework-formdatalabel">
                            ${siteReport?.clientSignOffName}
                        </td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
        <tr>
            <td>
                <div>
                    <div id="sigDisplay">
                        <canvas id="sigPanel" height="300" width="500" style="border: 1px solid gray;"></canvas>
                        <g:hiddenField name="clientSignatureString" value="${siteReport?.clientSignatureString}"/>
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>
<script type="text/javascript">

    $(document).ready(function() {
        var sig_data;
        <g:if test="${siteReport?.clientSignatureString}">
            sig_data = JSON.parse($("#clientSignatureString").val());
            //console.log(sig_data);
            $("#sigPanel").signaturePanel("drawClickstreamToCanvas", sig_data);
            setInterval(
                function (){
                    $("#sigPanel").signaturePanel("drawClickstreamToCanvas", sig_data);
                    //console.log("Load completed...");
                },
                5000
            );
        </g:if>
    });
</script>