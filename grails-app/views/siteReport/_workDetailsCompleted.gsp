<tr class="subcopy">
    <td><g:select     name="workDetailsCompleted[${i}].worker.id"
                      value=""
                      from="${jobReport.fieldTeam.worker}"
                      optionKey="id"
                      noSelection="${['null':g.message(code:'default.choose.label')]}" /></td>
    <td><g:textField  name="workDetailsCompleted[${i}].qtyCompleted" size="5" value=""/></td>
    <td><g:textField  class="datecompleted${i}" name="workDetailsCompleted[${i}].dateCompleted" value="" />
        <script>jQuery('.datecompleted${i}').datetimepicker({value:'${formatDate(date:new Date(), type:'date', style: 'medium')}', format:'m/d/Y', step:60, timepicker:false});</script>
    </td>
    <td>
        <g:checkBox
                name="workDetailsCompleted[${i}].highScaffold"
                value="true"
                checked="${false}"/>
    </td>
    <td>
        <g:textField  name="workDetailsCompleted[${i}].notes"  value=""/>
        <g:hiddenField name="workDetailsCompleted[${i}].workDetails.id" value="${detail.id}"/>
        <g:hiddenField class="workDetailsCompleted${i}toBeRemoved" name="workDetailsCompleted[${i}].toBeRemoved" value="false"/>
    </td>
    <td style="text-align: right">
        <asset:image src="icons/delete.png"
                     style="width:16px;height:16px;"
                     onclick="removeRow(\$(this), \$('.workDetailsCompleted${i}toBeRemoved'));" />
    </td>
</tr>