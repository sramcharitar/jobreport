<html>
<head>
    <meta name="layout" content="main"/>
    <title><g:message code="application.name.title" default="CHB Job Report" /></title>
    <style>
    * {box-sizing: border-box}
    body {font-family: Verdana, sans-serif; margin:0}
    .mySlides {display: none}
    img {vertical-align: middle;}

    /* Slideshow container */
    .slideshow-container {
        max-width: 1000px;
        position: relative;
        margin: auto;
    }

    /* Next & previous buttons */
    .prev, .next {
        cursor: pointer;
        position: absolute;
        top: 50%;
        width: auto;
        padding: 16px;
        margin-top: -22px;
        color: white;
        font-weight: bold;
        font-size: 18px;
        transition: 0.6s ease;
        border-radius: 0 3px 3px 0;
    }

    /* Position the "next button" to the right */
    .next {
        right: 0;
        border-radius: 3px 0 0 3px;
    }

    /* On hover, add a black background color with a little bit see-through */
    .prev:hover, .next:hover {
        background-color: rgba(0,0,0,0.8);
    }

    /* Caption text */
    .text {
        color: #f2f2f2;
        font-size: 15px;
        padding: 8px 12px;
        position: absolute;
        bottom: 8px;
        width: 100%;
        text-align: center;
    }

    /* Number text (1/3 etc) */
    .numbertext {
        color: #f2f2f2;
        font-size: 12px;
        padding: 8px 12px;
        position: absolute;
        top: 0;
    }

    /* The dots/bullets/indicators */
    .dot {
        cursor: pointer;
        height: 15px;
        width: 15px;
        margin: 0 2px;
        background-color: #bbb;
        border-radius: 50%;
        display: inline-block;
        transition: background-color 0.6s ease;
    }

    .active, .dot:hover {
        background-color: #717171;
    }

    /* Fading animation */
    .fade {
        -webkit-animation-name: fade;
        -webkit-animation-duration: 1.5s;
        animation-name: fade;
        animation-duration: 1.5s;
    }

    @-webkit-keyframes fade {
        from {opacity: .4}
        to {opacity: 1}
    }

    @keyframes fade {
        from {opacity: .4}
        to {opacity: 1}
    }

    /* On smaller screens, decrease text size */
    @media only screen and (max-width: 300px) {
        .prev, .next,.text {font-size: 11px}
    }
    </style>
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
            <div class="skipnav">
                <a href="#skiptabnavHorz"><g:message code="skip.tab.navigation"/></a>
            </div>
            <div class="primarytabs clear">
                <div class="primarytabs-level1 clear">
                    <ul id="ul_htl_lbg">
                        <li class="${tab == 0 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg1' rel="htl_lbg1"><span><a href="#" title="${g.message(code:'tab.workDetails.label')}"><g:message code="tab.workDetails.label"/></a></span></li>
                        <li class="${tab == 1 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg2' rel="htl_lbg2"><span><a href="#" title="${g.message(code:'tab.product.label')}"><g:message code="tab.product.label" /></a></span></li>
                        <li class="${tab == 2 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg3' rel="htl_lbg3"><span><a href="#" title="${g.message(code:'tab.fieldTeam.label')}"><g:message code="tab.timeSheet.label" /></a></span></li>
                        <li class="${tab == 3 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg4' rel="htl_lbg4"><span><a href="#" title="${g.message(code:'tab.expenses.label')}"><g:message code="tab.expenses.label" /></a></span></li>
                        <li class="${tab == 4 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg5' rel="htl_lbg5"><span><a href="#" title="${g.message(code:'tab.signOff.label')}"><g:message code="tab.signOff.label" /></a></span></li>
                        <li class="${tab == 5 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg6' rel="htl_lbg6"><span><a href="#" title="${g.message(code:'tab.images.label')}"><g:message code="tab.images.label" /></a></span></li>
                        <li class="${tab == 6 ? 'sidetabs-currentpage primarytabs-currentpage':''}" id='li_htl_lbg7' rel="htl_lbg7"><span><a href="#" title="${g.message(code:'tab.notes.label')}"><g:message code="tab.notes.label" /></a></span></li>
                    </ul>
                </div>
            </div>
            <div class="skipnavanchor">
                <a name="skiptabnavHorz" id="skiptabnavHorz"></a>
            </div>
            <div class="primarytabs-container horizontal-tabs-container primarytabs-container-lightblue-gradient" id="htl_lbg_contentContainer">
                <div id="htl_lbg1" class="primarytabs-tabbedcontent" tabindex="-1">
                    <p class="primarytabs-tabbedcontenttitle">
                        <g:message code="you.are.on"/>:<g:message code="tab.workDetails.label"/>
                    </p>
                    <div style="overflow:hidden">
                        <g:render template="/siteReport/workDetailsShow" model="${[jobReport:jobReport]}"/>
                    </div>
                </div>
                <div id="htl_lbg2" class="primarytabs-tabbedcontent" tabindex="-1">
                    <p class="primarytabs-tabbedcontenttitle">
                        <g:message code="you.are.on"/>:<g:message code="tab.product.label"/>
                    </p>
                    <div style="overflow:hidden">
                        <g:render template="/siteReport/productListShow" />
                    </div>
                </div>
                <div id="htl_lbg3" class="primarytabs-tabbedcontent" tabindex="-1">
                    <p class="primarytabs-tabbedcontenttitle">
                        <g:message code="you.are.on"/>:<g:message code="tab.timeSheet.label"/>
                    </p>
                    <div style="overflow:hidden">
                        <g:render template="/siteReport/timeSheetShow" />
                    </div>
                </div>
                <div id="htl_lbg4" class="primarytabs-tabbedcontent" tabindex="-1">
                    <p class="primarytabs-tabbedcontenttitle">
                        <g:message code="you.are.on"/>:<g:message code="tab.expenses.label"/>
                    </p>
                    <div style="overflow:hidden">
                        <g:render template="/siteReport/expensesShow" />
                    </div>
                </div>
                <div id="htl_lbg5" class="primarytabs-tabbedcontent" tabindex="-1">
                    <p class="primarytabs-tabbedcontenttitle">
                        <g:message code="you.are.on"/>:<g:message code="tab.signOff.label"/>
                    </p>
                    <div style="overflow:hidden">
                        <g:render template="/siteReport/signOffShow" />
                    </div>
                </div>
                <div id="htl_lbg6" class="primarytabs-tabbedcontent" tabindex="-1">
                    <p class="primarytabs-tabbedcontenttitle">
                        <g:message code="you.are.on"/>:<g:message code="tab.images.label"/>
                    </p>
                    <div style="overflow:hidden">
                        <g:render template="/siteReport/imagesShow" />
                    </div>
                </div>
                <div id="htl_lbg7" class="primarytabs-tabbedcontent" tabindex="-1">
                    <p class="primarytabs-tabbedcontenttitle">
                        <g:message code="you.are.on"/>:<g:message code="tab.notes.label"/>
                    </p>
                    <div style="overflow:hidden">
                        <g:render template="/siteReport/notesShow" />
                    </div>
                </div>
            </div>
            <div class="contentframework" style="float: right">
                <span class="button button-secondary">
                    <span>
                        <button type="button" onclick="$(location).attr('href', '${createLink(controller:'jobReport', action: 'show', id:jobReport.id, params:['tab':2])}')">
                            <g:message code="default.button.close.label" />
                        </button>
                    </span>
                </span>
            </div>
        </div>
        <g:render template="/layouts/footer" />
    </div>
<script type="text/javascript">
    var dynamictabs=new ddtabcontent("ul_htl_lbg", "htl_lbg_contentContainer");
    dynamictabs.setpersist(true);
    dynamictabs.setselectedClassTarget("link"); //"link" or "linkparent"
    dynamictabs.init();
    dynamictabs.expandit(${tab ?: 0});
</script>
</body>
</html>

