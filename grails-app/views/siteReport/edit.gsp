<html>
<head>
    <meta name="layout" content="main" />
    <title><g:message code="application.name.title" default="Site Report"/></title>
</head>
<body>
<a name="top" id="top"></a>
<div class="skipnav">
    <a href="#skipheadernav"><g:message code="skip.tab.navigation"/></a>
</div>
<div id="wrapper">
    <!-- Global Header -->
    <g:render template="/layouts/secureHeading" />
    <!-- Main Nav -->
    <div class="skipnavanchor"><a name="skipheadernav" id="skipheadernav"></a></div>
    <div id="layout" class="clear">
        <!-- Page Title -->
        <div id="pagetitlearea" class="clear">
            <p id="pagetitle-tools">
                <span class="pagetitle-tool">
                    <a href="#" onclick="window.print()" class="linkedtextandicon">
                        <span>
                            <g:message code="application.print.title" default="Print"/>
                        </span>
                        <asset:image src="icons/print.gif" alt="" class="icon"  />
                    </a>
                </span>
            </p>
            <g:render template="/common/headingTitles"/>
        </div>
        <!-- Main Column Content -->
        <div class="divider-dash">&nbsp;</div>
        <g:render template="/layouts/errorMsg" model="['objectInstance':jobReport]" />
            <div id="formInfo" class="clear">
                <g:render template="/siteReport/siteReportTabs"  model="['siteReport':siteReport, 'jobReport':jobReport, 'tab':tab]"/>
                <g:render template="/siteReport/editButtons" />
            </div>
    </div>
    <!-- Global Footer -->
    <g:render template="/layouts/footer" />
</div>
</body>
</html>