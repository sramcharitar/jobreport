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
                <g:render template="/siteReport/mobile/tabs"  model="['jobReport':jobReport]"/>
            </div>
        </div>
    </body>
</html>