<%@ page import="jobreport.InventoryStatus" %>
<tr>
    <td>
        <table class="w3-table-all" style="width: 100%;">
            <thead>
                <tr>
                    <th scope="col">
                        <div><strong><g:message code="productInfo.productInfo.title" /></strong></div>
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <fieldset>
                            <legend><g:message code="productInfo.productInfo.title"/></legend>
                            <table class="w3-table-all" style="width:100%;">
                                <colgroup>
                                    <col width="25%">
                                    <col width="25%">
                                    <col width="25%">
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td>
                                        <strong><g:message code="productInfo.manufacturer.label"/></strong>
                                    </td>
                                    <td>
                                        <strong><g:message code="productInfo.description.label"/></strong>
                                    </td>
                                    <td>
                                        <strong><g:message code="productInfo.productDeliveryMethod.label"/></strong>
                                    </td>
                                    <td>
                                        <strong><g:message code="productInfo.deliveryDate.label"/></strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span id="productInfo[${idx}].manufacturer">${product?.manufacturer}</span></td>
                                    <td><span id="productInfo[${idx}].description">${product?.description}</span></td>
                                    <td>
                                        <span id="productInfo[${idx}].productDeliveryMethod.id">
                                            ${product?.productDeliveryMethod}
                                        </span>
                                    </td>
                                    <td>
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
                            <table class="w3-table-all" style="width: 100%">
                                <tbody>
                                <tr>
                                    <colgroup>
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col>
                                    </colgroup>
                                    <td>
                                        <strong><g:message code="productInfo.quantity.label"/></strong>
                                    </td>
                                    <td>
                                        <strong><g:message code="productInfo.width.label"/></strong>
                                    </td>
                                    <td>
                                        <strong><g:message code="productInfo.length.label"/></strong>
                                    </td>
                                    <td>
                                        <strong><g:message code="productInfo.description.label"/></strong>
                                    </td>
                                    <td></td>
                                </tr>
                                <g:if test="${product?.rolls?.size()>0}">
                                    <g:each var="roll" status="k" in="${product?.rolls}">
                                <tr>
                                    <td><span id="productInfo[${idx}].rolls.quantity">${roll.quantity}</span></td>
                                    <td><span id="productInfo[${idx}].rolls.width">${roll.width}</span></td>
                                    <td><span id="productInfo[${idx}].rolls.length">${roll.length}</span></td>
                                    <td><span id="productInfo[${idx}].rolls.description">${roll.description}</span></td>
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
                            <table class="w3-table-all" id="rollDetailsTable" style="width: 100%">
                                <tbody>
                                <tr>
                                    <colgroup>
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col style="width: 25%;">
                                        <col>
                                    </colgroup>
                                    <td>
                                        <span><b>*</b></span>
                                        <strong><g:message code="inventoryDetails.rollNumber.label"/></strong>
                                    </td>
                                    <td>
                                        <span><b>*</b></span>
                                        <strong><g:message code="inventoryDetails.usedProduct.label"/></strong>
                                    </td>
                                    <td>
                                        <span><b>*</b></span>
                                        <strong><g:message code="inventoryDetails.remainingProduct.label"/></strong>
                                    </td>
                                    <td>
                                        <span><b>*</b></span>
                                        <strong><g:message code="inventoryDetails.status.label"/></strong>
                                    </td>
                                    <td></td>
                                </tr>
                                <g:if test="${product?.getRollsQty()>0}">
                                <g:set var="rolls" value="${jobreport.InventoryDetails.findByProductInfo(product) ?:[new jobreport.InventoryDetails()]}"/>
                                <g:each var="roll" status="k" in="${rolls}">
                                <tr>
                                    <td>
                                        <g:textField
                                                class="w3-input"
                                                name="inventoryDetails[${pIdx}].rollNumber"
                                                size="20"
                                                value="${roll?.rollNumber ?:''}"
                                                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                    </td>
                                    <td>
                                        <g:textField
                                                class="w3-input"
                                                name="inventoryDetails[${pIdx}].usedProduct"
                                                size="5"
                                                value="${roll?.usedProduct ?:''}"
                                                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                    </td>
                                    <td>
                                        <g:textField
                                                class="w3-input"
                                                name="inventoryDetails[${pIdx}].remainingProduct"
                                                size="5"
                                                value="${roll?.remainingProduct}"
                                                onkeypress="return wholeNumbersOnlyNoComma(event)"/>
                                    </td>
                                    <td>
                                        <g:select
                                                class="w3-select"
                                                from="${jobreport.InventoryStatusEnum.values()}"
                                                name="inventoryDetails[${pIdx}].inventoryStatusEnum"
                                                optionKey="key"
                                                value="${roll?.inventoryStatusEnum}"/>
                                        <g:hiddenField name="inventoryDetails[${pIdx}].productInfo.id" value="${product.id}"/>
                                    </td>
                                </tr>
                                </g:each>
                                </g:if>
                                </tbody>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </tbody>
        </table>
        <script type="text/javascript">
            var productRollRowCounter${idx} = ${product?.rolls.size() == 0 ? 1 : product?.rolls?.size() };
        </script>
    </td>
</tr>