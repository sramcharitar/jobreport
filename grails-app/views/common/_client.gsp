<table class="contentframework">
    <tbody>
        <tr>
            <th colspan="2" class="contentframework-dataheadertop" scope="col">
                <div><strong><g:message code="jobReport.clientInformation.title" /></strong></div>
            </th>
        </tr>
        <tr>
            <td>
                <fieldset>
                    <legend><g:message code="jobReport.clientInformation.title"/></legend>
                    <table class="contentframework">
                        <tbody>
                            <tr>
                                <td class="contentframework-formdatalabel">
                                    <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                    <label for="client.name"><g:message code="jobReport.clientName.label"/></label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <g:textField
                                            class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.name','contentframework-required-highlight')}"
                                            name="client.name"
                                            value="${jobReport?.client?.name}"
                                            size="75"/>
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
                    <table class="contentframework">
                        <tbody>
                        <tr>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="client.address.street"><g:message code="jobReport.clientAddress.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="client.address.city"><g:message code="jobReport.clientCity.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="client.address.state"><g:message code="jobReport.clientState.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="client.address.zipcode"><g:message code="jobReport.clientZipcode.label"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.address.street','contentframework-required-highlight')}"
                                        name="client.address.street"
                                        value="${jobReport?.client?.address?.street}"
                                        size="40"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.address.city','contentframework-required-highlight')}"
                                        name="client.address.city"
                                        value="${jobReport?.client?.address?.city}"
                                        size="30"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.address.state','contentframework-required-highlight')}"
                                        name="client.address.state"
                                        value="${jobReport?.client?.address?.state}"
                                        size="5"
                                        maxlength="2"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.address.zipcode','contentframework-required-highlight')}"
                                        name="client.address.zipcode"
                                        value="${jobReport?.client?.address?.zipcode}"
                                        size="5"
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
                    <legend><g:message code="jobReport.clientInformation.title"/></legend>
                    <table class="contentframework">
                        <tbody>
                        <tr>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                <label for="client.contact.company"><g:message code="jobReport.clientContactCompany.label"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <g:textField
                                        class="contentframework-textfield"
                                        name="client.contact.company"
                                        value="${jobReport?.client?.contact?.company}"
                                        size="20"/>
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
                    <table class="contentframework">
                        <tbody>
                        <tr>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="client.contact.firstName"><g:message code="jobReport.clientFirstName.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="client.contact.lastName"><g:message code="jobReport.clientLastName.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                <label for="client.contact.phone"><g:message code="jobReport.clientPhone.label"/></label>
                            </td>
                            <td class="contentframework-formdatalabel">
                                <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                <label for="client.contact.email"><g:message code="jobReport.clientEmail.label"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.contact.firstName','contentframework-required-highlight')}"
                                        name="client.contact.firstName"
                                        value="${jobReport?.client?.contact?.firstName}"
                                        size="20"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.contact.lastName','contentframework-required-highlight')}"
                                        name="client.contact.lastName"
                                        value="${jobReport?.client?.contact?.lastName}"
                                        size="20"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield ${hasErrors(bean:jobReport, field:'client.contact.phone','contentframework-required-highlight')}"
                                        name="client.contact.phone"
                                        value="${jobReport?.client?.contact?.phone}"
                                        size="15"
                                        maxlength="11"
                                        onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                            </td>
                            <td>
                                <g:textField
                                        class="contentframework-textfield"
                                        name="client.contact.email"
                                        value="${jobReport?.client?.contact?.email}"
                                        size="25"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </fieldset>
            </td>
        </tr>
    </tbody>
</table>

