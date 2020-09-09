<%@ page import="jobreport.StandardRateTypeEnum; jobreport.RegionalAgencyRateTypeEnum; jobreport.WageTypeEnum; jobreport.WageType" %>
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
                    <colgroup>
                        <col style="width: 300px;">
                        <col style="width: 225px;">
                        <col style="width: 125px;">
                        <col>
                    </colgroup>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.clientName.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.clientContactName.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.clientPhone.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.clientEmail.label"/></td>
                    </tr>
                    <tr class="subcopy">
                        <td><g:fieldValue bean="${jobReport}" field="client.name"/></td>
                        <td><g:fieldValue field="client.contact.firstName" bean="${jobReport}"/>&nbsp;<g:fieldValue field="client.contact.lastName" bean="${jobReport}"/></td>
                        <td><g:fieldValue field="client.contact.phone" bean="${jobReport}"/></td>
                        <td><g:fieldValue field="client.contact.email" bean="${jobReport}"/></td>
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
                    <colgroup>
                        <col style="width: 300px;">
                        <col style="width: 200px;">
                        <col style="width: 75px;">
                        <col style="width: 75px;">
                    </colgroup>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.clientAddress.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.clientCity.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.clientState.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.clientZipcode.label"/></td>
                    </tr>
                    <tr class="subcopy">
                        <td><g:fieldValue field="client.address.street" bean="${jobReport}"/></td>
                        <td><g:fieldValue field="client.address.city" bean="${jobReport}"/></td>
                        <td><g:fieldValue field="client.address.state" bean="${jobReport}"/></td>
                        <td><g:fieldValue field="client.address.zipcode" bean="${jobReport}"/></td>
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
            <div><strong><g:message code="jobReport.jobInformation.title" /></strong></div>
        </th>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="jobReport.jobInformation.title"/></legend>
                <table class="contentframework">
                    <tbody>
                    <colgroup>
                        <col style="width: 25%;">
                        <col style="width: 25%;">
                        <col style="width: 25%">
                        <col>
                    </colgroup>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.workOrderNumber.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.jobName.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.salesRep.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.clientContactCompany.label"/></td>
                    </tr>
                    <tr class="subcopy">
                        <td><g:fieldValue bean="${jobReport}" field="workOrderNumber"/></td>
                        <td><g:fieldValue bean="${jobReport}" field="jobName"/></td>
                        <td><g:fieldValue bean="${jobReport}" field="salesRep"/></td>
                        <td><g:fieldValue bean="${jobReport}" field="client.contact.company"/></td>
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
                    <colgroup>
                        <col style="width: 300px;">
                        <col style="width: 200px;">
                        <col style="width: 75px;">
                        <col style="width: 75px;">
                    </colgroup>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="location.street.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="location.city.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="location.state.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="location.zipcode.label"/></td>
                    </tr>
                    <tr class="subcopy">
                        <td><g:fieldValue bean="${jobReport}" field="jobLocation.street" /></td>
                        <td><g:fieldValue bean="${jobReport}" field="jobLocation.city" /></td>
                        <td><g:fieldValue bean="${jobReport}" field="jobLocation.state" /></td>
                        <td><g:fieldValue bean="${jobReport}" field="jobLocation.zipcode" /></td>
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
                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="jobReport.jobDescription.label"/></td>
                    </tr>
                    <tr class="subcopy">
                        <td><g:fieldValue bean="${jobReport}" field="jobDescription" /></td>
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
            <strong><g:message code="tab.rateClass.label" /></strong>
        </th>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="jobReport.clientInformation.title"/></legend>
                <table class="contentframework" id="rateClassTable" style="width: 100%;">
                    <tbody>
                    <colgroup>
                        <col style="width: 50%;">
                        <col>
                    </colgroup>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="rateCategoryEnum.category.title"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="fieldTeam.rateType.title"/></td>
                    </tr>
                    <tr class="subcopy">
                        <td>${jobReport?.rateCategory as WageTypeEnum}</td>
                        <td>${jobReport?.rateCategory as WageTypeEnum == WageTypeEnum.STANDARD_RATE ? jobReport?.rateClass as StandardRateTypeEnum : jobReport.rateClass as RegionalAgencyRateTypeEnum}</td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    </tbody>
</table>

<table class="contentframework" style="width: 100%;">
    <tbody>
    <tr>
        <th colspan="2" class="contentframework-dataheadertop" scope="col">
            <strong><g:message code="jobReport.jobDetails.title" /></strong>
        </th>
    </tr>
    <tr>
        <td>
            <fieldset>
                <legend><g:message code="jobReport.clientInformation.title"/></legend>
                <table class="contentframework" id="workDetailsTable" style="width: 100%;">
                    <colgroup>
                        <col style="width: 150px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 95px;">
                        <col style="width: 95px;">
                        <col style="width: 120px;">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.workType.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.quantity.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.width.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.length.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.wetGlaze.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.gullWing.label"/></td>
                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="jobReport.frameGuard.label"/></td>
                    </tr>
                    <g:each var="detail" status="j" in="${jobReport?.workDetails}">
                        <tr class="subcopy">
                            <td><g:fieldValue field="workTypes" bean="${detail}"/></td>
                            <td><g:fieldValue field="quantity" bean="${detail}"/></td>
                            <td><g:fieldValue field="width" bean="${detail}"/> <g:message code="default.inches.label"/></td>
                            <td><g:fieldValue field="length" bean="${detail}"/> <g:message code="default.feet.label"/></td>
                            <td>
                                <g:if test="${detail.wetGlaze}">
                                    <g:message code="default.booleanYes.text"/>
                                </g:if>
                                <g:else>
                                    <g:message code="default.booleanNo.text"/>
                                </g:else>
                            </td>
                            <td>
                                <g:if test="${detail.gullWing}">
                                    <g:message code="default.booleanYes.text"/>
                                </g:if>
                                <g:else>
                                    <g:message code="default.booleanNo.text"/>
                                </g:else>
                            </td>
                            <td>
                                <g:if test="${detail.frameGuard}">
                                    <g:message code="default.booleanYes.text"/>
                                </g:if>
                                <g:else>
                                    <g:message code="default.booleanNo.text"/>
                                </g:else>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </fieldset>
        </td>
    </tr>
    </tbody>
