<%@ page import="jobreport.ExpenseItems; jobreport.PaymentMethod" %>
<tr>
    <td nowrap="true">
        <g:hiddenField name="expenses[${i}].id" value="${item?.id}" />
        <g:hiddenField name="expenses[${i}].toBeRemoved" value="false"/>
        <g:hiddenField name="expenses[${i}].siteReport.id" value="${item?.siteReport?.id}"/>
        <g:select class="w3-select"
                  name="expenses[${i}].worker.id"
                  from="${jobReport?.fieldTeam.worker}"
                  value="${item?.worker?.id}"
                  optionKey="id"
                  noSelection="${['null':g.message(code:'default.choose.label')]}"/>
    </td>
    <td nowrap="true">
        <g:select class="w3-select"
                  name="expenses[${i}].expenseItemsEnum"
                  from="${ExpenseItems?.all}"
                  value="${item?.expenseItemsEnum}"
                  optionKey="itemEnum"
                  noSelection="${['null':g.message(code:'default.choose.label')]}"/>
    </td>
    <td>
        <g:textField  class="w3-input"
                      name="expenses[${i}].amount"
                      value="${item?.amount}"
                      size="10"
                      onkeypress="return percentOnly(event)"
                      onkeydown="return decimalPlaces(\$(this),event,4);"
                      onchange=""/>
    </td>
    <td>
        <g:select   class="w3-select"
                    name="expenses[${i}].paymentMethodEnum"
                    value="${item?.paymentMethodEnum}"
                    from="${PaymentMethod.all}"
                    noSelection="${['null':g.message(code:'default.choose.label')]}"
                    optionKey="paymentMethodEnum"/>
    </td>
    <td>
        <g:textField  class="w3-input"
                      name="expenses[${i}].note"
                      value="${item?.note}"
                      size="30"/>
    </td>
    <td>
        <i class="fa fa-trash"
           style="font-size:24px"
           onmouseover="$(this).css('cursor','pointer');"
           onclick="removeRow($(this), $('input[name=\'expenses[${i}].toBeRemoved\']'));"></i>
    </td>
</tr>