<%@ page import="jobreport.RegionalAgencyRateTypeEnum; jobreport.StandardRateTypeEnum; jobreport.WageTypeEnum" %>
<g:if test="${jobReport?.rateCategory == WageTypeEnum.STANDARD_RATE.name()}">
    <g:select class="contentframework-select ${hasErrors(bean:jobReport, field:'rateClass','contentframework-required-highlight')}"
              name="rateClass"
              from="${StandardRateTypeEnum.values()}"
              optionKey="key"
              value="${jobReport?.rateClass}"
              noSelection="${['null':'Select One...']}"
    />
</g:if>
<g:if test="${jobReport?.rateCategory == WageTypeEnum.REGIONAL_AGENCY_RATE.name()}">
    <g:select class="contentframework-select ${hasErrors(bean:jobReport, field:'rateClass','contentframework-required-highlight')}"
              name="rateClass"
              from="${RegionalAgencyRateTypeEnum.values()}"
              optionKey="key"
              value="${jobReport?.rateClass}"
              noSelection="${['null':'Select One...']}"
    />
</g:if>