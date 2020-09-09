<%@ page import="jobreport.Role" %>
<table class="contentframework">
    <tbody>
        <tr>
            <th colspan="2" class="contentframework-dataheadertop" scope="col">
                <div><strong><g:message code="jobReport.jobInformation.title" /></strong></div>
            </th>
        </tr>
        <tr>
            <td>
                <fieldset>
                    <legend><g:message code="jobReport.jobInformation.title"/></legend>
                    <table class="contentframework" style="width: 100%">
                        <colgroup>
                            <col style="width: 27.5%;">
                            <col style="width: 45%;">
                            <col style="width: 27.5%;">
                        </colgroup>
                        <tbody>
                        <tr>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="workOrderNumber"><g:message code="jobReport.workOrderNumber.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="jobName"><g:message code="jobReport.jobName.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="salesRep"><g:message code="jobReport.salesRep.label"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'workOrderNumber','contentframework-required-highlight')}"
                                        name="workOrderNumber"
                                        value="${jobReport?.workOrderNumber}"
                                        size="22"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'jobName','contentframework-required-highlight')}"
                                        name="jobName"
                                        value="${jobReport?.jobName}"
                                        size="40"/>
                            </td>
                            <td>
                                <g:select
                                        class="contentframework-select ${hasErrors(bean:jobReport, field:'salesRep','contentframework-required-highlight')}"
                                        name="salesRep"
                                        from="${jobreport.ChbUsersRole.findAllByRole(jobreport.Role.findByAuthority("ROLE_SALES")).chbUsers}"
                                        value="${jobReport?.salesRep?.id}"
                                        optionKey="id"/>
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
                    <legend><g:message code="jobReport.jobInformation.title"/></legend>
                    <table class="contentframework">
                        <tbody>
                        <tr>
                            <td class="contentframework-formdatalabel" colspan="4">
                                <label for="sameAsClient">
                                    <g:message code="location.sameAsClient.label"/>: <g:checkBox name="sameAsClient" value="true" checked="false" onclick="setLocationAddress(\$(this))"/>
                                </label>
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
                    <legend><g:message code="jobReport.jobInformation.title"/></legend>
                    <table class="contentframework" style="width: 100%;">
                        <colgroup>
                            <col style="width: 35%;">
                            <col style="width: 35%;">
                            <col style="width: 10%;">
                            <col style="width: 20%;">
                        </colgroup>
                        <tbody>
                        <tr>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="jobLocation.street"><g:message code="location.street.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="jobLocation.city"><g:message code="location.city.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="jobLocation.state"><g:message code="location.state.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="jobLocation.zipcode"><g:message code="location.zipcode.label"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'jobLocation.street','contentframework-required-highlight')}"
                                        name="jobLocation.street"
                                        value="${jobReport?.jobLocation?.street}"
                                        size="30"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'jobLocation.city','contentframework-required-highlight')}"
                                        name="jobLocation.city"
                                        value="${jobReport?.jobLocation?.city}"
                                        size="30"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'jobLocation.state','contentframework-required-highlight')}"
                                        name="jobLocation.state"
                                        value="${jobReport?.jobLocation?.state}"
                                        size="5"
                                        maxlength="2"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'jobLocation.zipcode','contentframework-required-highlight')}"
                                        name="jobLocation.zipcode"
                                        value="${jobReport?.jobLocation?.zipcode}"
                                        size="10"
                                        maxlength="5"
                                        onkeypress="return wholeNumbersOnlyNoComma(event)"/>
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
                    <legend><g:message code="jobReport.jobInformation.title"/></legend>
                    <table class="contentframework">
                        <tbody>
                        <tr>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="jobDescription"><g:message code="jobReport.jobDescription.label"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <g:textArea
                                        class="contentframework-textarea ${hasErrors(bean:jobReport, field:'jobDescription','contentframework-required-highlight')}"
                                        name="jobDescription"
                                        cols="75"
                                        rows="4"><g:fieldValue field="jobDescription" bean="${jobReport}"/></g:textArea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </fieldset>
            </td>
        </tr>
    </tbody>
</table>

