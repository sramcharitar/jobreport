<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<g:form>
    <div style="overflow: auto">
    <table class="contentframework priorAdjustmentsForm">
        <thead>
            <tr>
                <th class="contentframework-dataheadertop" scope="col" colspan="4"><strong>${employee?.toString()?.toUpperCase()}</strong></th>
            </tr>
            <tr>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.date"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.jobId"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.jobLocation"/></strong></th>
            </tr>
        </thead>
        <tbody class="contentframework-stripedtable">
            <tr>
                <td>
                    <g:textField class="contentframework-textfield workDate" name="workDate" value="${params.workDate}" autoComplete="off"/>
                    <script>jQuery('.workDate').datetimepicker({value:'${formatDate(date:params.workDate ? new SimpleDateFormat("M/dd/yy").parse(params.workDate) : new Date(), type:'date', format: "M/d/yy")}', format:'m/d/Y', step:60, timepicker:false});</script>
                </td>
                <td><g:textField class="contentframework-textfield" name="jobId" value="${params.jobId}"/></td>
                <td><g:textField class="contentframework-textfield" name="location" value="${params.location}"/></td>
            </tr>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.wageType"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col" colspan="2"><strong><g:message code="reports.label.basis"/></strong></th>
            <tr>
                <td>
                    <g:select name="wageTypeEnum"
                              from="${jobreport.WageTypeEnum.values()}"
                              optionKey="key"
                              value="${params.wageTypeEnum}"
                              noSelection="['null':'Select Type']"/>
                </td>
                <td colspan="2">
                    <g:select name="rateTypeEnum"
                              from="${jobreport.RateTypeEnum.values()}"
                              optionKey="key"
                              value="${params.rateTypeEnum}"
                              noSelection="['null':'Select Basis']"/>
                </td>
            </tr>
            <tr>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.regularHours"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.overtimeHours"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialHours"/></strong></th>
            </tr>
            <tr>
                <td><g:textField class="contentframework-textfield" name="regularHours" value="${params.regularHours}"/></td>
                <td><g:textField class="contentframework-textfield" name="overtimeHours" value="${params.overtimeHours}"/></td>
                <td><g:textField class="contentframework-textfield" name="regularHours" value="${params.specialHours}"/></td>
            </tr>
            <tr>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.rate"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.overtimeRate"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.regularTotal"/></strong></th>
            </tr>
            <tr>
                <td><g:textField class="contentframework-textfield" name="regularRate" value="${params.regularRate}"/></td>
                <td><g:textField class="contentframework-textfield" name="overtimeRate" value="${params.overtimeRate}"/></td>
                <td><g:textField class="contentframework-textfield" name="regularPay" value="${params.regularPay}"/></td>
            </tr>
            <tr>

                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.totalOvertimeAmount"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialAmount"/></strong></th>
                <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.teamLeader"/></strong></th>
            </tr>
            <tr>
                <td><g:textField class="contentframework-textfield" name="overtimePay" value="${params.overtimePay}"/></td>
                <td><g:textField class="contentframework-textfield" name="specialPay" value="${params.specialPay}"/></td>
                <td>
                    <g:textField class="contentframework-textfield" name="teamLeaderPay" value="${params.teamLeaderPay}"/>
                    <g:hiddenField name="max" value="${params.max}"/>
                    <g:hiddenField name="order" value="desc"/>
                    <g:hiddenField name="img" value="${params.img}"/>
                    <g:hiddenField name="sort" value="workDate"/>
                    <g:hiddenField name="chbEmployee" value="${params.chbEmployee}"/>
                    <g:hiddenField name="employee" value="${employee.id}"/>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div class="clear" style="float: right;">
                        <span class="button button-secondary">
                            <span>
                                <button type="button"
                                        title="${g.message(code:'default.button.submit.label')}"
                                        onclick="addAdjustmentInfoForEmployee();">
                                    <g:message code="default.button.submit.label" />
                                </button>
                            </span>
                        </span>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
</g:form>

<g:if test="${priorAdjustmentsList?.size()}">
    <table class="contentframework">
        <thead>
        <tr>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.date"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.jobId"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.wageAndRateType"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.regular"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.overtime"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialAmount"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col" colspan="2"><strong><g:message code="reports.label.teamLeader"/></strong></th>
        </tr>
        </thead>
        <tbody class="contentframework-stripedtable">
            <tr class="contentframework-expandcollapserow">
                <td colspan="8" class="contentframework-formdatalabel"><a onclick="toggleIcon('fieldAgent','fieldAgent_icon');return false" id="fieldAgent_icon" href="#" class="toggleiconlink"><asset:image src="contentframework/icon-collapse.gif" alt="Collapse" /><span class="toggleiconlink-label"><strong>${employee}</strong></span></a></td>
            </tr>
            <g:each in="${priorAdjustmentsList}" var="priorAdj" status="i">
                <tr class="fieldAgent" title="${g.message(code: 'reports.label.jobLocation')}: ${g.fieldValue(bean:priorAdj, field:'location')}">
                    <td nowrap class="contentframework-formdatalabel"><g:formatDate type="date" date="${priorAdj?.workDate}" style="MEDIUM"/></td>
                    <td class="contentframework-formdatalabel"><g:fieldValue bean="${priorAdj}" field="jobId"/></td>
                    <td class="contentframework-formdatalabel"><g:fieldValue bean="${priorAdj}" field="wageTypeEnum"/>/<g:fieldValue bean="${priorAdj}" field="rateTypeEnum"/></td>
                    <td nowrap class="contentframework-formdatalabel"><g:message code="reports.label.hrp" args="${[g.fieldValue(bean:priorAdj, field:'regularHours'), g.formatNumber(number:priorAdj.regularRate, type:'currency', maxFractionDigits:2, minFractionDigits:2), g.formatNumber(number:priorAdj.regularPay, type:'currency', maxFractionDigits:2, minFractionDigits:2)]}"/></td>
                    <td nowrap class="contentframework-formdatalabel">
                        <g:if test="${priorAdj.overtimeHours}">
                            <g:message code="reports.label.hrp" args="${[g.fieldValue(bean:priorAdj, field:'overtimeHours'), g.formatNumber(number:priorAdj.overtimeRate, type:'currency', maxFractionDigits:2, minFractionDigits:2), g.formatNumber(number:priorAdj.overtimePay, type:'currency', maxFractionDigits:2, minFractionDigits:2)]}"/>
                        </g:if>
                    </td>
                    <td nowrap class="contentframework-formdatalabel">
                        <g:if test="${priorAdj.specialPay}">
                            <g:message code="reports.label.hrp" args="${[g.fieldValue(bean:priorAdj, field:'specialHours'), g.formatNumber(number:priorAdj.specialRate, type:'currency', maxFractionDigits:2, minFractionDigits:2), g.formatNumber(number:priorAdj.specialPay, type:'currency', maxFractionDigits:2, minFractionDigits:2)]}"/>
                        </g:if>
                    </td>
                    <td class="contentframework-formdatalabel"><g:formatNumber number="${priorAdj?.teamLeaderPay}" type="currency" maxFractionDigits="2" minFractionDigits="2"/></td>
                    <td class="contentframework-formdatalabel" style="text-align: right; width: 22px">
                        <span title="Delete record for ID: ${priorAdj?.id}" onclick="deletePriorAdj(${priorAdj?.id});" style="cursor: pointer"><asset:image src="/icons/x.gif"/></span>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</g:if>