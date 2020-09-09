
    <div id="mainnav-level1" class="clear">
        <ul>
            <sec:ifAnyGranted roles="ROLE_PRINCIPAL, ROLE_ADMIN">
            <g:if test="${nav=='summary'}">
                <li class="mainnav-level1-currentpage">
                    <asset:image class="mainnav-level1-screenreaderimage" src="navigation/mainnav/screenreaderimage.gif" alt="${g.message(code:'you.are.on')}:" />
                    <span>
                        <g:link controller="jobReport" action="index"><g:message code="navigation.summary.label"/></g:link>
                    </span>
                </li>
                <li class="mainnav-level1-rightofcurrentpage">
                    <asset:image class="mainnav-level1-screenreaderimage" src="navigation/mainnav/screenreaderimage.gif" alt="${g.message(code:'you.are.on')}:" />
                    <span>
                        <g:link controller="admin" action="index"><g:message code="navigation.admin.label"/></g:link>
                    </span>
                </li>
            </g:if>

            <g:if test="${nav=='admin'}">
                <li class="mainnav-level1-firstlink">
                    <asset:image class="mainnav-level1-screenreaderimage" src="navigation/mainnav/screenreaderimage.gif" alt="${g.message(code:'you.are.on')}:" />
                    <span>
                        <g:link controller="jobReport" action="index"><g:message code="navigation.summary.label"/></g:link>
                    </span>
                </li>
                <li class="mainnav-level1-currentpage">
                    <asset:image class="mainnav-level1-screenreaderimage" src="navigation/mainnav/screenreaderimage.gif" alt="${g.message(code:'you.are.on')}:" />
                    <span>
                        <g:link controller="admin" action="index"><g:message code="navigation.admin.label"/></g:link>
                    </span>
                </li>
            </g:if>
            </sec:ifAnyGranted>
        </ul>
    </div>
