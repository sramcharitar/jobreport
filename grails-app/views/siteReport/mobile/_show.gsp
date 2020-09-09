<%@ page import="jobreport.RegionalAgencyRateTypeEnum; jobreport.StandardRateTypeEnum; jobreport.WageTypeEnum" %>
<h5><strong><g:message code="jobReport.clientInformation.title"/></strong></h5>

<table class="w3-table-all">
    <thead>
        <tr class="w3-light-grey">
            <th><strong><g:message code="jobReport.clientName.label"/></strong></th>
            <th><strong><g:message code="jobReport.clientContactName.label"/></strong></th>
            <th><strong><g:message code="jobReport.clientPhone.label"/></strong></th>
            <th><strong><g:message code="jobReport.clientEmail.label"/></strong></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><g:fieldValue bean="${jobReport}" field="client.name"/></td>
            <td><g:fieldValue field="client.contact.firstName" bean="${jobReport}"/>&nbsp;<g:fieldValue field="client.contact.lastName" bean="${jobReport}"/></td>
            <td><g:fieldValue field="client.contact.phone" bean="${jobReport}"/></td>
            <td><g:fieldValue field="client.contact.email" bean="${jobReport}"/></td>
        </tr>
    </tbody>
</table>

<br>

<table class="w3-table-all">
    <thead>
        <tr class="w3-light-grey">
            <th><strong><g:message code="jobReport.clientAddress.label"/></strong></th>
            <th><strong><g:message code="jobReport.clientCity.label"/></strong></th>
            <th><strong><g:message code="jobReport.clientState.label"/></strong></th>
            <th><strong><g:message code="jobReport.clientZipcode.label"/></strong></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><g:fieldValue field="client.address.street" bean="${jobReport}"/></td>
            <td><g:fieldValue field="client.address.city" bean="${jobReport}"/></td>
            <td><g:fieldValue field="client.address.state" bean="${jobReport}"/></td>
            <td><g:fieldValue field="client.address.zipcode" bean="${jobReport}"/></td>
        </tr>
    </tbody>
</table>

<h5><strong><g:message code="jobReport.jobInformation.title" /></strong></h5>

<table class="w3-table-all">
    <thead>
        <tr class="w3-light-grey">
            <th><strong><g:message code="jobReport.workOrderNumber.label"/></strong></th>
            <th><strong><g:message code="jobReport.jobName.label"/></strong></th>
            <th><strong><g:message code="jobReport.salesRep.label"/></strong></th>
            <th><strong><g:message code="jobReport.clientContactCompany.label"/></strong></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><g:fieldValue bean="${jobReport}" field="workOrderNumber"/></td>
            <td><g:fieldValue bean="${jobReport}" field="jobName"/></td>
            <td><g:fieldValue bean="${jobReport}" field="salesRep"/></td>
            <td><g:fieldValue bean="${jobReport}" field="client.contact.company"/></td>
        </tr>
    </tbody>
</table>

<br>

<table class="w3-table-all">
    <thead>
        <tr class="w3-light-grey">
            <th><strong><g:message code="location.street.label"/></strong></th>
            <th><strong><g:message code="location.city.label"/></strong></th>
            <th><strong><g:message code="location.state.label"/></strong></th>
            <th><strong><g:message code="location.zipcode.label"/></strong></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><g:fieldValue bean="${jobReport}" field="jobLocation.street" /></td>
            <td><g:fieldValue bean="${jobReport}" field="jobLocation.city" /></td>
            <td><g:fieldValue bean="${jobReport}" field="jobLocation.state" /></td>
            <td><g:fieldValue bean="${jobReport}" field="jobLocation.zipcode" /></td>
        </tr>
    </tbody>
</table>

<br>

<table class="w3-table-all">
    <thead>
        <tr class="w3-light-grey">
            <th><strong><g:message code="jobReport.jobDescription.label"/></strong></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><g:fieldValue bean="${jobReport}" field="jobDescription" /></td>
        </tr>
    </tbody>
</table>

<h5><strong><g:message code="jobReport.rateClass.title" /></strong></h5>

<table class="w3-table-all">
    <thead>
    <tr class="w3-light-grey">
        <th><strong><g:message code="rateCategoryEnum.category.title"/></strong></th>
        <th><strong><g:message code="fieldTeam.rateType.title"/></strong></th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>${jobReport?.rateCategory as WageTypeEnum}</td>
        <td>${jobReport?.rateCategory as WageTypeEnum == WageTypeEnum.STANDARD_RATE ? jobReport?.rateClass as StandardRateTypeEnum : jobReport.rateClass as RegionalAgencyRateTypeEnum}</td>
    </tr>
    </tbody>
