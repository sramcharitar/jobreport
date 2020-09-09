<tr>
    <td>
        <g:hiddenField name="workDetials[${cnt}].id" value="${detail?.id}" />
        <g:hiddenField name="workDetails[${cnt}].toBeRemoved" value="false"/>
        <g:select
                class="contentframework-select ${hasErrors(bean:jobReport, field:'workDetails['+cnt+'].workTypes','contentframework-required-highlight')}"
                name="workDetails[${cnt}].workTypes.id"
                from="${jobreport.WorkTypes.all}"
                optionKey="id"
                value="${detail?.workTypes?.id}"
                noSelection="${['null':'Select One...']}"/>
    </td>
    <td>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'workDetails['+cnt+'].quantity','contentframework-required-highlight')}"
                name="workDetails[${cnt}].quantity"
                size="5"
                value="${detail?.quantity}"/>
    </td>
    <td>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'workDetails['+cnt+'].width','contentframework-required-highlight')}"
                name="workDetails[${cnt}].width"
                size="5"
                value="${detail?.width}"/>
    </td>
    <td>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'workDetails['+cnt+'].length','contentframework-required-highlight')}"
                name="workDetails[${cnt}].length"
                size="5"
                value="${detail?.length}"/>
    </td>
    <td>
        <g:checkBox
                class="${hasErrors(bean:detail, field:'wetGlaze','contentframework-required-highlight')}"
                name="workDetails[${cnt}].wetGlaze"
                value="true"
                checked="${detail?.wetGlaze == true}"/>
    </td>
    <td>
        <g:checkBox
                class="${hasErrors(bean:detail, field:'gullWing','contentframework-required-highlight')}"
                name="workDetails[${cnt}].gullWing"
                value="true"
                checked="${detail?.gullWing == true}"/>
    </td>
    <td>
        <g:checkBox
                class="${hasErrors(bean:detail, field:'frameGuard','contentframework-required-highlight')}"
                name="workDetails[${cnt}].frameGuard"
                value="true"
                checked="${detail?.frameGuard == true}"/>
    </td>
    <td>
        <asset:image src="icons/delete.png"
                     style="width:16px;height:16px;"
                     onclick="removeRow(\$(this), \$('input[name=\\'workDetails[${cnt}].toBeRemoved\\']'));" />
    </td>
</tr>