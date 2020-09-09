<div class="skipnav">
    <a href="#skiptabnavHorz"><g:message code="skip.tab.navigation"/></a>
</div>
<div class="primarytabs clear">
    <div class="primarytabs-level1 clear">
        <ul id="ul_htl_lbg">
            <li class="${tab == 0 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg1' rel="htl_lbg1"><span><a href="#" title="${g.message(code:'tab.workDetails.label')}"><g:message code="tab.workDetails.label"/></a></span></li>
            <li class="${tab == 1 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg2' rel="htl_lbg2"><span><a href="#" title="${g.message(code:'tab.product.label')}"><g:message code="tab.product.label" /></a></span></li>
            <li class="${tab == 2 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg3' rel="htl_lbg3"><span><a href="#" title="${g.message(code:'tab.fieldTeam.label')}"><g:message code="tab.timeSheet.label" /></a></span></li>
            <li class="${tab == 3 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg4' rel="htl_lbg4"><span><a href="#" title="${g.message(code:'tab.expenses.label')}"><g:message code="tab.expenses.label" /></a></span></li>
            <li class="${tab == 4 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg5' rel="htl_lbg5"><span><a href="#" title="${g.message(code:'tab.signOff.label')}" onclick="drawSig()"><g:message code="tab.signOff.label" /></a></span></li>
            <g:if test="${params.editMode}">
            <li class="${tab == 5 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg6' rel="htl_lbg6"><span><a href="#" title="${g.message(code:'tab.images.label')}"><g:message code="tab.images.label" /></a></span></li>
            </g:if>
            <li class="${tab == 6 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg7' rel="htl_lbg7"><span><a href="#" title="${g.message(code:'tab.notes.label')}"><g:message code="tab.notes.label" /></a></span></li>
        </ul>
    </div>
</div>
<div class="skipnavanchor">
    <a name="skiptabnavHorz" id="skiptabnavHorz"></a>
</div>
<div class="primarytabs-container horizontal-tabs-container primarytabs-container-lightblue-gradient" id="htl_lbg_contentContainer">
    <form name="updateReport" id="updateReport" action="/siteReport/${params.editMode?'update':'save'}" method="POST">
        <g:hiddenField name="jobReport.id" value="${jobReport?.id}"/>
        <g:hiddenField name="id" value="${siteReport?.id}"/>
        <g:hiddenField name="owner.id" value="${sec.loggedInUserInfo(field: 'id')}"/>
        <div id="htl_lbg1" class="primarytabs-tabbedcontent" tabindex="-1">
            <p class="primarytabs-tabbedcontenttitle">
                <g:message code="you.are.on"/>:<g:message code="tab.workDetails.label"/>
            </p>
            <div id="workDetailsInfo" style="overflow:hidden">
                <g:render template="/siteReport/workDetails" model="${[jobReport:jobReport]}"/>
            </div>
            <div id="workDetailEntry" style="display: none"></div>
        </div>
        <div id="htl_lbg2" class="primarytabs-tabbedcontent" tabindex="-1">
            <p class="primarytabs-tabbedcontenttitle">
                <g:message code="you.are.on"/>:<g:message code="tab.product.label"/>
            </p>
            <div style="overflow:hidden"><g:render template="/siteReport/productList" /></div>
        </div>
        <div id="htl_lbg3" class="primarytabs-tabbedcontent" tabindex="-1">
            <p class="primarytabs-tabbedcontenttitle">
                <g:message code="you.are.on"/>:<g:message code="tab.timeSheet.label"/>
            </p>
            <div style="overflow:hidden">
                <g:render template="/siteReport/timeSheet" />
            </div>
        </div>
        <div id="htl_lbg4" class="primarytabs-tabbedcontent" tabindex="-1">
            <p class="primarytabs-tabbedcontenttitle">
                <g:message code="you.are.on"/>:<g:message code="tab.expenses.label"/>
            </p>
            <div style="overflow:hidden">
                <g:render template="/siteReport/expenses" />
            </div>
        </div>
        <div id="htl_lbg5" class="primarytabs-tabbedcontent" tabindex="-1">
            <p class="primarytabs-tabbedcontenttitle">
                <g:message code="you.are.on"/>:<g:message code="tab.signOff.label"/>
            </p>
            <div style="overflow:hidden">
                <g:render template="/siteReport/signOff" />
            </div>
        </div>
        <div id="htl_lbg7" class="primarytabs-tabbedcontent" tabindex="-1">
            <p class="primarytabs-tabbedcontenttitle">
                <g:message code="you.are.on"/>:<g:message code="tab.notes.label"/>
            </p>
            <div style="overflow:hidden">
                <g:render template="/siteReport/notes" />
            </div>
        </div>
    </form>
    <g:if test="${params.editMode}">
        <div id="htl_lbg6" class="primarytabs-tabbedcontent" tabindex="-1">
            <p class="primarytabs-tabbedcontenttitle">
                <g:message code="you.are.on"/>:<g:message code="tab.images.label"/>
            </p>
            <div style="overflow:hidden">
                <g:render template="/siteReport/images" />
            </div>
        </div>
    </g:if>
</div>
<script type="text/javascript">
    var dynamictabs=new ddtabcontent("ul_htl_lbg", "htl_lbg_contentContainer");
    dynamictabs.setpersist(true);
    dynamictabs.setselectedClassTarget("link"); //"link" or "linkparent"
    dynamictabs.init();
    dynamictabs.expandit(${tab ? tab : 0});
</script>
