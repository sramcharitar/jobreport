<%@ page import="jobreport.ExpenseItems; jobreport.PaymentMethod" %>
<tr class="subcopy">
    <td nowrap="true">
        <g:hiddenField name="expenses[${i}].id" value="${item?.id}" />
        <g:hiddenField name="expenses[${i}].toBeRemoved" value="false"/>
        <g:hiddenField name="expenses[${i}].siteReport.id" value="${item?.siteReport?.id}"/>
        <g:select name="expenses[${i}].worker.id"
                  from="${jobReport?.fieldTeam.worker}"
                  value="${item?.worker?.id}"
                  optionKey="id"
                  noSelection="${['null':g.message(code:'default.choose.label')]}"/>
    </td>
    <td nowrap="true">
        <g:select name="expenses[${i}].expenseItemsEnum"
                  from="${ExpenseItems?.all}"
                  value="${item?.expenseItemsEnum}"
                  optionKey="itemEnum"
                  noSelection="${['null':g.message(code:'default.choose.label')]}"/>
    </td>
    <td>
        <g:textField  name="expenses[${i}].amount"
                      value="${item?.amount}"
                      size="10"
                      class=""
                      onkeypress="return percentOnly(event)"
                      onkeydown="return decimalPlaces(\$(this),event,4);"
                      onchange=""/>
    </td>
    <td>
        <g:select   name="expenses[${i}].paymentMethodEnum"
                    value="${item?.paymentMethodEnum}"
                    from="${PaymentMethod.all}"
                    noSelection="${['null':g.message(code:'default.choose.label')]}"
                    optionKey="paymentMethodEnum"/>
    </td>
    <td>
        <g:textField  name="expenses[${i}].note"
                      value="${item?.note}"
                      size="30"
                      class=""/>
    </td>
    <td>
        <asset:image src="icons/delete.png"
                     style="width:16px;height:16px;"
                     onclick="removeRow(\$(this), \$('input[name=\\'expenses[${i}].toBeRemoved\\']'));" />
    </td>
</tr>