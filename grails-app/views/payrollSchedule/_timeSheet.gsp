<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<div>
    <div class="contentframework-container-primary">
        <div class="contentframework-container-header clear">
            <h3><g:message code="payperiod.page.title" /></h3>
            <g:form>
                <table class="contentframework">
                    <thead>
                    <tr>
                        <th><g:message code="payroll.startDate.label" default="Start Date"/></th>
                        <th><g:message code="payroll.endDate.label" default="End Date"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <g:textField class="contentframework-textfield startDate" name="startDate" value="${params.startDate}" autoComplete="off"/>
                            <script>jQuery('.startDate').datetimepicker({value:'${formatDate(date:params.startDate ? new SimpleDateFormat("M/dd/yy").parse(params.startDate) : new Date(), type:'date', format: "M/d/yy")}', format:'m/d/Y', step:60, timepicker:false});</script>
                        </td>
                        <td>
                            <g:textField class="contentframework-textfield endDate" name="endDate" value="${params.endDate}" autoComplete="off"/>
                            <script>jQuery('.endDate').datetimepicker({value:'${formatDate(date:params.endDate ? new SimpleDateFormat("M/dd/yy").parse(params.endDate) : new Date(), type:'date', format: 'MM/dd/yy')}', format:'m/d/Y', step:60, timepicker:false});</script>
                        </td>
                        <td>
                            <span class="button button-primary">
                                <span>
                                    <button type="submit"><g:message code="default.button.submit.label" default="Submit"/> <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" /></button>
                                </span>
                            </span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </g:form>
        </div>

        <div class="contentframework-container-content">
            <g:if test="${priorPeriodAdjustmentsList.size()}">
                <g:set var="sDate" value="${java.util.Date.parse("MM/dd/yyyy", params.startDate)}"/>
                <g:set var="eDate" value="${java.util.Date.parse("MM/dd/yyyy", params.endDate)}"/>
                <h3>Prior Period Adjustments for Payroll Week <g:formatDate date="${sDate}" type="date" style="MEDIUM"/> - <g:formatDate date="${eDate}" type="date" style="MEDIUM"/></h3>
                <g:render template="priorAdjustmentsListForTimeSheet" model="${[priorPeriodAdjustmentsList:priorPeriodAdjustmentsList]}"/>
            </g:if>

            <g:if test="${specialHoursList.size()}">
                <g:set var="sDate" value="${java.util.Date.parse("MM/dd/yyyy", params.startDate)}"/>
                <g:set var="eDate" value="${java.util.Date.parse("MM/dd/yyyy", params.endDate)}"/>
                <h3>Special Hours for Payroll Week <g:formatDate date="${sDate}" type="date" style="MEDIUM"/> - <g:formatDate date="${eDate}" type="date" style="MEDIUM"/></h3>
                <g:render template="specialHoursListForTimeSheet" model="${[specialHoursList:specialHoursList]}"/>
            </g:if>

            <g:if test="${timeSheetList1.size()}">
                <g:set var="date" value="${java.util.Date.parse("MM/dd/yyyy", params.startDate)}"/>
                <h3>Payroll Week <g:formatDate date="${date}" type="date" style="MEDIUM"/> - <g:formatDate date="${date.plus(6)}" type="date" style="MEDIUM"/></h3>
                <g:render template="list" model="${[timeSheetList:timeSheetList1, weekOne:true]}"/>
            </g:if>

            <g:if test="${timeSheetList2.size()}">
                <g:set var="date" value="${java.util.Date.parse("MM/dd/yyyy", params.startDate).plus(7)}"/>
                <h3>Payroll Week <g:formatDate date="${date}" type="date" style="MEDIUM"/> - <g:formatDate date="${date.plus(6)}" type="date" style="MEDIUM"/></h3>
                <g:render template="list" model="${[timeSheetList:timeSheetList2, weekOne:false]}"/>
            </g:if>

            <g:if test="${timeSheetList.size() || priorPeriodAdjustmentsList.size() || specialHoursList.size()}">
                <table class="contentframework">
                    <tbody>
                    <tr>
                        <td>
                            <div class="clear" style="float: right;">
                                <span class="button button-secondary">
                                    <span>
                                        <button type="button"
                                                title="${g.message(code:'default.button.excel.label')} ${g.message(code:'excel.download.label')}"
                                                onclick="getReport('EXPORT_XLS');">
                                            <g:message code="default.button.excel.label" />
                                        </button>
                                        <asset:image src="icons/excel.gif"
                                                     alt="${g.message(code:'excel.download.label')}"
                                                     title="${g.message(code:'excel.download.label')}"/>
                                    </span>
                                </span>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </g:if>
        </div>

    </div>
</div>