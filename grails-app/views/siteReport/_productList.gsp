<table class="contentframework" id="productListTable" style="width: 100%;">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col">
                <div style="float:left"><strong><g:message code="productInfo.productList.title" /></strong></div>
            </th>
        </tr>
        <g:if test="${jobReport?.productInfo?.size()>0}">
            <g:set var="pIdx" value="0"/>
            <g:each var="product" status="k" in="${jobReport?.productInfo}">
                <g:render template="/siteReport/products" model="${[siteReport:siteReport, product:product, idx:k, pIdx:pIdx, jobReport:jobReport]}"/>
                <g:set var="pIdx" value="${pIdx.toInteger().plus(product.getRollsQty())}"/>
            </g:each>
        </g:if>
        <g:else>
            <g:render template="/siteReport/products" model="${[siteReport:siteReport, product:new jobreport.ProductInfo(), idx:0, pIdx:pIdx, jobReport:jobReport]}" />
        </g:else>
    </tbody>
</table>
<script type="text/javascript">
    var productsCounter = ${!jobReport.productInfo ? 1 : jobReport.productInfo?.size()};
</script>
