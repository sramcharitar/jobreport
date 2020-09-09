
<table id="expenseTable" class="contentframework" style="width:100%;">
    <tbody class="contentframework-stripedtable">
    <tr>
        <th nowrap="true" class="contentframework-dataheadertop" scope="col" colspan="6">
            <div style="float:left;"><strong><g:message code="tab.expenses.label" /></strong></div>
        </th>
    </tr>
    <tr>
        <th nowrap="true" class="contentframework-dataheadertop" scope="col">
            <strong><g:message code="fieldTeam.fieldAgent.title"/></strong>
        </th>
        <th nowrap="true" class="contentframework-dataheadertop" scope="col">
            <strong><g:message code="expenses.item.title"/></strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><g:message code="expenses.amount.label" /></strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><g:message code="expenses.paymentType.label" /></strong>
        </th>
        <th class="contentframework-dataheadertop" scope="col">
            <strong><g:message code="expenses.note.label" /></strong>
        </th>
    </tr>
    <g:each var="item" status="i" in="${siteReport?.expenses}">
        <g:render template="/siteReport/expenseItemShow" model="${[i:i, jobReport:jobReport, item:item]}"/>
    </g:each>
    </tbody>
</table>