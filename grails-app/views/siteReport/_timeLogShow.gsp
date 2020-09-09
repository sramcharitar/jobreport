<tr class="subcopy">
    <td nowrap="true">${item?.worker}</td>
    <td>
        <g:formatDate date="${item?.startDateTime}" type="datetime" style="medium" />
    </td>
    <td>
        <g:formatDate date="${item?.endDateTime}" type="datetime" style="medium" />
    </td>
    <td>
        <g:textField name="hourlyRate"
                     value="${g.formatNumber(number:item.hourlyRate, maxFractionDigits: 2, minFractionDigits: 2)}"
                     class="hourlyRate_${item.id} contentframework-textfield"
                     onchange="updateTimesheetHourlyRate(${item.id}, \$(this).val())"/>&nbsp;&nbsp;<span id="hourlyRateUpdateIndicator_${item.id}"></span>
    </td>
</tr>