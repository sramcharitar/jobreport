<div class="skipnav">
    <a href="#skiptabnavHorz"><g:message code="skip.tab.navigation"/></a>
</div>
<div class="primarytabs clear">
    <div class="primarytabs-level1 clear">
        <ul id="ul_htl_lbg">
            <li class="${tab == 0 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg1' rel="htl_lbg1"><span><a href="#" title="${g.message(code:'tab.client.label')}"><g:message code="tab.client.label" /></a></span></li>
            <li class="${tab == 1 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg2' rel="htl_lbg2"><span><a href="#" title="${g.message(code:'tab.jobInfo.label')}"><g:message code="tab.jobInfo.label"/></a></span></li>
            <li class="${tab == 2 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg3' rel="htl_lbg3"><span><a href="#" title="${g.message(code:'tab.jobDetails.label')}"><g:message code="tab.jobDetails.label" /></a></span></li>
            <li class="${tab == 3 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg4' rel="htl_lbg4"><span><a href="#" title="${g.message(code:'tab.product.label')}"><g:message code="tab.product.label" /></a></span></li>
            <li class="${tab == 4 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg5' rel="htl_lbg5"><span><a href="#" title="${viewable ? g.message(code:'tab.fieldTeam.label') : g.message(code:'tab.rateClass.label')}"><g:if test="${viewable}"><g:message code="tab.fieldTeam.label"/></g:if><g:else><g:message code="tab.rateClass.label" /></g:else></a></span></li>
            <li class="${tab == 5 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg6' rel="htl_lbg6"><span><a href="#" title="${g.message(code:'tab.rider.label')}"><g:message code="tab.rider.label" /></a></span></li>
        </ul>
    </div>
</div>
<div class="skipnavanchor">
    <a name="skiptabnavHorz" id="skiptabnavHorz"></a>
</div>
<div class="primarytabs-container horizontal-tabs-container primarytabs-container-lightblue-gradient" id="htl_lbg_contentContainer">
    <div id="htl_lbg1" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.client.label"/>
        </p>
        <div style="overflow:hidden"><g:render template="/common/client" /></div>
    </div>
    <div id="htl_lbg2" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.jobInfo.label"/>
        </p>
        <div style="overflow:hidden"><g:render template="/common/jobInfo" /></div>
    </div>
    <div id="htl_lbg3" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.jobDetails.label"/>
        </p>
        <div style="overflow:hidden"><g:render template="/common/jobDetails" /></div>
    </div>
    <div id="htl_lbg4" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.product.label"/>
        </p>
        <div style="overflow:hidden">
            <g:render template="/common/productList" model="${[jobReport:jobReport]}"/>
        </div>
    </div>
    <div id="htl_lbg5" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:if test="${viewable}"><g:message code="tab.fieldTeam.label"/></g:if><g:else><g:message code="tab.rateClass.label" /></g:else>
        </p>
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
    <div id="htl_lbg6" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.rider.label"/>
        </p>
        <div style="overflow:hidden">
            <g:render template="/common/rider" />
        </div>
    </div>
</div>
<script type="text/javascript">
    var dynamictabs=new ddtabcontent("ul_htl_lbg", "htl_lbg_contentContainer");
    dynamictabs.setpersist(true);
    dynamictabs.setselectedClassTarget("link"); //"link" or "linkparent"
    dynamictabs.init();
    dynamictabs.expandit(${tab ? tab : 0});
</script>