</table>

<h5><strong><g:message code="jobReport.jobDetails.title" /></strong></h5>

<table class="w3-table-all">
    <thead>
        <tr class="w3-light-grey">
            <th><strong><g:message code="jobReport.workType.label"/></strong></th>
            <th><strong><g:message code="jobReport.quantity.label"/></strong></th>
            <th><strong><g:message code="jobReport.width.label"/></strong></th>
            <th><strong><g:message code="jobReport.length.label"/></strong></th>
            <th><strong><g:message code="jobReport.wetGlaze.label"/></strong></th>
            <th><strong><g:message code="jobReport.gullWing.label"/></strong></th>
            <th><strong><g:message code="jobReport.frameGuard.label"/></strong></th>
        </tr>
    </thead>
    <tbody>
    <g:each var="detail" status="j" in="${jobReport?.workDetails}">
        <tr>
            <td><g:fieldValue field="workTypes" bean="${detail}"/></td>
            <td><g:fieldValue field="quantity" bean="${detail}"/></td>
            <td><g:fieldValue field="width" bean="${detail}"/></td>
            <td><g:fieldValue field="length" bean="${detail}"/></td>
            <td><g:if test="${detail.wetGlaze}"><g:message code="default.booleanYes.text"/></g:if><g:else><g:message code="default.booleanNo.text"/></g:else></td>
            <td><g:if test="${detail.gullWing}"><g:message code="default.booleanYes.text"/></g:if><g:else><g:message code="default.booleanNo.text"/></g:else></td>
            <td><g:if test="${detail.frameGuard}"><g:message code="default.booleanYes.text"/></g:if><g:else><g:message code="default.booleanNo.text"/></g:else></td>
        </tr>
    </g:each>
    </tbody>
</table>

<g:if test="${jobReport.productInfo}">
<h5><strong><g:message code="productInfo.productInfo.title" /></strong></h5>
<g:each var="product" in="${jobReport?.productInfo}" status="k">
    <table class="w3-table-all">
        <thead>
            <tr class="w3-light-grey">
                <th><strong><g:message code="productInfo.manufacturer.label"/></strong></th>
                <th><strong><g:message code="productInfo.description.label"/></strong></th>
                <th><strong><g:message code="productInfo.productDeliveryMethod.label"/></strong></th>
                <th><strong><g:message code="productInfo.deliveryDate.label"/></strong></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><g:fieldValue field="manufacturer" bean="${product}"/></td>
                <td><g:fieldValue field="description" bean="${product}"/></td>
                <td><g:fieldValue field="productDeliveryMethod" bean="${product}"/></td>
                <td><g:formatDate date="${product?.deliveryDate}" type="date" style="short"/></td>
            </tr>
        </tbody>
    </table>

    <table class="w3-table-all">
        <colgroup>
            <col style="width: 25%;">
            <col style="width: 25%;">
            <col style="width: 25%;">
            <col style="width: 25%;">
        </colgroup>
        <thead>
            <tr class="w3-light-grey">
                <td colspan="4"><strong><g:message code="productInfo.rollInfo.title" /></strong></td>
            </tr>
            <tr class="w3-light-grey">
                <th><strong><g:message code="productInfo.quantity.label"/></strong></th>
                <th><strong><g:message code="productInfo.width.label"/></strong></th>
                <th><strong><g:message code="productInfo.length.label"/></strong></th>
                <th><strong><g:message code="productInfo.description.label"/></strong></th>
            </tr>
        </thead>
        <tbody>
        <g:if test="${jobReport?.productInfo?.rolls?.size()>0}">
            <g:each var="roll" status="l" in="${product?.rolls}">
            <tr>
                <td><g:fieldValue field="quantity" bean="${roll}"/></td>
                <td><g:fieldValue field="width" bean="${roll}"/></td>
                <td><g:fieldValue field="length" bean="${roll}"/></td>
                <td><g:fieldValue field="description" bean="${roll}"/></td>
            </tr>
            </g:each>
        </g:if>
        </tbody>
    </table>

    <table class="3w-table-all">
        <thead>
        <tr><td></td></tr>
        </thead>
    </table>
</g:each>
</g:if>