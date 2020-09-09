<div id="globalheader" class="clear globalheader-secure">
    <div id="globalheader-logo">
        <a href="#">
            <asset:image src="logos/web/chb.png" alt="CHB Industries" height="47" />
        </a>
    </div>
    <!--
    <p id="globalheader-links">
        <asset:image
                src="icons/person.gif"
                alt="User Profile"
                title="${g.message(code:'chbUser.profile.title', default:'User Profile')}" />
    </p>
    -->
    <p id="globalheader-secureinfo">
        <span class="button button-secondary">
            <span>
                <a href="${createLink(controller: 'logout', action: 'index')}">
                    <g:message code="chbUser.logout.label" default="Logout"/>
                </a>
            </span>
        </span>
        <strong>
            <asset:image src="icons/secure.gif"
                         alt="Secure"
                         class="icon" />
            <a href="#">${jobreport.ChbUsers.findByUsername(sec.username())}</a>
        </strong>
    </p>
    <p id="globalheader-tools">
        <g:formatDate date="${new Date()}" type="datetime" style="MEDIUM" />
    </p>
</div>
<div id="mainnav">
    <g:render template="/layouts/level1" />
</div>