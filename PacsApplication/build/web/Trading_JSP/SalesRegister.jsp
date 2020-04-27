<%-- 
    Document   : SalesRegister
    Created on : May 5, 2016, 12:31:09 PM
    Author     : 590685
--%>

<%@page import="DataEntryBean.TradingSaleRegisterBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.pdsStockRegisterBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="LoginDb.DbHandler"%>


<html>

    <head>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
         <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode1.css" />
        <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
        <script>

            function noBack()
            {
                window.history.forward();
            }

            function submitform(tradingsaleregister)

            {
                //if (checkDiv(tradingsaleregister))
                //{
                    document.forms[0].handle_id.value = "checkStock";
                    document.forms[0].action = '/PacsApplication/TradingSaleRegisterServlet';
                    document.forms[0].submit();
                //}
            }

            function checkDiv(tradingsaleregister)
            {

                var itemCode = document.getElementById("itemCode").value;
                var itemName = document.getElementById("itemName").value;
               if (itemCode == "" || itemName == "") {

               alert("Fill The Required Fields");
                return false;
                }
                return true;

            }

            function Total(i) {

                var priceDetails = document.getElementById("price" + i).value;
                var quantityDetails = document.getElementById("quantity" + i).value;

                document.getElementById("total" + i).value = priceDetails * quantityDetails;

            }
        </script>
    </head>
    <body>

        <%          int count = 1;
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object alTradingSaleRegisterBeanApendObj = request.getAttribute("alTradingSaleRegisterBeanApend");
            ArrayList<TradingSaleRegisterBean> alTradingSaleRegisterBeanApend = new ArrayList<TradingSaleRegisterBean>();
            if (alTradingSaleRegisterBeanApendObj != null) {
                alTradingSaleRegisterBeanApend = (ArrayList<TradingSaleRegisterBean>) request.getAttribute("alTradingSaleRegisterBeanApend");
            }
        %>

        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>

        <jsp:include page="MenuHead_TRADING.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                Sales Register
            </legend>

            <form id="tradingsaleregister" name="tradingsaleregister" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                            <% }%>
                <br>
                <center>
                    <table>
                        <tbody>
                            <tr>
                                <td>Item Code:</td>
                                <td> <input type="text" id="itemCode" name="itemCode">&nbsp;&nbsp;&nbsp;<input type="button" name="productSearch" id="productSearch" value="Search" onclick="javascript:popup_product(420, 180, document.getElementById('itemCode').value, document.getElementById('itemName').value);"/></td>

                            </tr><tr>

                                <td>Item Name:</td>
                                <td> <input type="text" id="itemName" name="itemName">&nbsp;&nbsp;&nbsp;<input type="button" name="productSearch" id="productSearch" value="Search" onclick="javascript:popup_product(420, 180, document.getElementById('itemCode').value, document.getElementById('itemName').value);"/></td>
                        <input type="hidden" id="productId" name="productId">
                         <input type="hidden" id="sellId" name="sellId">
                        </tr>


                        </tbody>
                    </table>

                </center>
                <br>
                <center>

                    <input type="button" value="Submit" onclick="javascript:submitform(tradingsaleregister);"/>
                    <input type="button" value="Reset" onclick="ShowParent();" />


                </center>
                <br>

                <br>
                <%if (displayFlag.equalsIgnoreCase("Y")) {%>
                <center>
                    <table id="order-listAmend" style="margin-left: 90px; overflow-y: scroll" border="1.5" >
                        <thead  class="CSSTableGenerator1" >
                            <tr>

                                <td style="text-align:center;"> <b>Member ID</b>  </td>
                                <td style="text-align:center;"> <b>Member Name</b>  </td>
                                <td style="text-align:center;"> <b>Stock ID</b>  </td>
                                <td style="text-align:center;"> <b>Quantity</b>  </td>
                                <td style="text-align:center;"> <b>Price</b>  </td>
                                <td style="text-align:center;"> <b>Total</b>  </td>
                                <td style="text-align:center;"> <b>Sale Date</b>  </td>

                            </tr>
                        </thead>
                        <tbody style="background-color: white; font-size: 15px">
                            <%
                                TradingSaleRegisterBean oTradingSaleRegisterBeanApend = new TradingSaleRegisterBean();

                                for (int i = 0; i < alTradingSaleRegisterBeanApend.size(); i++) {
                                    oTradingSaleRegisterBeanApend = alTradingSaleRegisterBeanApend.get(i);
                            %>
                            <tr>

                                <td style="text-align:center;"><input type="text" value="<%=oTradingSaleRegisterBeanApend.getMemberId()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=oTradingSaleRegisterBeanApend.getMemberName()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=oTradingSaleRegisterBeanApend.getStockId()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=oTradingSaleRegisterBeanApend.getQuantity()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=oTradingSaleRegisterBeanApend.getPrice()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=oTradingSaleRegisterBeanApend.getTotal()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=oTradingSaleRegisterBeanApend.getSaleDate()%>" readonly="true"></td>

                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </center>
                <%}%>

                <input type="hidden" name="handle_id" value="" />
            </form>
            <script>




                function ShowCalender(i) {

                    getCalendar(document.getElementById("purchaseDate" + i));
                }

                function popup_product(width, height, itemCode, itemName)
                {

                    if (window.innerWidth) {
                        LeftPosition = (window.innerWidth - width) / 2;
                        TopPosition = ((window.innerHeight - height) / 2) - 20;
                    }
                    else {
                        LeftPosition = (parseInt(window.screen.width) - width) / 2;
                        TopPosition = ((parseInt(window.screen.height) - height) / 2) - 20;
                    }
                    attr = 'resizable=yes,scrollbars=yes,width=' + width + ',height=' +
                            height + ',screenX=300,screenY=200,left=' + LeftPosition + ',top=' +
                            TopPosition + '';
                    var screenName = "SalesRegister.jsp";
                    var lovKey = "TradingProductSearch"
                    popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?itemCode=' + itemCode + '&itemName=' + itemName + '&screenName=' + screenName + '&lovKey=' + lovKey, 'TradingProductSearch', attr);
                    popWin.focus();

                }

                function ShowParent()
                {
                    document.forms[0].action = "/PacsApplication/Trading_JSP/SalesRegister.jsp";
                    document.forms[0].submit();
                }


            </script>
        </fieldset>
    </body>
</html>
