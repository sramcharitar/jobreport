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
                <g:textField class="contentframework-textfield date" name="date" value="${params.date}"/>
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
                <g:hiddenField name="order" value="${params.order}"/>
                <g:hiddenField name="img" value="${params.img}"/>
                <g:hiddenField name="sort" value="${params.sort}"/>
                <g:hiddenField name="chbEmployee" value="${params.chbEmployee}"/>
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
<g:render template="/layouts/errorMsg" model="${[objectInstance:objectInstance]}"/>