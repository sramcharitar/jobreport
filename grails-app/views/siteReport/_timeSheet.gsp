<table id="timeSheetTable" class="contentframework" style="width:100%;">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th nowrap="true" class="contentframework-dataheadertop" scope="col" colspan="5">
                <div style="float:left;"><strong><g:message code="tab.timeSheet.label" /></strong></div>
                <div class="contentframework" style="float: right">
                    <span class="button button-secondary">
                        <span>
                            <button type="button" onclick="addTimeLogRow($('#jobReport\\.id').val(), '/siteReport/timeLog', $('#timeSheetTable'), 'timesheet');">
                                <g:message code="default.button.add.label" />
                            </button>
                        </span>
                    </span>
                </div>
                <div style="float: right">&nbsp;&nbsp;</div>
                <div class="contentframework" style="float: right">
                    <asset:image    src="/icons/myLocation.png"
                                    onmouseover="\$(this).css('cursor','pointer');"
                                    onclick="getGeoLocation()"/>
                </div>
            </th>
        </tr>
        <tr>
            <th nowrap="true" class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="fieldTeam.fieldAgent.title"/></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="timeSheet.startDateTime.label" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="timeSheet.endDateTime.label" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col">
                <strong><g:message code="timeSheet.lunchBreak.label" /></strong>
            </th>
            <th class="contentframework-dataheadertop" scope="col"></th>
        </tr>
        <g:each var="item" status="i" in="${siteReport?.timeSheet}">
            <g:render template="timeLog" model="${[i:i, jobReport:jobReport, item:item]}"/>
        </g:each>
    </tbody>
</table>
<script>
    var timeLogRowCounter = ${siteReport?.timeSheet?.size() ?: 0 };
</script>