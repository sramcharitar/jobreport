<div class="w3-panel w3-yellow">
    <div style="font-weight: bold">
        <g:message code="expenses.disclaimer.info"/>
    </div>
</div>
<table id="expenseTable" class="w3-table-all" style="width:100%;">
    <tbody>
    <tr>
        <th nowrap="true" scope="col" colspan="6">
            <div style="float:left;"><strong><g:message code="tab.expenses.label" /></strong></div>
            <div style="float: right">
                    <span>
                        <button class="w3-button w3-blue" type="button" onclick="addExpenseRow($('#jobReport\\.id').val(), '/siteReport/mobile/expenseItem', $('#expenseTable'), 'expenses')">
                            <g:message code="default.button.add.label" />
                        </button>
                    </span>
            </div>
        </th>
    </tr>
    <tr>
        <th nowrap="true" scope="col">
            <strong><g:message code="fieldTeam.fieldAgent.title"/></strong>
        </th>
        <th nowrap="true" scope="col">
            <strong><g:message code="expenses.item.title"/></strong>
        </th>
        <th scope="col">
            <strong><g:message code="expenses.amount.label" /></strong>
        </th>
        <th scope="col">
            <strong><g:message code="expenses.paymentType.label" /></strong>
        </th>
        <th scope="col">
            <strong><g:message code="expenses.note.label" /></strong>
        </th>
        <th scope="col"></th>
    </tr>
    <g:each var="item" status="i" in="${siteReport?.expenses}">
        <g:render template="mobile/expenseItem" model="${[i:i, jobReport:jobReport, item:item]}"/>
    </g:each>
    </tbody>
</table>
<script>
    var expenseRowCounter = ${siteReport?.expenses?.size() ?: 0};
</script>