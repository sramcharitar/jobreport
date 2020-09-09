    <table class="contentframework">
        <thead>
            <tr>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"><g:message code="jobReport.workType.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"><g:message code="jobReport.quantity.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"><g:message code="jobReport.width.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"><g:message code="jobReport.length.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"><g:message code="jobReport.wetGlaze.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"><g:message code="jobReport.gullWing.label"/></th>
                <th class="contentframework-dataheadertop" scope="col" style="font-weight: bold"><g:message code="jobReport.frameGuard.label"/></th>
            </tr>
        </thead>
        <tbody class="contentframework-stripedtable">
            <tr>
                <td><g:fieldValue field="workTypes"     bean="${detail}" /></td>
                <td><g:fieldValue field="quantity"      bean="${detail}" /></td>
                <td><g:fieldValue field="width"         bean="${detail}" /></td>
                <td><g:fieldValue field="length"        bean="${detail}" /></td>
                <td><g:fieldValue field="wetGlaze"      bean="${detail}" /></td>
                <td><g:fieldValue field="gullWing"      bean="${detail}" /></td>
                <td><g:fieldValue field="frameGuard"    bean="${detail}" /></td>
            </tr>
        </tbody>
    </table>


    <table class="contentframework" id="workDetailTable">
        <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="fieldTeam.fieldAgent.title" /></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="siteReport.quantity.label" /></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="siteReport.dateComplete.label" /></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="jobReport.highScaffold.label" /></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="siteReport.notes.label" /></strong></th>
            <th class="contentframework-dataheadertop" scope="col">
                <div class="contentframework" style="float: right">
                    <span class="button button-secondary">
                        <span>
                            <button type="button" onclick="addWorkDetailRow(${detail?.jobReport?.id}, window.workDetailsCounter, $('#workDetailTable'), ${detail.id});">
                                <g:message code="default.button.add.label" />
                            </button>
                        </span>
                    </span>
                </div>
            </th>
        </tr>

        <g:each var="workCompleted" in="${detailList}" status="idx">
            <tr>
                <td>
                    <g:select     name="workDetailsCompleted[${idx}].worker.id"
                                  value="${workCompleted?.worker?.id}"
                                  from="${workCompleted?.workDetails?.jobReport?.fieldTeam?.worker}"
                                  optionKey="id"
                                  noSelection="${['null':g.message(code:'default.choose.label')]}" />
                </td>
                <td><g:textField  name="workDetailsCompleted[${idx}].qtyCompleted" size="5" value="${workCompleted.qtyCompleted}"/></td>
                <td><g:textField  class="datecompleted${idx}" name="workDetailsCompleted[${idx}].dateCompleted" value="" />
                    <script>jQuery('.datecompleted${idx}').datetimepicker({value:'${formatDate(date:workCompleted.dateCompleted, type:'date', style: 'medium')}', format:'m/d/Y', step:60, timepicker:false});</script>
                </td>
                <td>
                    <g:checkBox
                            name="workDetailsCompleted[${idx}].highScaffold"
                            value="true"
                            checked="${workCompleted?.highScaffold == true}"/>
                </td>
                <td>
                    <g:hiddenField  name="workDetailsCompleted[${idx}].siteReport.id"  value="${workCompleted?.siteReport?.id}"/>
                    <g:textField  name="workDetailsCompleted[${idx}].notes"  value="${workCompleted?.notes}"/>
                    <g:hiddenField name="workDetailsCompleted[${idx}].workDetails.id" value="${detail?.id}"/>
                    <g:hiddenField name="workDetailsCompleted[${idx}].toBeRemoved" value="false"/>
                </td>
                <td style="text-align: right">
                    <asset:image src="icons/delete.png"
                                 style="width:16px;height:16px;"
                                 onclick="removeRow(\$(this), \$('input[name=\\'workDetailsCompleted[${idx}].toBeRemoved\\']'));" />
                </td>
            </tr>
        </g:each>

        </tbody>
    </table>

    <table class="contentframework">
        <tbody>
            <tr>
                <td style="text-align: right">
                    <div style="float: right" align="right">
                    <div class="contentframework" style="float: right" align="right">
                        <span class="button button-secondary">
                            <span>
                                <button type="button" onclick="cancelWorkDetails()">
                                    <g:message code="default.button.cancel.label" />
                                </button>
                            </span>
                        </span>
                    </div>
                    <div style="float: right" align="right">&nbsp;</div>
                    <div class="contentframework" style="float: right" align="right">
                        <span class="button button-secondary">
                            <span>
                                <button type="button" onclick="updateWorkDetails()">
                                    <g:message code="default.button.update.label" />
                                </button>
                            </span>
                        </span>
                    </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>

<script>var workDetailsCounter = ${detailList?.size()};</script>