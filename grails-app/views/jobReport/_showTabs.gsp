<div class="skipnav">
    <a href="#skiptabnavHorz"><g:message code="skip.tab.navigation"/></a>
</div>
<div class="primarytabs clear">
    <div class="primarytabs-level1 clear">
        <ul id="ul_htl_lbg">
            <li class="${tab == 0 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg1' rel="htl_lbg1"><span><a href="#" title="${g.message(code:'tab.rider.label')}"><g:message code="tab.rider.label"/></a></span></li>
            <li class="${tab == 1 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg2' rel="htl_lbg2"><span><a href="#" title="${g.message(code:'tab.client.label')}"><g:fieldValue field="workOrderNumber" bean="${jobReport}"/></a></span></li>
            <li class="${tab == 2 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg3' rel="htl_lbg3"><span><a href="#" title="${g.message(code:'tab.siteReports.label')}"><g:message code="tab.siteReports.label"/></a></span></li>
            <li class="${tab == 3 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg4' rel="htl_lbg4"><span><a href="#" title="${g.message(code:'tab.docs.label')}"><g:message code="tab.docs.label"/></a></span></li>
        </ul>
    </div>
</div>
<div class="skipnavanchor">
    <a name="skiptabnavHorz" id="skiptabnavHorz"></a>
</div>
<div class="primarytabs-container horizontal-tabs-container primarytabs-container-lightblue-gradient" id="htl_lbg_contentContainer">
    <div id="htl_lbg1" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.rider.label"/>
        </p>
        <div style="overflow:hidden"><g:render template="/common/showRider" /></div>

    </div>
    <div id="htl_lbg2" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.client.label"/>
        </p>
        <div style="overflow:hidden"><g:render template="/common/show" /></div>

    </div>
    <div id="htl_lbg3" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.siteReports.label"/>
        </p>
        <div style="overflow:hidden">
            <g:if test="${enableInstallerOption}">
                <g:render template="/common/enable" />
            </g:if>
            <g:render template="/jobReport/siteReportsSummary" />
        </div>
    </div>
    <div id="htl_lbg4" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.docs.label"/>
        </p>
        <div style="overflow:hidden">
            <g:render template="/common/docs" />
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
