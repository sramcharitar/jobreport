<div id="buttons" class="w3-container w3-padding-16" style="float: right; clear:both;">

    <div style="float: right">
            <span>
                <button class="w3-button w3-blue" type="button" onclick="$(location).attr('href', '${createLink(controller:'siteReport', action: 'show', id: jobReport.id, params:[tab:2])}')">
                    <g:message code="default.button.cancel.label" />
                </button>
            </span>
    </div>
    <div style="float:right">&nbsp;</div>
    <div style="float: right">
            <span>
                <button class="w3-button w3-blue" type="button" onclick="$('#updateReport').submit()">
                    <g:message code="default.button.save.label" />
                    <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" />
                </button>
            </span>
    </div>

</div>