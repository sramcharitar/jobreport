<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<g:form>
    <table class="contentframework specialForm">
        <thead>
            <tr>
                <th class="contentframework-dataheadertop" scope="col" colspan="5"><strong>${employee?.toString()?.toUpperCase()}</strong></th>
            </tr>
            <tr>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialDate"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialType"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialHours"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col" colspan="2"><strong><g:message code="reports.label.rate"/></strong></th>
            </tr>
        </thead>
        <tbody class="contentframework-stripedtable">
            <tr>
                <td>
                    <g:textField class="contentframework-textfield date" name="date" value="${params.date}" autoComplete="off"/>
                    <script>jQuery('.date').datetimepicker({value:'${formatDate(date:params.date ? new SimpleDateFormat("M/dd/yy").parse(params.date) : new Date(), type:'date', format: "M/d/yy")}', format:'m/d/Y', step:60, timepicker:false});</script>
                </td>
                <td>
                    <g:select name="typeEnum"
                              from="${jobreport.SpecialHoursEnum.values()}"
                              optionKey="key"
                              value="${params.typeEnum}"
                              noSelection="['null':'Select Type']"/>
                </td>
                <td><g:textField class="contentframework-textfield" name="hours" value="${params.hours}"/></td>
                <td>
                    <g:textField class="contentframework-textfield" name="rate" value="${params.rate}"/>
                    <g:hiddenField name="max" value="${params.max}"/>
                    <g:hiddenField name="order" value="desc"/>
                    <g:hiddenField name="img" value="${params.img}"/>
                    <g:hiddenField name="sort" value="date"/>
                    <g:hiddenField name="chbEmployee" value="${params.chbEmployee}"/>
                    <g:hiddenField name="employee" value="${employee.id}"/>
                </td>
                <td>
                    <div class="clear" style="float: right;">
                        <span class="button button-secondary">
                            <span>
                                <button type="button"
                                        title="${g.message(code:'default.button.submit.label')}"
                                        onclick="addSpecialInfoForEmployee();">
                                    <g:message code="default.button.submit.label" />
                                </button>
                            </span>
                        </span>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</g:form>
<g:if test="${specialHoursList?.size()}">
    <table class="contentframework">
        <thead>
        <tr>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.date"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialType"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialHours"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.rate"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col" colspan="2"><strong><g:message code="reports.label.specialAmount"/></strong></th>
        </tr>
        </thead>
        <tbody class="contentframework-stripedtable">
            <tr class="contentframework-expandcollapserow">
                <td colspan="6" class="contentframework-formdatalabel"><a onclick="toggleIcon('fieldAgent','fieldAgent_icon');return false" id="fieldAgent_icon" href="#" class="toggleiconlink"><asset:image src="contentframework/icon-collapse.gif" alt="Collapse" /><span class="toggleiconlink-label"><strong>${employee}</strong></span></a></td>
            </tr>
            <g:each in="${specialHoursList}" var="special" status="i">
                <tr class="fieldAgent">
                    <td><g:formatDate type="date" date="${special?.date}" style="MEDIUM"/></td>
                    <td><g:fieldValue bean="${special}" field="typeEnum"/></td>
                    <td><g:formatNumber number="${special?.hours}" minFractionDigits="2" minIntegerDigits="0"/></td>
                    <td><g:formatNumber number="${special?.rate}" type="currency"/></td>
                    <td><g:formatNumber number="${special?.pay()}" type="currency"/></td>
                    <td style="text-align: right; width: 22px"><span title="Delete record for ${special?.typeEnum} with ID: ${special?.id}" onclick="deleteSpecialHour(${special?.id});" style="cursor: pointer"><asset:image src="/icons/x.gif"/></span></td>
                </tr>
            </g:each>
        </tbody>
    </table>
</g:if>