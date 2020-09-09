<g:form name="editReport">
    <div style="overflow:hidden;">
        <g:if test="${enableInstallerOption}">
            <g:render template="/common/enable" />
        </g:if>
        <g:if test="${viewable}">
            <div style="overflow:hidden">
                <g:render template="/common/wageType" />
            </div>
            <div id="fieldTeamWage" style="overflow:hidden">
                <g:render template="/common/fieldTeam" />
            </div>
        </g:if>
        <g:else>
            <div style="overflow:hidden">
                <g:render template="/common/wageType" />
            </div>
        </g:else>
    </div>
    <div id="buttons" class="clear" style="float: right;">
        <div class="contentframework" style="float: right">
            <span class="button button-secondary">
                <span>
                    <button type="button" onclick="$('#inline').modaal('close');">
                        <g:message code="default.button.close.label" />
                    </button>
                </span>
            </span>
        </div>
        <div style="float:right">&nbsp;</div>
        <div class="contentframework" style="float: right">
            <span class="button button-secondary">
                <span>
                    <button type="button" onclick="saveTeamInfo();">
                        <g:message code="default.button.save.label" />
                    </button>
                </span>
            </span>
        </div>
    </div>
    <g:hiddenField name="id" value="${jobReport?.id}"/>
    <g:hiddenField name="owner.id" value="${jobReport?.owner?.id}"/>
    <g:hiddenField name="isQuickAccess" value="true"/>
</g:form>