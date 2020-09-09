<%@ page import="jobreport.InventoryStatus" %>
<tr>
    <td>
        <table class="contentframework" style="width: 100%;">
            <tbody>
                <tr>
                    <th class="contentframework-dataheadertop" scope="col">
                        <div><strong><g:message code="productInfo.productInfo.title" /></strong></div>
                    </th>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><g:message code="productInfo.productInfo.title"/></legend>
                            <table class="contentframework" style="width:100%;">
                                <colgroup>
                                    <col width="25%">
                                    <col width="25%">
                                    <col width="25%">
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.manufacturer.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.description.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.productDeliveryMethod.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.deliveryDate.label"/></strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="contentframework-formdatalabel"><span id="productInfo[${idx}].manufacturer">${product?.manufacturer}</span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo[${idx}].description">${product?.description}</span></td>
                                    <td class="contentframework-formdatalabel">
                                        <span id="productInfo[${idx}].productDeliveryMethod.id">
                                            ${product?.productDeliveryMethod}
                                        </span>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span id="productInfo[${idx}].deliveryDate">
                                            <g:formatDate date="${product?.deliveryDate}" type="date" style="MEDIUM"/>
                                        </span>
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
                            <legend><g:message code="productInfo.rollInfo.title"/></legend>
                            <table class="contentframework" style="width: 100%">
                                <tbody>
                                <tr>
                                    <colgroup>
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col>
                                    </colgroup>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.quantity.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.width.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.length.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="productInfo.description.label"/></strong>
                                    </td>
                                    <td></td>
                                </tr>
                                <g:if test="${product?.rolls?.size()>0}">
                                    <g:each var="roll" status="k" in="${product?.rolls}">
                                <tr>
                                    <td class="contentframework-formdatalabel"><span id="productInfo[${idx}].rolls.quantity">${roll.quantity}</span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo[${idx}].rolls.width">${roll.width} <g:message code="default.inches.label"/></span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo[${idx}].rolls.length">${roll.length} <g:message code="default.feet.label"/></span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo[${idx}].rolls.description">${roll.description}</span></td>
                                </tr>
                                    </g:each>
                                </g:if>
                                </tbody>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><g:message code="productInfo.rollInfo.title"/></legend>
                            <table class="contentframework" id="rollDetailsTable" style="width: 100%">
                                <tbody class="contentframework-stripedtable">
                                <tr>
                                    <colgroup>
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col>
                                    </colgroup>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <strong><g:message code="inventoryDetails.rollNumber.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <strong><g:message code="inventoryDetails.usedProduct.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <strong><g:message code="inventoryDetails.remainingProduct.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk">*</b></span>
                                        <strong><g:message code="inventoryDetails.status.label"/></strong>
                                    </td>
                                    <td></td>
                                </tr>
                                <g:if test="${product?.getRollsQty()>0}">
                                    <g:set var="existingInventory" value="${siteReport.inventoryDetails}"/>
                                    <g:set var="remainingInventory" value="${existingInventory ? product?.getRollsQty()?.minus(existingInventory?.size()) : product?.getRollsQty()}"/>
                                    <g:if test="${existingInventory}">
                                        <g:each var="roll" status="k" in="${existingInventory}">
                                            <g:if test="${roll}">
                                            <tr>
                                                <td class="contentframework-formdatalabel">
                                                    <g:textField
                                                            class="contentframework-textfield"
                                                            name="inventoryDetails[${k}].rollNumber"
                                                            size="20"
                                                            value="${roll?.rollNumber ?:''}"
                                                            onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                                </td>
                                                <td class="contentframework-formdatalabel">
                                                    <g:textField
                                                            class="contentframework-textfield"
                                                            name="inventoryDetails[${k}].usedProduct"
                                                            size="5"
                                                            value="${roll?.usedProduct>=0 ?roll?.usedProduct:''}"
                                                            onkeypress="return wholeNumbersOnlyNoComma(event)"/>&nbsp;
                                                    <g:message code="default.linearFeet.label"/>
                                                </td>
                                                <td class="contentframework-formdatalabel">
                                                    <g:textField
                                                            class="contentframework-textfield"
                                                            name="inventoryDetails[${k}].remainingProduct"
                                                            size="5"
                                                            value="${roll?.remainingProduct>=0 ?roll?.remainingProduct:''}"
                                                            onkeypress="return wholeNumbersOnlyNoComma(event)"/>&nbsp;
                                                    <g:message code="default.linearFeet.label"/>
                                                </td>
                                                <td class="contentframework-formdatalabel">
                                                    <g:select
                                                            class="contentframework-select"
                                                            from="${jobreport.InventoryStatus.all}"
                                                            name="inventoryDetails[${k}].inventoryStatusEnum"
                                                            noSelection="['null':'Select status']"
                                                            optionKey="statusEnumKey"
                                                            value="${roll?.inventoryStatusEnum ?:''}"/>
                                                    <g:hiddenField name="inventoryDetails[${k}].productInfo.id" value="${product.id}"/>
                                                </td>
                                            </tr>
                                            </g:if>
                                        </g:each>
                                    </g:if>
                                    <g:if test="${remainingInventory}">
                                        <g:set var="cnt" value="${existingInventory?.size()?existingInventory?.size()+1:0}"/>
                                        <g:each var="roll" status="k" in="${1..remainingInventory}">
                                            <tr>
                                                <td class="contentframework-formdatalabel">
                                                    <g:textField
                                                            class="contentframework-textfield"
                                                            name="inventoryDetails[${k.plus(cnt)}].rollNumber"
                                                            size="20"
                                                            value=""
                                                            onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                                </td>
                                                <td class="contentframework-formdatalabel">
                                                    <g:textField
                                                            class="contentframework-textfield"
                                                            name="inventoryDetails[${k.plus(cnt)}].usedProduct"
                                                            size="5"
                                                            value=""
                                                            onkeypress="return wholeNumbersOnlyNoComma(event)"/>&nbsp;
                                                    <g:message code="default.linearFeet.label"/>
                                                </td>
                                                <td class="contentframework-formdatalabel">
                                                    <g:textField
                                                            class="contentframework-textfield"
                                                            name="inventoryDetails[${k.plus(cnt)}].remainingProduct"
                                                            size="5"
                                                            value=""
                                                            onkeypress="return wholeNumbersOnlyNoComma(event)"/>&nbsp;
                                                    <g:message code="default.linearFeet.label"/>
                                                </td>
                                                <td class="contentframework-formdatalabel">
                                                    <g:select
                                                            class="contentframework-select"
                                                            from="${jobreport.InventoryStatus.all}"
                                                            name="inventoryDetails[${k.plus(cnt)}].inventoryStatusEnum"
                                                            noSelection="['null':'Select status']"
                                                            optionKey="statusEnumKey"
                                                            value=""/>
                                                    <g:hiddenField name="inventoryDetails[${k.plus(cnt)}].productInfo.id" value="${product.id}"/>
                                                </td>
                                            </tr>
                                        </g:each>
                                    </g:if>
                                </g:if>
                                </tbody>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </tbody>
        </table>
        <g:javascript>
            var productRollRowCounter${idx} = ${ product?.rolls?.size() == 0 ? 1 : product?.rolls?.size() };
        </g:javascript>
    </td>
</tr>