</table>

<g:if test="${jobReport.productInfo?.size()>0}">
    <table class="contentframework" style="width: 100%;">
        <tbody>
        <tr>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="productInfo.productList.title" /></strong>
            </th>
        </tr>
    <g:each var="product" in="${jobReport.productInfo}" status="i">
        <tr>
            <td>

                <table class="contentframework" style="width: 100%;">
                    <tbody>
                    <tr>
                        <th class="contentframework-dataheadertop" scope="col">
                            <strong><g:message code="productInfo.productInfo.title" /></strong>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend><g:message code="productInfo.productInfo.title"/></legend>
                                <table class="contentframework" style="width:100%;">
                                    <tbody>
                                    <tr>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="productInfo.manufacturer.label"/></td>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="productInfo.description.label"/></td>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="productInfo.productDeliveryMethod.label"/></td>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"> <g:message code="productInfo.deliveryDate.label"/></td>
                                    </tr>
                                    <tr class="subcopy">
                                        <td><g:fieldValue field="manufacturer" bean="${product}"/></td>
                                        <td><g:fieldValue field="description" bean="${product}"/></td>
                                        <td><g:fieldValue field="productDeliveryMethod" bean="${product}"/></td>
                                        <td><g:formatDate date="${product?.deliveryDate}" type="date" style="short"/></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                        <th class="contentframework-dataheadertop" scope="col">
                            <strong><g:message code="productInfo.rollInfo.title" /></strong>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend><g:message code="productInfo.rollInfo.title"/></legend>
                                <table class="contentframework" id="rollDetailsTable" style="width: 100%;">
                                    <colgroup>
                                        <col style="width: 20%;">
                                        <col style="width: 20%;">
                                        <col style="width: 20%;">
                                        <col style="width: 20%;">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <td nowrap="true" class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="inventoryDetails.rollNumber.label"/></td>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="productInfo.quantity.label"/></td>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="productInfo.width.label"/></td>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="productInfo.length.label"/></td>
                                        <td class="contentframework-formdatalabel" style="font-weight: bold"><g:message code="productInfo.description.label"/></td>
                                    </tr>
                                    <g:if test="${product?.rolls?.size()>0}">
                                        <g:each var="roll" status="k" in="${product?.rolls}">
                                        <tr class="subcopy">
                                            <td><g:fieldValue field="rollNumber" bean="${roll}"/></td>
                                            <td><g:fieldValue field="quantity" bean="${roll}"/></td>
                                            <td nowrap="true"><g:fieldValue field="width" bean="${roll}"/> <g:message code="default.inches.label"/></td>
                                            <td nowrap="true"><g:fieldValue field="length" bean="${roll}"/> <g:message code="default.linearFeet.label"/></td>
                                            <td><g:fieldValue field="description" bean="${roll}"/></td>
                                        </tr>
                                        </g:each>
                                    </g:if>
                                    </tbody>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </g:each>
        </tbody>
    </table>
</g:if>

<sec:ifNotGranted roles="ROLE_FIELD_AGENT">
<g:if test="${jobReport?.fieldTeam?.size()>0}">
    <table class="contentframework">
        <tbody class="contentframework-stripedtable">
        <tr>
            <th nowrap="true" class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.fieldTeam.title"/></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.teamLeader.title" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.teamLeaderPay.title" /></strong>
            </th>
            %{--
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.wageType.title" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.payRate.title" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.rateType.title" /></strong>
            </th>
            --}%
        </tr>
        <g:each var="worker" status="i" in="${jobReport?.fieldTeam}">
            <tr class="subcopy">
                <td nowrap="true">
                    <g:fieldValue field="firstName" bean="${worker?.worker}"/> <g:fieldValue field="lastName" bean="${worker?.worker}"/>
                </td>
                <td>
                    <g:if test="${worker?.isTeamLeader}">
                        <g:message code="default.booleanYes.text"/>
                    </g:if>
                </td>
                <td>
                    <g:if test="${worker?.isTeamLeader}">
                        <g:formatNumber number="${worker?.teamLeaderPay}" type="currency"/>
                    </g:if>
                </td>
                %{--
                <td>${jobreport.WageType.findByTypeEnum(jobReport?.wageTypeEnum)}</td>
                <td><g:formatNumber number="${worker?.payRate}" type="currency"/></td>
                <td nowrap="true">
                    ${jobreport.RateType.findByRateTypeEnum(worker?.rateTypeEnum)}
                </td>
                --}%
            </tr>
        </g:each>
        </tbody>
    </table>
</g:if>
</sec:ifNotGranted>