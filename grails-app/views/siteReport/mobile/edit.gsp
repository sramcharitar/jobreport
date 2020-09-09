<html>
    <head>
        <meta name="layout" content="mobile" />
        <title><g:message code="application.name.title" default="Job Report"/></title>
    </head>
    <body>
        <div class="w3-container" id="wrapper">
            <g:render template="/layouts/mobileSiteReportNav" />
            <br>
            <div id="formInfo" class="w3-container">
                <div id="formInfo" class="clear">
                    <g:render template="/siteReport/mobile/siteReportTabs"  model="['jobReport':jobReport, 'tab':tab]"/>
                </div>
            </div>
        </div>
    </body>
</html>