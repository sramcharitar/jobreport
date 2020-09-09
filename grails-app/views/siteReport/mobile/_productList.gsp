<table class="w3-table-all" id="productListTable" style="width: 100%;">
    <thead>
    <tr>
        <th scope="col">
            <div style="float:left"><strong><g:message code="productInfo.productList.title" /></strong></div>
        </th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${jobReport?.productInfo?.size()>0}">
        <g:set var="pIdx" value="0"/>
        <g:each var="product" status="k" in="${jobReport?.productInfo}">
            <g:render template="mobile/products" model="${[product:product, idx:k, pIdx:pIdx, jobReport:jobReport]}"/>
            <g:set var="pIdx" value="${pIdx.toInteger().plus(product.getRollsQty())}"/>
        </g:each>
    </g:if>
    <g:else>
        <g:render template="mobile/products" model="${[product:new jobreport.ProductInfo(), idx:0, pIdx:pIdx, jobReport:jobReport]}" />
    </g:else>
    </tbody>
</table>
<script type="text/javascript">
    var productsCounter = ${!jobReport.productInfo ? 1 : jobReport.productInfo?.size()};
</script>
