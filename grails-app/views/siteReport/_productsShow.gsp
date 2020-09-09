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
                                    <td class="contentframework-formdatalabel"><span id="productInfo.manufacturer">${product?.manufacturer}</span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo.description">${product?.description}</span></td>
                                    <td class="contentframework-formdatalabel">
                                        <span id="productInfo.productDeliveryMethod.id">
                                            ${product?.productDeliveryMethod}
                                        </span>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span id="productInfo.deliveryDate">
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
                                    <td class="contentframework-formdatalabel"><span id="productInfo.rolls.quantity">${roll.quantity}</span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo.rolls.width">${roll.width}</span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo.rolls.length">${roll.length}</span></td>
                                    <td class="contentframework-formdatalabel"><span id="productInfo.rolls.description">${roll.description}</span></td>
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
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"></b></span>
                                        <strong><g:message code="inventoryDetails.rollNumber.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="inventoryDetails.usedProduct.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="inventoryDetails.remainingProduct.label"/></strong>
                                    </td>
                                    <td class="contentframework-formdatalabel">
                                        <span class="contentframework-negativeindent"><b class="contentframework-required-asterisk"> </b></span>
                                        <strong><g:message code="inventoryDetails.status.label"/></strong>
                                    </td>
                                    <td></td>
                                </tr>
                                <g:if test="${product?.getRollsQty()>0}">
                                    <g:set var="rolls" value="${jobreport.InventoryDetails.findAllByProductInfo(product)}"/>
                                    <g:each var="roll" status="k" in="${rolls}">
                                        <tr>
                                            <td class="contentframework-formdatalabel">${roll?.rollNumber}</td>
                                            <td class="contentframework-formdatalabel">${roll?.usedProduct}</td>
                                            <td class="contentframework-formdatalabel">${roll?.remainingProduct}</td>
                                            <td class="contentframework-formdatalabel">${jobreport.InventoryStatus.findByStatusEnum(roll?.inventoryStatusEnum)}</td>
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
    </td>
</tr>