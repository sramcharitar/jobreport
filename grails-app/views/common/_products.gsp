<tr>
    <td>
        <table class="contentframework" style="width:100%" id="productsTable${idx}">
            <tbody>
                <tr>
                    <th class="contentframework-dataheadertop" scope="col">
                        <div style="float: left;"><strong><g:message code="productInfo.productInfo.title" /> ${idx.toInteger() + 1}</strong></div>
                        <g:if test="${idx.toInteger()>0}">
                        <div style="float:right;">
                            <asset:image src="icons/delete.png"
                                         style="width:16px;height:16px;"
                                         onclick="removeTable(\$('#productsTable${idx}'), \$('input[name=\\'productInfo[${idx}].toBeRemoved\\']'));" />
                        </div>
                        </g:if>
                    </th>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><g:message code="productInfo.productInfo.title"/></legend>
                            <table class="contentframework" style="width:100%;">
                                <colgroup>
                                    <col style="width: 40%;">
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <label for="productInfo[${cnt}].manufacturer"><g:message code="productInfo.manufacturer.label"/></label>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <label for="productInfo[${cnt}].description"><g:message code="productInfo.description.label"/></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <g:hiddenField name="productInfo[${idx}].toBeRemoved" value="false"/>
                                        <g:hiddenField name="productInfo[${idx}].id" value=""/>
                                        <g:textField
                                                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].manufacturer','contentframework-required-highlight')}"
                                                name="productInfo[${idx}].manufacturer"
                                                value="${product?.manufacturer}"
                                                size="30"/>
                                    </td>
                                    <td>
                                        <g:textField
                                                class="contentframework-textfield ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].description','contentframework-required-highlight')}"
                                                name="productInfo[${idx}].description"
                                                value="${product?.description}"
                                                size="40"/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><g:message code="productInfo.productInfo.title"/></legend>
                            <table class="contentframework" style="width:100%;">
                                <colgroup>
                                    <col style="width: 40%;">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="contentframework-formdatalabel">
                                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                            <label for="productInfo[${idx}].productDeliveryMethod.id"><g:message code="productInfo.productDeliveryMethod.label"/></label>
                                        </td>
                                        <td class="contentframework-formdatalabel">
                                            <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                            <label for="productInfo[${idx}].deliveryDate"><g:message code="productInfo.deliveryDate.label"/></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <g:select
                                                    class="contentframework-select ${hasErrors(bean:jobReport, field:'productInfo['+idx+'].productDeliveryMethod','contentframework-required-highlight')}"
                                                    name="productInfo[${idx}].productDeliveryMethod.id"
                                                    from="${jobreport.ProductDeliveryMethod.all}"
                                                    optionKey="id"
                                                    value="${product?.productDeliveryMethod?.id}"/>
                                        </td>
                                        <td>
                                            <g:textField class="contentframework-textfield deliveryDate${idx}" name="productInfo[${idx}].deliveryDate" value="${product?.deliveryDate ?: new Date()}" />
                                            <script>jQuery('.deliveryDate${idx}').datetimepicker({value:'${formatDate(date:product?.deliveryDate ?: new Date(), type:'date', style: 'short')}', format:'m/d/Y', step:60, timepicker:false});</script>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <th class="contentframework-dataheadertop" scope="col">
                        <div style="float:left;"><strong><g:message code="productInfo.rollInfo.title" /></strong></div>
                        <div class="contentframework" style="float: right">
                            <span class="button button-secondary">
                                <span>
                                    <button type="button" onclick="addProductRolls(${idx});">
                                        <g:message code="default.button.add.label" />
                                    </button>
                                </span>
                            </span>
                        </div>
                    </th>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><g:message code="productInfo.rollInfo.title"/></legend>
                            <table class="contentframework" id="rollDetailsTable${idx}" style="width:100%;">
                                %{--
                                <colgroup>
                                    <col style="width: 155px;">
                                    <col style="width: 115px;">
                                    <col style="width: 115px;">
                                    <col style="width: 115px;">
                                    <col>
                                    <col style="width: 20px;">
                                </colgroup>
                                --}%
                                <tbody>
                                <tr>
                                    <td class="contentframework-formdatalabel" id="rollNumber">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <g:message code="inventoryDetails.rollNumber.label"/>
                                    </td>
                                    <td class="contentframework-formdatalabel" id="quantity">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <g:message code="productInfo.quantity.label"/>
                                    </td>
                                    <td class="contentframework-formdatalabel" id="width">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <g:message code="productInfo.width.label"/> <span class="subcopy"><g:message code="default.inches.label"/></span>
                                    </td>
                                    <td nowrap="true" class="contentframework-formdatalabel" id="length">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <g:message code="productInfo.length.label"/> <span class="subcopy"><g:message code="default.linearFeet.label"/></span>
                                    </td>
                                    <td class="contentframework-formdatalabel" id="description">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <g:message code="productInfo.description.label"/>
                                    </td>
                                    <td></td>
                                </tr>
                                <g:if test="${product?.rolls?.size()>0}">
                                <g:each var="roll" status="n" in="${product?.rolls}">
                                    <g:render template="/common/rolls" model="${[roll:roll, cnt:n, idx:idx, jobReport:jobReport]}"/>
                                </g:each>
                                </g:if>
                                <g:else>
                                <tr>
                                    <td class="contentframework-formdatalabel">
                                        <g:hiddenField name="productInfo[${idx}].rolls[0].toBeRemoved" value="false"/>
                                        <g:hiddenField name="productInfo[${idx}].rolls[0].id" value=""/>
                                        <g:textField
                                                headers="rollNumber"
                                                class="contentframework-textfield ${hasErrors(bean:report, field:'productInfo['+idx+'].rolls[0].rollNumber','contentframework-required-highlight')}"
                                                name="productInfo[${idx}].rolls[0].rollNumber"
                                                size="12"
                                                value=""/>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <g:textField
                                                headers="quantity"
                                                class="contentframework-textfield ${hasErrors(bean:report, field:'productInfo['+idx+'].rolls[0].quantity','contentframework-required-highlight')}"
                                                name="productInfo[${idx}].rolls[0].quantity"
                                                size="5"
                                                value=""
                                                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <g:textField
                                                headers="width"
                                                class="contentframework-textfield ${hasErrors(bean:report, field:'productInfo['+idx+'].rolls[0].width','contentframework-required-highlight')}"
                                                name="productInfo[${idx}].rolls[0].width"
                                                size="5"
                                                value=""
                                                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <g:textField
                                                headers="length"
                                                class="contentframework-textfield ${hasErrors(bean:report, field:'productInfo['+idx+'].rolls[0].length','contentframework-required-highlight')}"
                                                name="productInfo[${idx}].rolls[0].length"
                                                size="5"
                                                value=""
                                                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <g:textField
                                                headers="description"
                                                class="contentframework-textfield ${hasErrors(bean:report, field:'productInfo['+idx+'].rolls[0].description','contentframework-required-highlight')}"
                                                name="productInfo[${idx}].rolls[0].description"
                                                size="30"
                                                value=""/>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <asset:image src="icons/delete.png"
                                                     style="width:16px;height:16px;"
                                                     onclick="removeRow(\$(this), \$('input[name=\\'productInfo[${idx}].rolls[0].toBeRemoved\\']'));" />
                                    </td>
                                </tr>
                                </g:else>
                                </tbody>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </tbody>
        </table>
        <g:javascript>
            var productRollRowCounter${idx} = ${ product?.rolls?.size() == 0 || !product?.rolls ? 1 : product?.rolls?.size() };
        </g:javascript>
    </td>
</tr>
