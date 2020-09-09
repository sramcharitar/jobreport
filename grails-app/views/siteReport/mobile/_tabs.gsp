<div class="w3-row w3-bar">
    <a href="javascript:void(0)" onclick="opentab(event, 'rider');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding w3-border-blue"><strong><g:message code="tab.rider.label"/></strong></div>
    </a>
    <a href="javascript:void(0)" onclick="opentab(event, 'jobinfo');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.jobInfo.label" /></strong></div>
    </a>
    <a href="javascript:void(0)" onclick="opentab(event, 'sitereport');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.siteReports.label"/></strong></div>
    </a>
    <a href="javascript:void(0)" onclick="opentab(event, 'docs');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.docs.label"/></strong></div>
    </a>
</div>

<div id="rider" class="w3-container tabbedContent" style="display:block">
    <g:render template="/common/showRiderMobile" />
</div>

<div id="jobinfo" class="w3-container tabbedContent" style="display:none">
    <g:render template="/siteReport/mobile/show" />
</div>

<div id="sitereport" class="w3-container tabbedContent" style="display:none">
    <g:render template="/siteReport/mobile/reports" />
</div>

<div id="docs" class="w3-container tabbedContent" style="display:none">
    <g:render template="/common/showDocsMobile" />
</div>

<div class="w3-container w3-padding-16" style="float: right; clear:both;">
    <span>
        <button class="w3-button w3-light-gray" type="button" onclick="$(location).attr('href', '${createLink(controller:'jobReport', action: 'index')}')">
            <g:message code="default.button.close.label" />
        </button>
    </span>
</div>
<br>
<div class="w3-container w3-border-top w3-padding-16 w3-light-grey" style="clear: both;"></div>

<script type="text/javascript">
    function opentab(evt, tabname) {
        var i, x, tablinks;
        x = document.getElementsByClassName("tabbedContent");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablink");
        for (i = 0; i < x.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" w3-border-blue", "");
        }
        document.getElementById(tabname).style.display = "block";
        evt.currentTarget.firstElementChild.className += " w3-border-blue";
    }
</script>
