<table class="contentframework">
    <tbody>
        <tr>
            <th colspan="2" class="contentframework-dataheadertop" scope="col">
                <div style="float:left;"><strong><g:message code="jobReport.jobDetails.title" /></strong></div>
                <div class="contentframework" style="float: right">
                    <span class="button button-secondary">
                        <span>
                            <button type="button" onclick="addJobDetails()">
                                <g:message code="default.button.add.label" />
                            </button>
                        </span>
                    </span>
                </div>
            </th>
        </tr>
        <tr>
            <td>
                <fieldset>
                    <legend><g:message code="jobReport.clientInformation.title"/></legend>
                    <table class="contentframework" id="workDetailsTable" style="width:100%;">
                        <tbody>
                            <colgroup>
                                <col style="width: 185px;">
                                <col style="width: 110px;">
                                <col style="width: 110px;">
                                <col style="width: 110px;">
                                <col style="width: 90px;">
                                <col style="width: 90px;">
                                <col>
                                <col style="width: 20px;">
                            </colgroup>
                            <tr>
                                <td class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                    <label for="workDetails[0].workTypes.id"><g:message code="jobReport.workType.label"/></label>
                                </td>
                                <td class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                    <label for="workDetails[0].quantity"><g:message code="jobReport.quantity.label"/></label>
                                </td>
                                <td nowrap="true" class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                    <label for="workDetails[0].width"><g:message code="jobReport.width.label"/></label> <span class="subcopy"><g:message code="default.inches.label"/></span>
                                </td>
                                <td nowrap="true" class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                    <label for="workDetails[0].length"><g:message code="jobReport.length.label"/></label> <span class="subcopy"><g:message code="default.feet.label"/></span>
                                </td>
                                <td class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                    <label for="workDetails[0].wetGlaze"><g:message code="jobReport.wetGlaze.label"/></label>
                                </td>
                                <td class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                    <label for="workDetails[0].gullWing"><g:message code="jobReport.gullWing.label"/></label>
                                </td>
                                <td class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                    <label for="workDetails[0].frameGuard"><g:message code="jobReport.frameGuard.label"/></label>
                                </td>
                                <td></td>
                            </tr>
                            <g:if test="${jobReport?.workDetails?.size()>0}">
                            <g:each var="detail" status="cnt" in="${jobReport?.workDetails}">
                                <g:render template="/common/workDetails" model="${[detail:detail, cnt:cnt, jobReport:jobReport]}"/>
                            </g:each>
                            </g:if>
                            <g:else>
                            <tr>
                                <td>
                                    <g:hiddenField name="workDetails[0].toBeRemoved" value="false"/>
                                    <g:hiddenField name="workDetails[0].id" value=""/>
                                    <g:select
                                            class="contentframework-select ${hasErrors(bean:jobReport, field:'workDetails.workTypes.id','contentframework-required-highlight')}"
                                            name="workDetails[0].workTypes.id"
                                            from="${jobreport.WorkTypes.all}"
                                            optionKey="id"
                                            value=""
                                            noSelection="${['null':'Select One...']}"/>
                                </td>
                                <td>
                                    <g:textField
                                            class="contentframework-textfield ${hasErrors(bean:jobReport, field:'workDetails.quantity','contentframework-required-highlight')}"
                                            name="workDetails[0].quantity"
                                            size="5"
                                            value=""
                                            onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                </td>
                                <td>
                                    <g:textField
                                            class="contentframework-textfield ${hasErrors(bean:jobReport, field:'workDetails.width','contentframework-required-highlight')}"
                                            name="workDetails[0].width"
                                            size="5"
                                            value=""
                                            onkeypress="return percentOnly(event)"
                                            onkeydown="return decimalPlaces(\$(this),event,4);"
                                            onblur="formatPercentage(\$(this),2);"/>
                                </td>
                                <td>
                                    <g:textField
                                            class="contentframework-textfield ${hasErrors(bean:jobReport, field:'workDetails.length','contentframework-required-highlight')}"
                                            name="workDetails[0].length"
                                            size="5"
                                            value=""
                                            onkeypress="return percentOnly(event)"
                                            onkeydown="return decimalPlaces(\$(this),event,4);"
                                            onblur="formatPercentage(\$(this),2);"/>
                                </td>
                                <td>
                                    <g:checkBox
                                            class="${hasErrors(bean:jobReport, field:'workDetails.wetGlaze','contentframework-required-highlight')}"
                                            name="workDetails[0].wetGlaze"
                                            value="true"
                                            checked="false"/>
                                </td>
                                <td>
                                    <g:checkBox
                                            class="${hasErrors(bean:jobReport, field:'workDetails.gullWing','contentframework-required-highlight')}"
                                            name="workDetails[0].gullWing"
                                            value="true"
                                            checked="false"/>
                                </td>
                                <td>
                                    <g:checkBox
                                            class="${hasErrors(bean:jobReport, field:'workDetails.frameGuard','contentframework-required-highlight')}"
                                            name="workDetails[0].frameGuard"
                                            value="true"
                                            checked="false"/>
                                </td>
                                <td>
                                    <asset:image src="icons/delete.png"
                                                 style="width:16px;height:16px;"
                                                 onclick="removeRow(\$(this), \$('input[name=\\'workDetails[0].toBeRemoved\\']'));" />
                                </td>
                            </tr>
                            </g:else>
                        </tbody>
                    </table>
                </fieldset>
            </td>
        </tr>
    </tbody>
</table>
<script>
    var workDetailsRowCounter = ${!jobReport?.workDetails ? 1 : jobReport?.workDetails?.size() };
</script>

