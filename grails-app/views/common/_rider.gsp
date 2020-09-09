<table class="contentframework">
    <tbody>
    <tr>
        <th colspan="2" class="contentframework-dataheadertop" scope="col">
            <div><strong><g:message code="rider.heading.title" /></strong></div>
        </th>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="rider.heading.title"/></legend>
                <table class="contentframework" style="width:100%;">
                    <colspan>
                        <col style="width: 33%;">
                        <col style="width: 26%;">
                        <col>

                    </colspan>
                    <tbody>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                            <label for="rider.measuredBy"><g:message code="rider.measuredBy.label"/></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                            <label for="rider.measurementDate"><g:message code="rider.measurementDate.label"/></label>
                        </td>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                            <label for="rider.measurementDate"><g:message code="rider.installationDate.label"/></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <g:textField
                                    class="contentframework-select ${hasErrors(bean:jobReport, field:'rider.measuredBy','contentframework-required-highlight')}"
                                    name="rider.measuredBy"
                                    value="${jobReport?.rider?.measuredBy}"
                                    size="25"/>
                        </td>
                        <td>
                            <g:textField class="contentframework-textfield measurementDate" name="rider.measurementDate" value="${jobReport?.rider?.measurementDate ?: new Date()}" />
                            <script>jQuery('.measurementDate').datetimepicker({value:'${formatDate(date:jobReport?.rider?.measurementDate ?: new Date(), type:'date', style: 'short')}', format:'m/d/Y', step:60, timepicker:false});</script>
                        </td>
                        <td>
                            <g:textField class="contentframework-textfield installationDate" name="rider.installationDate" value="${jobReport?.rider?.installationDate ?: new Date()}" />
                            <script>jQuery('.installationDate').datetimepicker({value:'${formatDate(date:jobReport?.rider?.installationDate ?: new Date(), type:'date', style: 'short')}', format:'m/d/Y', step:60, timepicker:false});</script>
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
                <legend><g:message code="rider.heading.title"/></legend>
                <table class="contentframework">
                    <tbody>
                    <tr>
                        <td class="contentframework-formdatalabel">
                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                            <label for="rider.specialInstructions"><g:message code="rider.specialInstructions.label"/></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <g:textArea
                                    class="contentframework-textarea ${hasErrors(bean:jobReport, field:'rider.specialInstructions','contentframework-required-highlight')}"
                                    name="rider.specialInstructions"
                                    value="${jobReport?.rider?.specialInstructions}"
                                    cols="75"
                                    rows="5"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    </tbody>
</table>

