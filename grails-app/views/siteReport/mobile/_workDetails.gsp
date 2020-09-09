<%@ page import="jobreport.WorkDetailsCompleted" %>
<table class="w3-table-all">
    <thead class="w3-light-grey">
    <tr>
        <th><strong><g:message code="jobReport.workType.label"/></strong></th>
        <th><strong><g:message code="jobReport.quantity.label"/></strong></th>
        <th><strong><g:message code="jobReport.width.label"/></strong></th>
        <th><strong><g:message code="jobReport.length.label"/></strong></th>
        <th><strong><g:message code="jobReport.wetGlaze.label"/></strong></th>
        <th><strong><g:message code="jobReport.gullWing.label"/></strong></th>
        <th><strong><g:message code="jobReport.frameGuard.label"/></strong></th>
        %{--<th><strong><g:message code="jobReport.arpal.label"/></strong></th>--}%
    </tr>
    </thead>
    <tbody>
    <g:set var="idx" value="0"/>
    <g:each var="detail" in="${jobReport.workDetails}" status="i">
        <tr>
            <td><g:fieldValue field="workTypes"     bean="${detail}" /></td>
            <td><g:fieldValue field="quantity"      bean="${detail}" /></td>
            <td><g:fieldValue field="width"         bean="${detail}" /></td>
            <td><g:fieldValue field="length"        bean="${detail}" /></td>
            <td>
                <g:if test="${detail?.wetGlaze}"><g:message code="default.booleanYes.text" /></g:if>
                <g:else><g:message code="default.booleanNo.text" /></g:else>
            </td>
            <td>
                <g:if test="${detail?.gullWing}"><g:message code="default.booleanYes.text" /></g:if>
                <g:else><g:message code="default.booleanNo.text" /></g:else>
            </td>
            <td>
                <g:if test="${detail?.frameGuard}"><g:message code="default.booleanYes.text" /></g:if>
                <g:else><g:message code="default.booleanNo.text" /></g:else>
            </td>
            %{--<td><g:fieldValue field="arpal"         bean="${detail}" /></td>--}%
        </tr>
        <tr>
            <td colspan="8">
                <fieldset>
                    <legend><g:fieldValue field="workTypes" bean="${detail}" /> - <g:fieldValue field="quantity" bean="${detail}" /> (<g:fieldValue field="width" bean="${detail}" /> X <g:fieldValue field="length" bean="${detail}" />)</legend>
                    <table class="w3-table-all" id="workDetailsTable${i}" style="width: 100%;">
                        <thead>
                        <tr>
                            <th><strong><g:message code="fieldTeam.fieldAgent.title" /></strong></th>
                            <th><strong><g:message code="siteReport.quantity.label" /></strong></th>
                            <th><strong><g:message code="siteReport.dateComplete.label" /></strong></th>
                            <th><strong><g:message code="siteReport.notes.label" /></strong></th>
                            <th>
                                <div style="float: right">
                                        <span>
                                            <button class="w3-button w3-blue" type="button" onclick="addWorkDetailRow($('#jobReport\\.id').val(), window.workDetailsCounter, $('#workDetailsTable${i}'), ${detail.id});">
                                                <g:message code="default.button.add.label" />
                                            </button>
                                        </span>
                                </div>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:if test="${params.editMode}">
                            <g:set var="workCompletedList" value="${jobreport.WorkDetailsCompleted.findAllBySiteReportAndWorkDetails(siteReport, detail)}"/>
                        </g:if>
                        <g:else>
                            <g:set var="workCompletedList" value="${new ArrayList()}"/>
                        </g:else>
                        <g:if test="${workCompletedList.size() > 0}">
                            <g:each var="workCompleted" in="${workCompletedList}" status="j">
                                <tr>
                                    <td><g:select class="w3-select" name="workDetailsCompleted[${idx}].worker.id" value="${workCompleted?.worker?.id}" from="${jobReport?.fieldTeam.worker}" optionKey="id" noSelection="${['null':g.message(code:'default.choose.label')]}" /></td>
                                    <td><g:textField  class="w3-input" name="workDetailsCompleted[${idx}].qtyCompleted" size="5" value="${workCompleted.qtyCompleted}"/></td>
                                    <td>
                                        <g:textField class="w3-input datecompleted${idx}" name="workDetailsCompleted[${idx}].dateCompleted" value="" />
                                        <script>jQuery('.datecompleted${idx}').datetimepicker({value:'${formatDate(date:workCompleted.dateCompleted, format: 'MM/dd/yyyy')}', format:'m/d/Y', step:60, timepicker:false});</script>
                                    </td>
                                    <td>
                                        <g:hiddenField  name="workDetailsCompleted[${idx}].siteReport.id"  value="${siteReport?.id}"/>
                                        <g:textField  class="w3-input" name="workDetailsCompleted[${idx}].notes"  value="${workCompleted.notes}"/>
                                        <g:hiddenField name="workDetailsCompleted[${idx}].workDetails.id" value="${detail.id}"/>
                                        <g:hiddenField name="workDetailsCompleted[${idx}].toBeRemoved" value="false"/>
                                    </td>
                                    <td style="text-align: right">
                                        <i class="fa fa-trash"
                                           style="font-size:24px"
                                           onmouseover="$(this).css('cursor','pointer');"
                                           onclick="removeRow($(this), $('input[name=\'workDetailsCompleted[${idx}].toBeRemoved\']'));"></i>
                                    </td>
                                </tr>
                                <g:set var="${idx}" value="${idx++}"/>
                            </g:each>
                        </g:if>
                        </tbody>
                    </table>
                </fieldset>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
<g:if test="${siteReport?.id}">
    <g:set var="wd" value="${jobreport.WorkDetailsCompleted.findAllBySiteReport(siteReport).size()}"/>
</g:if>
<g:else>
    <g:set var="wd" value="0"/>
</g:else>
<script>var workDetailsCounter = ${wd};</script>
<script>
    $("select").addClass("w3-select");
</script>