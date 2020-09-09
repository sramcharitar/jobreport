<g:if test="${isMobile}">
    <g:if test="${resetLinkConfirmation}">
        <g:render template="sendPasswordLinkConfirmationMobile"/>
    </g:if>
    <g:else>
        <g:render template="passwordConfirmationMobile"/>
    </g:else>
</g:if>
<g:else>
    <g:if test="${resetLinkConfirmation}">
        <g:render template="sendPasswordLinkConfirmation"/>
    </g:if>
    <g:else>
        <g:render template="passwordConfirmation"/>
    </g:else>
</g:else>