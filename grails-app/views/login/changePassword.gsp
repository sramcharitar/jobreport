<html>
<head>
    <meta name="layout" content="main" />
    <title><g:message code="application.passwordReset.title"/></title>
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
        <g:render template="/layouts/errorMsg" model="['objectInstance':chbUser]" />
        <g:form url="/login/updatePassword" method="POST" name="loginForm">
            <g:hiddenField name="spring-security-redirect" value="/jobReport/index"/>
            <g:hiddenField name="resetPassword" value="${params.upid}"/>
            <table class="contentframework">
                <tbody class="contentframework-stripedtable">
                <tr>
                    <th id="passwordResetForm" colspan="2" class="contentframework-dataheadertop contentframework-dataheadertop-empty">&nbsp;</th>
                </tr>
                <tr class="${hasErrors(bean:chbUser, field:'password', 'contentframework-required-cellhighlight')}">
                    <td headers="passwordFormHeader" class="contentframework-formdatalabel" width="25%">
                        <a name="anchor-password" id="anchor-password"></a>
                        <label for="password">
                            <span class="contentframework-negativeindent">
                                <b class="contentframework-required-asterisk">*</b>
                            </span>
                            <strong><g:message code="chbUser.newPassword.title" default="New Password"/>:</strong>
                        </label>
                        <g:hasErrors bean="${chbUser}" field="password">
                            <ul class="contentframework-required-description">
                                <li>
                                    <g:img dir="images/contentframework" file="icon-formerror.gif" alt="Error" class="contentframework-required-icon"/>
                                    <g:fieldError bean="${chbUser}" field="password" />
                                </li>
                            </ul>
                        </g:hasErrors>
                    </td>
                    <td headers="passwordFormFieldHeader">
                        <g:passwordField class="contentframework-textfield ${hasErrors(bean:chbUser, field:'password', 'contentframework-required-highlight')}" name="password" value="" />
                    </td>
                </tr>
                <tr>
                    <td headers="confirmPasswordFormHeader" class="contentframework-formdatalabel">
                        <a name="anchor-confirmPassword" id="anchor-confirmPassword"></a>
                        <label for="confirmPassword">
                            <span class="contentframework-negativeindent">
                                <b class="contentframework-required-asterisk">*</b>
                            </span>
                            <strong><g:message code="chbUser.confirmPassword.title" default="Confirm Password" />:</strong>
                        </label>
                    </td>
                    <td headers="confirmPasswordFieldFormHeader">
                        <g:passwordField class="contentframework-textfield" name="confirmPassword" value="" />
                    </td>
                </tr>
                </tbody>
            </table>
            <table class="contentframework">
                <tr>
                    <td>
                        <div style="float:right"><span class="button button-primary"><span>
                            <button type="submit" name="submit" >
                                <g:message code="default.button.submit.label" default="Submit"/>
                                <asset:image src="buttons/chevron.gif" alt="" width="12" height="12" />
                            </button>
                        </span></span></div>
                    </td>
                </tr>
            </table>
        </g:form>
    </div>
    <!-- Global Footer -->
    <g:render template="/layouts/footer" />
</div>
</body>
</html>