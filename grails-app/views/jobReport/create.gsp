<html>
<head>
    <meta name="layout" content="main" />
    <title><g:message code="application.name.title" default="Job Report"/></title>
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
        <form name="createReport" action="/jobReport/save" method="POST" onsubmit="">
            <g:hiddenField name="id" value="${jobReport?.id}"/>
            <g:hiddenField name="owner.id" value="${sec.loggedInUserInfo(field: 'id')}"/>
            <div id="formInfo" class="clear">
                <g:render template="/jobReport/tabs"  model="['objectInstance':jobReport]"/>
                <div id="buttons" class="clear" style="float: right;">
                    <table class="contentframework">
                        <tbody>
                        <tr>
                            <div class="contentframework" style="float: right">
                                <span class="button button-primary">
                                    <span>
                                        <button type="submit">
                                            <g:message code="default.button.save.label" />
                                            <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" />
                                        </button>
                                    </span>
                                </span>
                            </div>
                            <div style="float:right">&nbsp;</div>
                            <div class="contentframework" style="float: right">
                                <span class="button button-secondary">
                                    <span>
                                        <button type="button" onclick="$(location).attr('href', '${createLink(controller:'jobReport', action: 'index')}')">
                                            <g:message code="default.button.cancel.label" />
                                        </button>
                                    </span>
                                </span>
                            </div>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </form>

    </div>
    <!-- Global Footer -->
    <g:render template="/layouts/footer" />
</div>
</body>
</html>