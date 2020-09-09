<tr class="subcopy">
    <td nowrap="true">
        <g:hiddenField name="timeSheet[${i}].id" value="${item?.id}" />
        <g:hiddenField name="timeSheet[${i}].toBeRemoved" value="false"/>
        <g:hiddenField name="timeSheet[${i}].siteReport.id" value="${item?.siteReport?.id}"/>
        <g:select name="timeSheet[${i}].worker.id"
                  from="${jobReport?.fieldTeam}"
                  value="${item?.worker?.id}"
                  optionKey="id"
                  noSelection="${['null':g.message(code:'default.choose.label')]}"/>
    </td>
    <td nowrap="true">
        <g:textField class="startdatetime${i}" name="timeSheet[${i}].startDateTime"
                      value="${item?.startDateTime ?: new Date()}"/>
        <script>jQuery('.startdatetime${i}').datetimepicker({value:'${formatDate(date:item?.startDateTime ?: new Date(), format: 'MM/dd/yyyy HH:mm:ss')}', format:'m/d/Y H:i', step:60});</script>
    </td>
    <td nowrap="">
        <g:textField class="enddatetime${i}" name="timeSheet[${i}].endDateTime"
                      value="${item?.endDateTime ?: new Date()}"/>
        <script>jQuery('.enddatetime${i}').datetimepicker({value:'${formatDate(date:item?.endDateTime ?: new Date(), format: 'MM/dd/yyyy HH:mm:ss')}', format:'m/d/Y H:i', step:60});</script>
    </td>
    <td style="text-align: center">
        <g:checkBox name="timeSheet[${i}].lunchBreak" value="true" checked="${item?.lunchBreak}" />
    </td>
    <td>
        <asset:image src="icons/delete.png"
                     style="width:16px;height:16px;"
                     onclick="removeRow(\$(this), \$('input[name=\\'timeSheet[${i}].toBeRemoved\\']'));" />
    </td>
</tr>