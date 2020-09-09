<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<html>
    <head>
        <meta name="layout" content="main"/>
        <title><g:message code="application.name.title" default="CHB Job Report" /></title>
        <script language="JavaScript">
            function timeSheetData(tId, event){
                event.preventDefault();
                this.blur(); // Manually remove focus from clicked link.
                $('#timeSheetData').modaal({
                    content_source: '#timeSheetData'
                });
                $.get('/payrollSchedule/timeSheetData?id='+tId, function(html) {
                    $("#timeSheetData").html(html);
                    stripe();
                    $("#timeSheetData").modaal('open');
                });
            }
        </script>
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

                <g:render template="tabs"  model="${[tab:tab]}"/>

            </div>
            <g:render template="/layouts/footer" />
        </div>
        <div id="timeSheetData" style="display:none;"></div>
    </body>
</html>
