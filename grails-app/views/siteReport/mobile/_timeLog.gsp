<tr>
    <td nowrap="true">
        <g:hiddenField name="timeSheet[${i}].id" value="${item?.id}" />
        <g:hiddenField name="timeSheet[${i}].toBeRemoved" value="false"/>
        <g:hiddenField name="timeSheet[${i}].siteReport.id" value="${item?.siteReport?.id}"/>
        <g:select class="w3-select"
                  name="timeSheet[${i}].worker.id"
                  from="${jobReport?.fieldTeam?.collect{it?.worker}}"
                  value="${item?.worker?.worker?.id}"
                  optionKey="id"
                  noSelection="${['null':g.message(code:'default.choose.label')]}"/>
    </td>
    <td nowrap="true">
        <g:textField class="w3-input startdatetime${i}"
                     name="timeSheet[${i}].startDateTime"
                     value="${formatDate(date:item?.startDateTime ?: new Date(), format: 'MM/dd/yyy HH:mm')}"/>
        <script>jQuery('.startdatetime${i}').datetimepicker({value:'${formatDate(date:item?.startDateTime ?: new Date(), format: 'MM/dd/yyy HH:mm')}', format:'m/d/Y H:i', step:60});</script>
    </td>
    <td nowrap="">
        <g:textField class="w3-input enddatetime${i}"
                     name="timeSheet[${i}].endDateTime"
                     value="${formatDate(date:item?.endDateTime ?: new Date(), format: 'MM/dd/yyy HH:mm')}"/>
        <script>jQuery('.enddatetime${i}').datetimepicker({value:'${formatDate(date:item?.endDateTime ?: new Date(), format: 'MM/dd/yyy HH:mm')}', format:'m/d/Y H:i', step:60});</script>
    </td>
    <td style="text-align: center">
        <g:checkBox class="w3-check" name="timeSheet[${i}].lunchBreak" value="true" checked="${item?.lunchBreak}" />
    </td>
    <td>
        <i class="fa fa-trash"
           style="font-size:24px"
           onmouseover="$(this).css('cursor','pointer');"
           onclick="removeRow($(this), $('input[name=\'timeSheet[${i}].toBeRemoved\']'));"></i>
    </td>
</tr>