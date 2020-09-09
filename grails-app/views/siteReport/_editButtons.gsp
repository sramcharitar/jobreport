<div id="buttons" class="clear" style="float: right;">
    <table class="contentframework">
        <tbody>
        <tr>
            <div class="contentframework" style="float: right">
                <span class="button button-secondary">
                    <span>
                        <button type="button" onclick="$(location).attr('href', '${createLink(controller:'siteReport', action: 'show', id: jobReport.id, params:[tab:2])}')">
                            <g:message code="default.button.cancel.label" />
                        </button>
                    </span>
                </span>
            </div>
            <div style="float:right">&nbsp;</div>
            <div class="contentframework" style="float: right">
                <span class="button button-primary">
                    <span>
                        <button type="button" onclick="$('#updateReport').submit()">
                            <g:message code="default.button.save.label" />
                            <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" />
                        </button>
                    </span>
                </span>
            </div>
        </tr>
        </tbody>
    </table>
</div>