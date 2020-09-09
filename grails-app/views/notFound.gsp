<html>
<head>
    <meta name="layout" content="main"/>
    <title><g:message code="application.name.title" default="CHB Job Report" /></title>
</head>
<body>
<a name="top" id="top"></a>
<div class="skipnav"><a href="#skipheadernav"><g:message code="skip.tab.navigation"/></a></div>

<div id="wrapper">
    <g:render template="/layouts/secureHeading" />

    <div class="skipnavanchor"><a name="skipheadernav" id="skipheadernav"></a></div>

    <div id="layout" class="clear layout">

        <div id="pagetitlearea" class="clear">
            <p id="pagetitle-tools">
                <span class="pagetitle-tool">
                    <a href="#" onclick="window.print()" class="linkedtextandicon">
                        <span>
                            <g:message code="application.print.title" default="Print" />
                        </span>
                        <asset:image src="icons/print.gif" alt="" class="icon"  />
                    </a>
                </span>
            </p>
            <h1 id="pagetitle"><g:message code="page.notFound.title" /></h1>
        </div>
        <div class="divider-dash">&nbsp;</div>

        <div>
            <ul class="errors">
                <li>Error: Page Not Found (404)</li>
                <li>Path: ${request.forwardURI}</li>
            </ul>
        </div>
    </div>
    <g:render template="/layouts/footer" />
</div>
</body>
</html>
