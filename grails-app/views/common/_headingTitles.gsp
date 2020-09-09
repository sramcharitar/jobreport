<h1 id="pagetitle">
    <sec:ifAnyGranted roles="ROLE_PRINCIPAL, ROLE_ADMIN"><g:message code="dashboard.administration.title" /></sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ACCOUNTING"><g:message code="dashboard.accounting.title" /></sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ACCOUNT_MANAGER"><g:message code="dashboard.accountManager.title" /></sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_PROJECT_MANAGER"><g:message code="dashboard.projectManager.title" /></sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_FIELD_AGENT"><g:message code="dashboard.fieldAgent.title" /></sec:ifAnyGranted>
</h1>