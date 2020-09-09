<%@ page import="jobreport.RateType" %>
<table class="contentframework" style="width: 100%;">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th nowrap="true" class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.fieldTeam.title"/></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.projectMember.title" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.teamLeader.title" /></strong>
            </th>
            %{--
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.payRate.title" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.rateType.title" /></strong>
            </th>
            --}%
        </tr>
        <g:set var="role" value="${jobreport.Role.findByAuthority("ROLE_FIELD_AGENT")}"/>
        <g:each var="worker" status="i" in="${jobreport.ChbUsers.findAllByEnabled(true, [sort:'firstName', order:'asc'])}">
            <g:if test="${worker?.getAuthorities()?.contains(role)}">
        <tr class="fieldTeamWorker${i} ${hasErrors(bean:jobReport, field:'fieldTeam['+i+'].worker.firstName', 'contentframework-required-cellhighlight')} ${hasErrors(bean:jobReport, field:'fieldTeam['+i+'].payRate', 'contentframework-required-cellhighlight')}">
            <td nowrap="true" class="contentframework-altcolumn">
                <g:fieldValue field="firstName" bean="${worker}"/> <g:fieldValue field="lastName" bean="${worker}"/>
                <g:hiddenField name="fieldTeam[${i}]._member" value="${worker?.id}"/>
            </td>
            <td>
                <g:hiddenField class="fieldTeam${i}_deleted" name="fieldTeam[${i}]._deleted" value="${jobReport?.fieldTeam?.find{it?.worker?.id == worker?.id} ? false:true}"/>
                <g:checkBox class="fieldTeamWorker${i} ${hasErrors(bean:jobReport, field:'fieldTeam['+i+'].worker.firstName', 'contentframework-required')}"
                            name="fieldTeam[${i}].worker.id"
                            value="${worker?.id}"
                            checked="${jobReport?.fieldTeam?.find{it?.worker?.id == worker?.id}}"
                            onchange="handleChange( \$(this), '${i}', \$('.fieldTeam${i}_deleted') );"/>
            </td>
            <td>
                <g:checkBox class="fieldTeamLeader${i}"
                            name="fieldTeam[${i}].isTeamLeader"
                            value="true"
                            checked="${jobReport?.fieldTeam?.find{it?._member?.id == worker?.id || it?.worker?.id == worker?.id}?.isTeamLeader}"/>
            </td>
            %{--
            <td>
                <g:textField class="fieldTeamPayRate${i} contentframework-textfield ${hasErrors(bean:jobReport, field:'fieldTeam['+i+'].payRate', 'contentframework-required-highlight')}"
                             name="fieldTeam[${i}].payRate"
                             value="${jobReport?.fieldTeam?.find{it?._member?.id == worker?.id || it?.worker?.id == worker?.id}?.payRate}"
                             size="5"
                             onkeypress="return percentOnly(event)"
                             onkeydown="return decimalPlaces(\$(this),event,4);"
                             onblur="formatPercentage(\$(this),2);"
                             autocomplete="off"/>
            </td>

            <td class="wagetype">
                <g:select class="rateTypeEnum${i} contentframework-select ${hasErrors(bean:jobReport, field:'fieldTeam['+i+'].rateTypeEnum','contentframework-required-highlight')}"
                          name="fieldTeam[${i}].rateTypeEnum"
                          from="${RateType.findAllByWageTypeEnum(jobReport?.wageTypeEnum)}"
                          optionKey="rateTypeEnumKey"
                          value="${jobReport?.fieldTeam?.find{it?._member?.id == worker?.id || it?.worker?.id == worker?.id}?.rateTypeEnum}"
                          noSelection="${['null':'Select One...']}"/>
            </td>
            --}%
        </tr>
            </g:if>
        </g:each>
    </tbody>
</table>