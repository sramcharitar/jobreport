<table id="timeSheetTable" class="w3-table-all" style="width:100%;">
    <tbody>
    <tr>
        <th nowrap="true" scope="col" colspan="5">
            <div style="float:left;"><strong><g:message code="tab.timeSheet.label" /></strong></div>
            <div style="float: right">
                    <span>
                        <button class="w3-button w3-blue" type="button" onclick="addTimeLogRow($('#jobReport\\.id').val(), '/siteReport/mobile/timeLog', $('#timeSheetTable'), 'timesheet');">
                            <g:message code="default.button.add.label" />
                        </button>
                    </span>
            </div>
            <div style="float: right">&nbsp;&nbsp;</div>
            <div style="float: right">
                <asset:image    src="/icons/myLocation.png"
                                onmouseover="\$(this).css('cursor','pointer');"
                                onclick="getGeoLocation()"/>
            </div>
        </th>
    </tr>
    <tr>
        <th nowrap="true" scope="col">
            <strong><g:message code="fieldTeam.fieldAgent.title"/></strong>
        </th>
        <th scope="col">
            <strong><g:message code="timeSheet.startDateTime.label" /></strong>
        </th>
        <th scope="col">
            <strong><g:message code="timeSheet.endDateTime.label" /></strong>
        </th>
        <th scope="col">
            <strong><g:message code="timeSheet.lunchBreak.label" /></strong>
        </th>
        <th scope="col"></th>
    </tr>
    <g:each var="item" status="i" in="${siteReport?.timeSheet}">
        <g:render template="mobile/timeLog" model="${[i:i, jobReport:jobReport, item:item]}"/>
    </g:each>
    </tbody>
</table>
<script>
    var timeLogRowCounter = ${siteReport?.timeSheet?.size() ?: 0 };
</script>