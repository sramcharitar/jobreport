<%@ page import="jobreport.ExpenseItems; jobreport.PaymentMethod" %>
<tr class="subcopy">
    <td nowrap="true">${item?.worker}</td>
    <td nowrap="true">${jobreport.ExpenseItems.findByItemEnum(item?.expenseItemsEnum)}</td>
    <td>${item?.amount}</td>
    <td>${jobreport.PaymentMethod.findByPaymentMethodEnum(item?.paymentMethodEnum)}</td>
    <td>${item?.note}</td>
</tr>