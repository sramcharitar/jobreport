<html>
<head>
    <meta name="layout" content="main" />
    <title><g:message code="application.login.title" default="Job Report Login"/></title>
</head>
<body>
<a name="top" id="top"></a>
<div class="skipnav">
    <a href="#skipheadernav"><g:message code="skip.tab.navigation"/></a>
</div>
<div id="wrapper">
    <!-- Global Header -->
    <g:render template="/layouts/secureHeadingLoginRequired" />
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
            <h1 id="pagetitle">
                <g:message code="application.passwordReset.title" />
            </h1>
        </div>
        <!-- Main Column Content -->
        <div class="divider-dash">&nbsp;</div>
        <div class="contentframework-container-primary">
            <div class="contentframework-container-content">
                <g:message code="chbUser.password.reset.confirm.message"/>
            </div>
        </div>
    </div>
    <!-- Global Footer -->
    <g:render template="/layouts/footer" />
</div>
</body>
</html>