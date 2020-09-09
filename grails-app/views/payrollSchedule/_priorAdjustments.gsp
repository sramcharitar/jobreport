<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<div>
    <div class="contentframework-container-primary">
        <div class="contentframework-container-header clear">
            <table class="contentframework">
                <thead>
                <tr>
                    <th><strong><g:message code="chbUser.employee.title" default="Employee"/></strong></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <g:select name="chbEmployee"
                                  from="${jobreport.ChbUsers.list(sort:'firstName', order:'asc')}"
                                  optionKey="id"
                                  value="${params.chbEmployee}"
                                  noSelection="['null':'Select Employee']"
                                  onchange="priorAdjustmentsForEmployee(\$(this).children('option:selected').val(), event);"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="contentframework-container-content employeePriorAdjustmentList">

        </div>

    </div>
</div>