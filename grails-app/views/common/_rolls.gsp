<tr>
    <td>
        <g:hiddenField name="productInfo[${idx}].rolls[${cnt}].toBeRemoved" value="false"/>
        <g:hiddenField name="productInfo[${idx}].rolls[${cnt}].id" value="${roll?.id}"/>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].rolls['+cnt+'].rollNumber','contentframework-required-highlight')}"
                name="productInfo[${idx}].rolls[${cnt}].rollNumber"
                size="12"
                value="${roll?.rollNumber}"/>
    </td>
    <td>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].rolls['+cnt+'].quantity','contentframework-required-highlight')}"
                name="productInfo[${idx}].rolls[${cnt}].quantity"
                size="5"
                value="${roll?.quantity}"
                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
    </td>
    <td>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].rolls['+cnt+'].width','contentframework-required-highlight')}"
                name="productInfo[${idx}].rolls[${cnt}].width"
                size="5"
                value="${roll?.width}"
                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
    </td>
    <td>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].rolls['+cnt+'].length','contentframework-required-highlight')}"
                name="productInfo[${idx}].rolls[${cnt}].length"
                size="5"
                value="${roll?.length}"
                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
    </td>
    <td>
        <g:textField
                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].rolls['+cnt+'].description','contentframework-required-highlight')}"
                name="productInfo[${idx}].rolls[${cnt}].description"
                size="30"
                value="${roll?.description}"/>
    </td>
    <td>
        <asset:image src="icons/delete.png"
                     style="width:16px;height:16px;"
                     onclick="removeRow(\$(this), \$('input[name=\\'productInfo[${idx}].rolls[${cnt}].toBeRemoved\\']'));" />
    </td>
</tr>