<table class="contentframework" id="productListTable">
    <tbody class="contentframework-stripedtable">
        <tr>
            <th class="contentframework-dataheadertop" scope="col">
                <div style="float:left"><strong><g:message code="productInfo.productList.title" /></strong></div>
                <div style="float:right">
                    <span class="button button-secondary">
                        <span>
                            <button type="button" onclick="addProducts();">
                                <g:message code="default.button.add.label" />
                            </button>
                        </span>
                    </span>
                </div>
            </th>
        </tr>
        <g:if test="${jobReport?.productInfo?.size()>0}">
            <g:each var="product" status="k" in="${jobReport?.productInfo}">
                <g:render template="/common/products" model="${[product:product, idx:k, jobReport:jobReport]}"/>
            </g:each>
        </g:if>
        <g:else>
            <g:render template="/common/products" model="${[product:new jobreport.ProductInfo(), idx:0, jobReport:jobReport]}" />
        </g:else>
    </tbody>
</table>
<script type="text/javascript">
    var productsCounter = ${!jobReport.productInfo ? 1 : jobReport.productInfo?.size()};
</script>
