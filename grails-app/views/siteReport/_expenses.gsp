<div role="complementary" aria-label="Important Information">
    <div class="uos-msg uos-msg-need-to-know" tabindex="-1" id="need-to-know-message-code">
        <div class="uos-msg-header">
            <div class="uos-msg-header-align">
                <asset:image src="contentframework/spacer.gif" class="accessibility-overlay-50x50" alt="Important information follows" title="Important information follows" /> <span class="uos-msg-title"><g:message code="expenses.disclaimer.label"/></span>
            </div>
        </div>
        <div class="uos-msg-copy">
            <g:message code="expenses.disclaimer.info"/>
        </div>
    </div>
</div>
<table id="expenseTable" class="contentframework" style="width:100%;">
    <tbody class="contentframework-stripedtable">
    <tr>
        <th nowrap="true" class="contentframework-dataheadertop" scope="col" colspan="6">
            <div style="float:left;"><strong><g:message code="tab.expenses.label" /></strong></div>
            <div class="contentframework" style="float: right">
                <span class="button button-secondary">
                    <span>
                        <button type="button" onclick="addExpenseRow($('#jobReport\\.id').val(), '/siteReport/expenseItem', $('#expenseTable'), 'expenses')">
                            <g:message code="default.button.add.label" />
                        </button>
                    </span>
                </span>
            </div>
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
        <th class="contentframework-dataheadertop" scope="col"></th>
    </tr>
    <g:each var="item" status="i" in="${siteReport?.expenses}">
        <g:render template="expenseItem" model="${[i:i, jobReport:jobReport, item:item]}"/>
    </g:each>
    </tbody>
</table>
<script>
    var expenseRowCounter = ${siteReport?.expenses?.size() ?: 0};
</script>