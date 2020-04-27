<%-- 
    Document   : SellItemChallan
    Created on : Jul 21, 2016, 5:22:09 PM
    Author     : Tcs Help desk122
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
        <title>Sell Item Challan</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
        <script>

            function noBack()
            {
                window.history.forward();
            }

            function download() {

                document.forms[0].reportPath.value = "/Reports/Invoice.jasper";
                document.forms[0].reportName.value = "Invoice";
                document.forms[0].DOWNLOAD.value = "P";
                document.forms[0].action = '/PacsApplication/jasperReportServlet';
                document.forms[0].submit();

            }
            

       </script>

    </head>
    
    
    <body>

        <%          int count = 1;
            String error_msg = "";
            String govtProcId = "";
          
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
            Object govtProcIdObj = request.getAttribute("govtProcId");
            if (govtProcIdObj != null) {
                govtProcId = govtProcIdObj.toString();
            }
            

        %>

        <jsp:include page="MenuHead_GPS.jsp" flush="true" />
        <br>
<fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                Sell Item Challan
            </legend>

            <form id="invoice" name="validationform" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                            <% }%>
                <br>

                <div id="amend" style="display: block;">
                    <center>
                        <table>
                            <tr>
                                <td><p> Download The Challan</p></td>
                                <td><input type="button"  value="Download" onclick="javascript:download();" /></td>
                            </tr>
                        </table>
                </div>

                <br>
                <br>

                <input type="hidden" name="govtProcId" id="govtProcId" value="<%=govtProcId%>">
                <input type="hidden" name="reportPath" value=""/>
                <input type="hidden" name="reportName" value=""/>
                <input type="hidden" name="DOWNLOAD" value=""/>
            </form>

        </fieldset>
    </body>
</html>

