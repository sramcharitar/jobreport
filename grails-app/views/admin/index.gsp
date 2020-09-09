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
                    <g:render template="/common/headingTitles"/>
                </div>
                <div class="divider-dash">&nbsp;</div>
                <div id="errorMsg"><g:render template="/layouts/errorMsg" /></div>
                <div>
                    <div class="contentframework-container-primary">
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                    </div>
                </div>
            </div>
            <g:render template="/layouts/footer" />
        </div>
    </body>
</html>
