<tr>
    <td><g:select     class="w3-select"
                      name="workDetailsCompleted[${i}].worker.id"
                      value=""
                      from="${jobReport.fieldTeam.worker}"
                      optionKey="id"
                      noSelection="${['null':g.message(code:'default.choose.label')]}" /></td>
    <td><g:textField  class="w3-input" name="workDetailsCompleted[${i}].qtyCompleted" size="5" value=""/></td>
    <td>
        <g:textField class="w3-input datecompleted${i}" name="workDetailsCompleted[${i}].dateCompleted" value="" />
        <script>jQuery('.datecompleted${i}').datetimepicker({value:new Date(), format:'m/d/Y H:i', step:60});</script>
    </td>
    <td>
        <g:textField class="w3-input" name="workDetailsCompleted[${i}].notes"  value=""/>
        <g:hiddenField name="workDetailsCompleted[${i}].workDetails.id" value="${detail.id}"/>
        <g:hiddenField name="workDetailsCompleted[${i}].toBeRemoved" value="false"/>
    </td>
    <td style="text-align: right">
        <i class="fa fa-trash"
           style="font-size:24px"
           onmouseover="$(this).css('cursor','pointer');"
           onclick="removeRow($(this), $('input[name=\'workDetailsCompleted[${i}].toBeRemoved\']'));"></i>
    </td>
</tr>