<g:hasErrors>
    <div role="complementary" aria-label="Error">
        <div class="uos-msg uos-msg-critical" tabindex="-1" id="critical-message-code">
            <div class="uos-msg-header">
                <div class="uos-msg-header-align">
                    <asset:image src="contentframework/spacer.gif"
                                 class="accessibility-overlay-50x50"
                                 alt="${g.message(code:'message.critical.title')}"
                                 title="${g.message(code:'message.critical.title')}" />
                    <span class="uos-msg-title">
                    <g:message code="message.critical.title" />
                    </span>
                </div>
            </div>
            <div class="uos-msg-copy">
                <p>
                    <g:message code="requiredInformation.missing" />
                </p>
                <ul>
                    <li>
                        <g:message code="message.validation.info"/>
                    </li>
                </ul>
                <ul>
                    <g:eachError>
                        <li><g:message error="${it}"/></li>
                    </g:eachError>
                </ul>
            </div>
        </div>
    </div>
</g:hasErrors>