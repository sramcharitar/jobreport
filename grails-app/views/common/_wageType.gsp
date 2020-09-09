<%@ page import="jobreport.RegionalAgencyRateTypeEnum; jobreport.StandardRateTypeEnum; jobreport.WageTypeEnum" %>
<table class="contentframework">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="rateCategoryEnum.category.title" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.rateType.title" /></strong>
            </th>
        </tr>
        <tr id="rateClassification">
            <td style="width: 50%">
                <g:select class="contentframework-select ${hasErrors(bean:jobReport, field:'rateCategory','contentframework-required-highlight')}"
                          name="rateCategory"
                          from="${WageTypeEnum.values()}"
                          optionKey="key"
                          value="${jobReport?.rateCategory}"
                          noSelection="${['null':'Select One...']}"
                          onchange="updateRateList()"
                />
            </td>
            <td>
                <div id="rateClassList">
                    <g:render template="/common/rateClassList" model="${[jobReport:jobReport]}"/>
                </div>
            </td>
        </tr>
    </tbody>
</table>