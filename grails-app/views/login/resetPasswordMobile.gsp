<!DOCTYPE html>
<html>
    <meta name="layout" content="mobile" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><g:message code="application.passwordReset.title" default="CHB User Password Reset"/></title>
    <asset:stylesheet src="w3.css" />
    <asset:link rel="icon" href="icons/favicon.ico" type="image/x-icon" />
    <asset:link rel="shortcut icon" href="icons/favicon.ico" />
    <asset:javascript src="application.js" />

    <body>

        <div class="w3-container">

            <div id="id01" class="w3-panel">

                <div class="w3-panel-content w3-card-4 w3-animate-zoom" style="max-width:600px">
                    <div class="w3-center">
                        <asset:image src="/imagery/login_avatar.png" alt="login" style="width:30%" class="w3-circle w3-margin-top"/>
                        <br>
                        <h2><g:message code="application.passwordReset.title"/></h2>
                    </div>

                    <g:form class="w3-container" controller="login" action="sendPasswordResetLink" method="POST">
                        <g:hiddenField name="spring-security-redirect" value="/siteReport/index"/>
                        <div class="w3-section">
                            <label><b><g:message code="chbUser.employeeId.title" default="Employee Id"/></b></label>
                            <g:textField class="w3-input w3-border w3-margin-bottom" name="username" value="" />
                            <label><b><g:message code="chbUser.emailAddress.title" default="Email Address" /></b></label>
                            <g:textField class="w3-input w3-border" name="emailAddress" value="" />
                            <button class="w3-button w3-block w3-green w3-section w3-padding" type="submit" name="_action_sendPasswordResetLink" >
                                <g:message code="default.button.submit.label" default="Submit"/>
                            </button>
                        </div>
                    </g:form>

                    <div class="w3-container w3-border-top w3-padding-16 w3-light-grey"></div>

                </div>
            </div>
        </div>

    </body>
</html>
