
<table class="contentframework">
    <tbody>
    <tr>
        <th colspan="2" class="contentframework-dataheadertop" scope="col">
            <div><strong><g:message code="jobReport.projectRider.title" /></strong></div>
        </th>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="jobReport.clientInformation.title"/></legend>
                <table class="contentframework" style="width:100%;">
                    <tbody>
                    <colgroup>
                        <col style="width: 25%;">
                        <col style="width: 25%;">
                        <col style="width: 25%;">
                        <col>
                    </colgroup>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.salesRep.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.workOrderNumber.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="rider.measuredBy.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="rider.measurementDate.label"/></td>
                    </tr>
                    <tr class="subcopy">
                        <td><g:fieldValue field="salesRep" bean="${jobReport}"/></td>
                        <td><g:fieldValue field="workOrderNumber" bean="${jobReport}"/></td>
                        <td><g:fieldValue field="rider.measuredBy" bean="${jobReport}"/></td>
                        <td><g:formatDate date="${jobReport.dateCreated}" type="date" style="LONG"/></td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="jobReport.clientInformation.title"/></legend>
                <table class="contentframework" style="width:100%;">
                    <tbody>
                    <tr class="subcopy">
                        <td>
                            <p style="text-indent:25px">
                                <g:message code="rider.introduction.info" args="${[formatDate(date:jobReport.dateCreated, type: 'date', style: 'LONG')]}"/>
                            </p>
                            <p style="text-indent:25px">
                                <g:message code="rider.agreementList.info"/>
                            </p>
                            <p style="text-indent:25px">
                                <ol style="padding-left: 50px;">
                                    <li style="margin:10px 0px;"><strong><g:message code="jobReport.clientName.label"/>:</strong>&nbsp;&nbsp;<g:fieldValue field="client" bean="${jobReport}"/></li>
                                    <li style="margin:10px 0px;"><g:message code="rider.point1.info"/>&nbsp;&nbsp;<g:fieldValue field="jobLocation" bean="${jobReport}"/></li>
                                    <li style="margin:10px 0px;"><g:message code="rider.point2.info"/>&nbsp;&nbsp;${jobReport.getTeamLeader() ?: "TBD"}&nbsp;&nbsp;<g:message code="rider.chbCrew.info"/>&nbsp;&nbsp;${jobReport.fieldTeam ?: "TBD"}</li>
                                    <li style="margin:10px 0px;"><g:message code="rider.point3.info"/>&nbsp;&nbsp;${jobReport?.client?.contact},&nbsp;${jobReport?.client?.contact?.email}, &nbsp;${jobReport?.client?.contact?.phone}</li>
                                    <li style="margin:10px 0px;"><g:message code="rider.point4.info"/>&nbsp;&nbsp;<g:formatDate date="${jobReport?.rider?.installationDate}" type="DATE" style="LONG"/></li>
                                    <li style="margin:10px 0px;"><g:message code="rider.point5.info"/>&nbsp;&nbsp;${jobReport?.fieldTeam?.size() ?: "TBD"}</li>
                                    <li style="margin:10px 0px;"><g:message code="rider.point6.info"/>&nbsp;&nbsp;${jobReport?.rider?.specialInstructions}</li>
                                </ol>
                            </p>
                            <p style="text-indent:25px">
                                <g:message code="rider.final.info"/>
                            </p>
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
                <legend><g:message code="jobReport.clientInformation.title"/></legend>
                <table class="contentframework" style="width:100%;">
                    <tbody>
                    <colgroup>
                        <col style="width: 50%;">
                        <col>
                    </colgroup>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold; text-align: center">
                            <g:message code="company.name.title"/>
                        </td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold; text-align: center;">
                            <g:message code="fieldTeam.fieldTeam.title"/>
                        </td>
                    </tr>
                    <tr class="subcopy">
                        <td style="text-align: center;"><g:message code="rider.amFaName.info" args="${[jobReport.owner]}"/></td>
                        <td style="text-align: center;"><g:message code="rider.amFaName.info" args="${[jobReport.getTeamLeader() ?: "TBD"]}"/></td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    </tbody>
</table>

<table class="contentframework">
    <tbody>
    <tr>
        <th colspan="2" class="contentframework-dataheadertop" scope="col">
            <div><strong><g:message code="rider.careful.title" /></strong></div>
        </th>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="rider.careful.title"/></legend>
                <table class="contentframework" style="width:100%;">
                    <tbody>
                    <colgroup>
                        <col>
                    </colgroup>
                    <tr>
                        <td>
                            <p class="subcopy" style="text-indent:25px">
                                <g:message code="rider.siteCondition.info"/>
                            </p>
                            <p class="subcopy" style="text-indent:25px">
                                <g:message code="rider.picture.info"/>
                            </p>
                            <p class="subcopy" style="text-indent:25px">
                                <span style="text-decoration: underline; font-style: italic"><strong><g:message code="rider.important.info"/></strong></span>
                            </p>
                            <p class="subcopy" style="text-indent:25px">
                                <strong><g:message code="rider.workApproval.info"/></strong>
                            </p>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    </tbody>
</table>


