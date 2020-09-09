<div class="contentframework" style="float: right">
    <span class="button button-primary">
        <span>
            <button type="button" onclick="$(location).attr('href', '${createLink(controller:'siteReport', action: 'create', id:jobReport.id)}')">
                <g:message code="default.button.createSiteReport.label" />
                <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" />
            </button>
        </span>
    </span>
</div>
<div style="float:right">&nbsp;</div>
<div class="contentframework" style="float: right">
    <span class="button button-secondary">
        <span>
            <button type="button" onclick="$(location).attr('href', '${createLink(controller:'jobReport', action: 'index')}')">
                <g:message code="default.button.close.label" />
            </button>
        </span>
    </span>
</div>