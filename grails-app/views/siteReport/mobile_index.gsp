<html>
    <head>
        <meta name="layout" content="mobile"/>
        <title><g:message code="application.name.title" default="CHB Job Report" /></title>
    </head>
    <body>

        <div class="w3-container" id="wrapper">

            <g:render template="/layouts/mobileSiteReportNav"/>
            <br>
            <h4><g:message code="projectSummary.page.title" /></h4>
            <g:render template="/siteReport/mobile/summaryTable" model="${[siteReportList:siteReportList]}"/>

        </div>

    </body>
</html>
