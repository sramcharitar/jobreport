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
                        <div class="contentframework-container-header clear">
                            <h3><g:message code="projectSummary.page.title" /></h3>
                            <sec:ifAnyGranted roles="ROLE_PRINCIPAL, ROLE_ADMIN, ROLE_ACCOUNTING, ROLE_ACCOUNT_MANAGER">
                            <div class="floatright">
                                <span class="button button-primary"><span>
                                    <button type="button" onclick="$(location).attr('href','${createLink(controller:'jobReport', action:'create')}');">
                                        <g:message code="jobReport.new.label" />
                                        <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" />
                                    </button>
                                </span></span>
                            </div>
                            </sec:ifAnyGranted>
                        </div>
                        <div class="contentframework-container-content" style="float:left;clear: both">
                            <p>
                            <g:if test="${calView}">
                                <a href="/jobReport/updateView?id=${sec.loggedInUserInfo(field: "id" )}&cal=false"><asset:image src="icons/list-view.png" width="24px" height="24px" title="List View"/></a>
                            </g:if>
                            <g:else>
                                <a href="/jobReport/updateView?id=${sec.loggedInUserInfo(field: "id" )}&cal=true"><asset:image src="calendar/calendar-view.png" width="24px" height="24px" title="Calendar View"/></a>
                            </g:else>
                            </p>
                        </div>
                        <div class="contentframework-container-content">
                            <g:if test="${calView}">
                                <div id='chb_calendar' style="clear:both"></div>
                            </g:if>
                            <g:else>
                                <g:render template="/jobReport/summaryTable" model="${[jobReportList:jobReportList, jobsCompletedList:jobsCompletedList]}"/>
                            </g:else>
                        </div>
                    </div>
                </div>
            </div>
            <g:render template="/layouts/footer" />
        </div>
    </body>
</html>
