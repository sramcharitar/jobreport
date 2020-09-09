<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<g:if test="${specialHoursList?.size()}">
    <table class="contentframework">
        <thead>
        <tr>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.date"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialType"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialHours"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.rate"/></strong></th>
            <th class="contentframework-dataheadertop" scope="col"><strong><g:message code="reports.label.specialAmount"/></strong></th>
        </tr>
        </thead>
        <tbody class="contentframework-stripedtable">
            <g:each in="${specialHoursList}" var="item" status="i">
                <tr class="contentframework-expandcollapserow">
                    <td colspan="6" class="contentframework-formdatalabel"><a onclick="toggleIcon('fieldAgent_${i}','fieldAgent_icon_${i}');return false" id="fieldAgent_icon_${i}" href="#" class="toggleiconlink"><asset:image src="contentframework/icon-collapse.gif" alt="Collapse" /><span class="toggleiconlink-label"><strong>${item?.employee}</strong></span></a></td>
                </tr>
                <g:each in="${item.details}" var="special" status="j">
                    <tr class="fieldAgent_${i}">
                        <td><g:formatDate type="date" date="${special?.date}" style="MEDIUM"/></td>
                        <td>${special?.typeEnum}</td>
                        <td><g:formatNumber number="${special?.hours}" minFractionDigits="2" minIntegerDigits="0"/></td>
                        <td><g:formatNumber number="${special?.rate}" type="currency"/></td>
                        <td><g:formatNumber number="${special?.pay}" type="currency"/></td>
                    </tr>
                </g:each>
            </g:each>
        </tbody>
    </table>
    <div><p>&nbsp;</p></div>
</g:if>