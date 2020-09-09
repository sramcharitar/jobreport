<%@ page import="jobreport.WorkDetailsCompleted" %>
<table class="contentframework">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.workType.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.quantity.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.width.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.length.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.wetGlaze.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.gullWing.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.frameGuard.label"/></th>
            <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"> <g:message code="jobReport.arpal.label"/></th>
        </tr>
        <g:set var="idx" value="0"/>
        <g:set var="siteRep" value="${jobReport.siteReport}"/>
        <g:each var="detail" in="${jobReport.workDetails}" status="i">
            <g:if test="${siteRep.size()}">
                <g:set var="workCompletedList" value="${jobreport.WorkDetailsCompleted.findAllBySiteReportInListAndWorkDetails(siteRep, detail)}"/>
            </g:if>
            <g:else>
                <g:set var="workCompletedList" value="${new java.util.ArrayList()}"/>
            </g:else>
            <g:set var="detailsCnt" value="${0}"/>
            <g:each in="${workCompletedList}" var="w">
                <g:set var="detailsCnt" value="${detailsCnt + w.qtyCompleted}"/>
            </g:each>
            <g:set var="moreDetails" value="${detailsCnt < detail.quantity}"/>
        <tr class="subcopy">
            <td><g:fieldValue field="workTypes"     bean="${detail}" /></td>
            <td><g:fieldValue field="quantity"      bean="${detail}" /></td>
            <td><g:fieldValue field="width"         bean="${detail}" /></td>
            <td><g:fieldValue field="length"        bean="${detail}" /></td>
            <td><g:fieldValue field="wetGlaze"      bean="${detail}" /></td>
            <td><g:fieldValue field="gullWing"      bean="${detail}" /></td>
            <td><g:fieldValue field="frameGuard"    bean="${detail}" /></td>
            <td><g:fieldValue field="arpal"         bean="${detail}" /></td>
        </tr>
        <tr>
            <td colspan="8">
                <fieldset>
                    <legend><g:fieldValue field="workTypes" bean="${detail}" /> - <g:fieldValue field="quantity" bean="${detail}" /> (<g:fieldValue field="width" bean="${detail}" /> X <g:fieldValue field="length" bean="${detail}" />)</legend>
                    <table id="workDetailsTable${i}" style="width: 100%;">
                        <tbody>
                        <tr class="subcopy">
                            <th class="contentframework-formdatalabel"><strong><g:message code="fieldTeam.fieldAgent.title" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.quantity.label" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.dateComplete.label" /></strong></th>
                            <th class="contentframework-formdatalabel"><strong><g:message code="siteReport.notes.label" /></strong></th>
                            <g:if test="${params.editMode || moreDetails}">
                            <th class="contentframework-formdatalabel">
                                <div class="contentframework" style="float: right">
                                <span class="button button-secondary">
                                    <span>
                                        <button type="button" onclick="addWorkDetailRow($('#jobReport\\.id').val(), window.workDetailsCounter, $('#workDetailsTable${i}'), ${detail.id});">
                                            <g:message code="default.button.add.label" />
                                        </button>
                                    </span>
                                </span>
                                </div>
                            </th>
                            </g:if>
                        </tr>
                        %{--
                        <g:if test="${params.editMode}">
                            <g:set var="workCompletedList" value="${jobreport.WorkDetailsCompleted.findAllBySiteReportAndWorkDetails(siteReport, detail)}"/>
                        </g:if>
                        <g:else>
                        --}%
                            <g:if test="${params.editMode || siteRep.size() > 0 }">
                                <g:set var="workCompletedList" value="${jobreport.WorkDetailsCompleted.findAllBySiteReportInListAndWorkDetails(siteRep, detail)}"/>
                            </g:if>
                            <g:else>
                                <g:set var="workCompletedList" value="${new ArrayList()}"/>
                            </g:else>
                        %{--
                        </g:else>
                        --}%
                        <g:if test="${params.editMode && workCompletedList.size() > 0}">
                            <g:each var="workCompleted" in="${workCompletedList}" status="j">
                            <g:if test="${siteReport == workCompleted?.siteReport}">
                            <tr class="subcopy">
                                <td><g:select     name="workDetailsCompleted[${idx}].worker.id" value="${workCompleted?.worker?.id}" from="${jobReport?.fieldTeam.worker}" optionKey="id" noSelection="${['null':g.message(code:'default.choose.label')]}" /></td>
                                <td><g:textField  name="workDetailsCompleted[${idx}].qtyCompleted" size="5" value="${workCompleted.qtyCompleted}"/></td>
                                <td><g:textField  class="datecompleted${idx}" name="workDetailsCompleted[${idx}].dateCompleted" value="" />
                                    <script>jQuery('.datecompleted${idx}').datetimepicker({value:'${formatDate(date:workCompleted.dateCompleted, type:'date', style: 'medium')}', format:'m/d/Y', step:60, timepicker:false});</script>
                                </td>
                                <td>
                                    <g:hiddenField  name="workDetailsCompleted[${idx}].siteReport.id"  value="${siteReport?.id}"/>
                                    <g:textField  name="workDetailsCompleted[${idx}].notes"  value="${workCompleted?.notes}"/>
                                    <g:hiddenField name="workDetailsCompleted[${idx}].workDetails.id" value="${detail?.id}"/>
                                    <g:hiddenField name="workDetailsCompleted[${idx}].toBeRemoved" value="false"/>
                                </td>
                                <g:if test="${(params.editMode && siteReport == workCompleted.siteReport) || moreDetails}">
                                <td style="text-align: right">
                                    <asset:image src="icons/delete.png"
                                                 style="width:16px;height:16px;"
                                                 onclick="removeRow(\$(this), \$('input[name=\\'workDetailsCompleted[${idx}].toBeRemoved\\']'));" />
                                </td>
                                </g:if>
                            </tr>
                                <g:set var="${idx}" value="${idx++}"/>
                            </g:if>
                            <g:else>
                                <tr class="subcopy">
                                    <td class="contentframework-formdatalabel"><g:fieldValue bean="${workCompleted}" field="worker" /></td>
                                    <td class="contentframework-formdatalabel"><g:fieldValue bean="${workCompleted}" field="qtyCompleted"/></td>
                                    <td class="contentframework-formdatalabel"><g:formatDate date="${workCompleted.dateCompleted}" style="medium" type="date"/></td>
                                    <td class="contentframework-formdatalabel" colspan="2"><g:fieldValue bean="${workCompleted}" field="notes"/></td>
                                </tr>
                            </g:else>
                            </g:each>
                        </g:if>
                        <g:else>
                            <g:each var="workCompleted" in="${workCompletedList}" status="j">
                                <tr class="subcopy">
                                    <td class="contentframework-formdatalabel"><g:fieldValue bean="${workCompleted}" field="worker" /></td>
                                    <td class="contentframework-formdatalabel"><g:fieldValue bean="${workCompleted}" field="qtyCompleted"/></td>
                                    <td class="contentframework-formdatalabel"><g:formatDate date="${workCompleted.dateCompleted}" style="medium" type="date"/></td>
                                    <td class="contentframework-formdatalabel" colspan="2"><g:fieldValue bean="${workCompleted}" field="notes"/></td>
                                </tr>
                            </g:each>
                        </g:else>
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