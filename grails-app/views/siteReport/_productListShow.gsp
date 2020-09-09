<table class="contentframework" id="productListTable" style="width: 100%;">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col">
                <div style="float:left"><strong><g:message code="productInfo.productList.title" /></strong></div>
            </th>
        </tr>
        <g:if test="${jobReport?.productInfo?.size()>0}">
            <g:each var="product" status="k" in="${jobReport?.productInfo}">
                <g:render template="/siteReport/productsShow" model="${[product:product, idx:k, jobReport:jobReport]}"/>
            </g:each>
        </g:if>
        <g:else>
            <g:render template="/siteReport/productsShow" model="${[product:new jobreport.ProductInfo(), idx:0, jobReport:jobReport]}" />
        </g:else>
    </tbody>
</table>
