<div class="skipnav">
    <a href="#skiptabnavHorz"><g:message code="skip.tab.navigation"/></a>
</div>
<div class="primarytabs clear">
    <div class="primarytabs-level1 clear">
        <ul id="ul_htl_lbg">
            <li class="${tab == 0 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg1' rel="htl_lbg1"><span><a href="#" title="${g.message(code:'tab.timeSheet.label')}"><g:message code="tab.timeSheet.label" /></a></span></li>
            <li class="${tab == 1 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg2' rel="htl_lbg2"><span><a href="#" title="${g.message(code:'tab.specialHours.label')}"><g:message code="tab.specialHours.label"/></a></span></li>
            <li class="${tab == 2 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg3' rel="htl_lbg3"><span><a href="#" title="${g.message(code:'tab.priorAdjustments.label')}"><g:message code="tab.priorAdjustments.label"/></a></span></li>
        </ul>
    </div>
</div>
<div class="skipnavanchor">
    <a name="skiptabnavHorz" id="skiptabnavHorz"></a>
</div>
<div class="primarytabs-container horizontal-tabs-container primarytabs-container-lightblue-gradient" id="htl_lbg_contentContainer">
    <div id="htl_lbg1" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.timeSheet.label"/>
        </p>
        <div style="overflow:hidden">
            <g:render template="timeSheet" model="${[timeSheetWorkerList:timeSheetWorkerList, timeSheetList:timeSheetList, specialHoursList:specialHoursList, timeSheetList1:timeSheetList1, timeSheetList2:timeSheetList2, params:params,]}"/>
        </div>
    </div>
    <div id="htl_lbg2" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.specialHours.label"/>
        </p>
        <div style="overflow:hidden"><g:render template="specialHours" model="${[params:params, tab:1]}"/></div>
    </div>
    <div id="htl_lbg3" class="primarytabs-tabbedcontent" tabindex="-1">
        <p class="primarytabs-tabbedcontenttitle">
            <g:message code="you.are.on"/>:<g:message code="tab.priorAdjustments.label"/>
        </p>
        <div style="overflow:hidden"><g:render template="priorAdjustments" model="${[params:params, tab:2]}"/></div>
    </div>
</div>
<script type="text/javascript">
    var dynamictabs=new ddtabcontent("ul_htl_lbg", "htl_lbg_contentContainer");
    dynamictabs.setpersist(true);
    dynamictabs.setselectedClassTarget("link"); //"link" or "linkparent"
    dynamictabs.init();
    dynamictabs.expandit(${tab ? tab : 0});
</script>
