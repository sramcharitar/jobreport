<div class="w3-row w3-bar">
    <a href="javascript:void(0)" onclick="opentab(event, 'workdetails');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding w3-border-blue"><strong><g:message code="tab.workDetails.label"/></strong></div>
    </a>
    <a href="javascript:void(0)" onclick="opentab(event, 'product');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.product.label" /></strong></div>
    </a>
    <a href="javascript:void(0)" onclick="opentab(event, 'timesheet');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.timeSheet.label"/></strong></div>
    </a>
    <a href="javascript:void(0)" onclick="opentab(event, 'expenses');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.expenses.label"/></strong></div>
    </a>
    <a href="javascript:void(0)" onclick="opentab(event, 'signoff');drawSig();">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.signOff.label"/></strong></div>
    </a>
    <g:if test="${params.editMode}">
    <a href="javascript:void(0)" onclick="opentab(event, 'siteImages');">
        <div class="w3-third w3-bar-item tablink w3-bottombar w3-hover-light-grey w3-padding"><strong><g:message code="tab.images.label" /></strong></div>
    </a>
    </g:if>
</div>

<form name="updateReport" id="updateReport" action="/siteReport/${params.editMode?'update':'save'}" method="POST">
<g:hiddenField name="jobReport.id" value="${jobReport?.id}"/>
<g:hiddenField name="id" value="${siteReport?.id}"/>
<g:hiddenField name="owner.id" value="${sec.loggedInUserInfo(field: 'id')}"/>
<div id="workdetails" class="w3-container tabbedContent" style="display:block">
    <g:render template="/siteReport/mobile/workDetails" />
</div>

<div id="product" class="w3-container tabbedContent" style="display:none">
    <g:render template="/siteReport/mobile/productList" />
</div>

<div id="timesheet" class="w3-container tabbedContent" style="display:none">
    <g:render template="/siteReport/mobile/timeSheet" />
</div>

<div id="expenses" class="w3-container tabbedContent" style="display:none">
    <g:render template="/siteReport/mobile/expenses" />
</div>

<div id="signoff" class="w3-container tabbedContent" style="display:none">
    <g:render template="/siteReport/mobile/signOff" />
</div>

</form>

<g:if test="${params.editMode}">
<div id="siteImages" class="w3-container tabbedContent" style="display:none">
    <g:render template="/siteReport/mobile/images" />
</div>

</g:if>
<g:render template="/siteReport/mobile/editButtons" />

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

    <g:if test="${params.tab?.toInteger() == 5}">
    //opentab(event, 'siteImages');
    </g:if>
</script>
