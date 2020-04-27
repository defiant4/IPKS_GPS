<%-- 
    Document   : TradingStockRegister
    Created on : May 5, 2016, 12:31:09 PM
    Author     : 590685
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.TrandinStockRegisterBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="LoginDb.DbHandler"%>


<html>

    <head>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
        <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
        <script>



            function noBack()
            {
                window.history.forward();
            }
            function submitform(trendingstockregister)
            {
                if (checkDiv(trendingstockregister))
                {
                    document.forms[0].handle_id.value = "Create";
                    document.forms[0].action = '/PacsApplication/TradingStockRegisterServlet';
                    document.forms[0].submit();
                }
            }
            function searchStock(trendingstockregister)
            {
                var productId = document.getElementById("productName").value;
                if (productId == '') {
                    alert("Please Select Product");
                    return false;
                }
                document.forms[0].handle_id.value = "checkStock";
                document.forms[0].action = '/PacsApplication/TradingStockRegisterServlet';
                document.forms[0].submit();
            }
            function checkDiv(trendingstockregister)
            {

                var counter = document.forms[0].rowCounter.value;
                alert(counter);


                for (var i = 1; i <= counter; i++) {

                    var productDetails = document.getElementById("product" + i).value;
                    var purchaseNo = document.getElementById("Prefno" + i).value;
                    var price = document.getElementById("price" + i).value;
                    var quantity = document.getElementById("quantity" + i).value;
                    var total = document.getElementById("total" + i).value;


                    if (productDetails == "" || purchaseNo == "" || price == "" || quantity == "" || total == "") {

                        alert("Fill The Required Fields");
                        return false;
                    }

                }
                return true;

            }
            function checkop()
            {
                if (document.getElementById("checkOption").value == "enterStock")
                {

                    document.getElementById('enterStock').style.display = 'block';
                    document.getElementById('checkStock').style.display = 'none';
                    document.getElementById('displayDiv').style.display = 'none';
                }
                if (document.getElementById("checkOption").value == "checkStock")
                {
                    document.getElementById('enterStock').style.display = 'none';
                    document.getElementById('checkStock').style.display = 'block';
                    document.getElementById('displayDiv').style.display = 'none';
                }
            }
            function Total(i) {

                var priceDetails = document.getElementById("price" + i).value;
                var quantityDetails = document.getElementById("quantity" + i).value;

                document.getElementById("total" + i).value = priceDetails * quantityDetails;

            }

            function checkDate(i) {
                var flag = document.getElementById("selectperish" + i).value;
                if (flag == "N") {
                    document.getElementById("stkexpirayDate" + i).disabled = true;
                    document.getElementById("imgr").disabled = true;
                }
                if (flag == "Y") {
                    document.getElementById("stkexpirayDate" + i).disabled = false;
                    document.getElementById("imgr").disabled = false;
                }

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
            Object alTrandinStockRegisterBeanApendObj = request.getAttribute("alTrandinStockRegisterBeanApend");
            ArrayList<TrandinStockRegisterBean> alTrandinStockRegisterBeanApend = new ArrayList<TrandinStockRegisterBean>();
            if (alTrandinStockRegisterBeanApendObj != null) {
                alTrandinStockRegisterBeanApend = (ArrayList<TrandinStockRegisterBean>) request.getAttribute("alTrandinStockRegisterBeanApend");
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
                Trading Stock Register
            </legend>

            <form id="trendingstockregister" name="trendingstockregister" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                            <% }%>
                <br>

                <center><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</label>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" >--select--</option>
                        <option value="enterStock" >Enter Stock</option>
                        <option value="checkStock" >View Stock</option>
                    </select>
                </center>
                <br>
                <div id="enterStock" style="display:none;">
                    <table id="order-list"  >
                        <thead  class="CSSTableGenerator" >
                            <tr>
                                <td></td>
                                <td colspan="2">Product Name</td>
                                <td colspan="2">Purchase Order Ref. No.</td>
                                <td>Price/Unit</td>
                                <td>Quantity</td>
                                <td>Total</td>
                                <td>Stock Expiry Date</td>
                                <td>Perishable(Y/N)</td>




                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                <td><input type="text" name="product<%=count%>" id="product<%=count%>"/></td>
                                <td><input type="button" name="SearchProduct<%=count%>" id="SearchProduct<%=count%>" value="Search"  onclick="SearchProduct(220, 180,<%=count%>)" /></td>
                                <td><input type="text" name="Prefno<%=count%>" id="Prefno<%=count%>"/></td>
                                <td><input type="button" name="SearchRef<%=count%>" id="SearchRef<%=count%>" value="Search"  onclick="SearchPurchaseOrder(220, 180,<%=count%>)" /></td>
                                <td><input type="text" readonly name="price<%=count%>" id="price<%=count%>"/></td>
                                <td><input type="text" readonly name="quantity<%=count%>" id="quantity<%=count%>" onchange="Total(<%=count%>);"/></td>
                                <td><input type="text" readonly name="total<%=count%>" id="total<%=count%>"/></td>
                                <td id="expDate"><input type="text" name="stkexpirayDate<%=count%>" id="stkexpirayDate<%=count%>" readonly="readonly" disabled /><a id="calender" href="#" onclick="return getCalendar(getElementById('stkexpirayDate<%=count%>'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" id="imgr" border="0" width="18" height="18" /></a></td>
                                <td><select style="width: 120px" id="selectperish<%=count%>" name="selectperish<%=count%>" onchange="checkDate(<%=count%>)"><option value="N">No</option><option value="Y">Yes</option></select></td>
                                <td><input type="hidden" name="product_id<%=count%>" id="product_id<%=count%>"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <br/><br/>
                    <center>
                        <input type="button" id="addRow" value="Add Row"/>
                        <input type="button" id="deleteRow" value="Delete Row"/>
                        <input type="button" value="Submit" onclick="javascript:submitform(trendingstockregister)"/>
                        <input type="button" value="Reset" onclick="ShowParent();" />


                    </center>
                    <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">
                </div>
                <br>
                <div id="checkStock" style="display: none;">
                    <table style="margin-left: 415px;" colspan="15px">
                        <tr><td></td><td></td><td><label style=" font-family: Berlin Sans FB; font-weight:normal;">Select Product:</label><select id="productName" name="productName">
                                    <option value="" disabled selected style="display:none;">--Select--</option>
                                    <%
                                        Connection connection = null;
                                        ResultSet rs = null;
                                        Statement statement = null;
                                        connection = DbHandler.getDBConnection();
                                        try {
                                            statement = connection.createStatement();
                                            rs = statement.executeQuery("select id,product_name from trading_product_mst");
                                            while (rs.next()) {%>
                                    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                    <%}
                                            statement.close();
                                            connection.close();
                                        } catch (Exception e) {
                                            System.out.println(e.toString());
                                        }
                                    %>
                                </select> </td>
                            <td></td> <td style="text-align: right;"><label style=" font-family: Berlin Sans FB; font-weight:normal;">From Date:</label><input type="text" name="fromDate" id="fromDate" readonly="readonly"/><a href="#" onclick="return getCalendar(getElementById('fromDate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                            <td></td><td><label style=" font-family: Berlin Sans FB; font-weight:normal;">To Date:</label><input type="text" name="toDate" id="toDate" readonly="readonly"/><a href="#" onclick="return getCalendar(getElementById('toDate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                        </tr>
                    </table><br>
                    <center>
                        <input type="button" value="Search"  onclick="javascript:searchStock(trendingstockregister)">
                    </center>


                </div>
                <%if (displayFlag.equalsIgnoreCase("Y")) {%>
                <div id="displayDiv" >


                    <table id="order-listAmend" style="margin-left: 215px; overflow-y: scroll" border="1.5" >
                        <thead  class="CSSTableGenerator" >
                            <tr> 
                                <td style="text-align:center;"> <b>  Product</b>  </td>
                                <td style="text-align:center;"><b>Product Code</b></td>
                                <td style="text-align:center;"><b>Unit</b></td>
                                <td style="text-align:center;"><b> Purchase Ref No</b></td>
                                <td style="text-align:center;"><b>Stock Creation Date</b></td>
                                <td style="text-align:center;"><b>Price</b></td>
                                <td style="text-align:center;"><b>Base Quantity</b></td>
                                <td style="text-align:center;"><b>Quantity Availed</b></td>
                                <td style="text-align:center;"><b>Quantity Available</b></td>
                                <td style="text-align:center;"><b>Stock ID</b></td>
                            </tr>
                        </thead>
                        <tbody style="background-color: white; font-size: 15px">
                            <%
                                TrandinStockRegisterBean oTrandinStockRegisterBeanApend = new TrandinStockRegisterBean();

                                for (int i = 0; i < alTrandinStockRegisterBeanApend.size(); i++) {
                                    oTrandinStockRegisterBeanApend = alTrandinStockRegisterBeanApend.get(i);
                            %>
                            <tr>

                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getProductName())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getProductId())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getUnit())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getPurchaseOrderRef())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getStockCreateDate())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getPrice())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getQuantity())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getQuantityAbled())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getQuantityAvailable())%></td>
                                <td style="text-align:center;"><%=blankNull(oTrandinStockRegisterBeanApend.getStockId())%></td>



                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <%}%>
                <input type="hidden" name="handle_id" value="" />
            </form>
            <script>

                $("#addRow").click(function () {

                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr> <td align="center"><input type="checkbox" name="chckbox' + counter + '" id="chckbox' + counter + '"/></td><td><input type="text" id="product' + counter + '" name="product' + counter + '"/></td><td><input type="button" name="SearchProduct' + counter + '" id="SearchProduct' + counter + '" value="Search"  onclick="SearchProduct(220,180,' + counter + ');" /></td><td><input type="text" name="Prefno' + counter + '" id="Prefno' + counter + '"/></td><td><input type="button" name="SearchRef' + counter + '" id="SearchRef' + counter + '" value="Search"  onclick="SearchPurchaseOrder(220,180,' + counter + ')" /></td><td><input type="text" id="price' + counter + '" name="price' + counter + '"/></td><td><input type="text" id="quantity' + counter + '" name="quantity' + counter + '" onchange="Total(' + counter + ')"/></td><td><input type="text" readonly="readonly" id="total' + counter + '" name="total' + counter + '"/></td><td><input type="text" id="stkexpirayDate' + counter + '" name="stkexpirayDate' + counter + '" readonly="readonly" disabled/><a href="#" onclick="ShowCalender(' + counter + ')"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td><td><select style="width: 120px"  id="selectperish' + counter + '" name="selectperish' + counter + '"><option value="N">No</option><option value="Y">Yes</option></select></td><td><input type="hidden" name="product_id' + counter + '" id="product_id' + counter + '"/></td></tr>');
                    $("#rowCounter").val(counter);

                });
                $("#deleteRow").click(function () {

                    var rowcount = $("#rowCounter").val();
                    if (rowcount == 1) {

                        return false;
                    }
                    var value = $('input:checkbox:checked').length;
                    rowcount = rowcount - value;
                    if (rowcount == 0) {
                        
                        return false;
                    }
                    $("#rowCounter").val(rowcount);
                    $('input:checkbox:checked').closest('tr').remove();




                });



                function ShowCalender(i) {

                    getCalendar(document.getElementById("stkexpirayDate" + i));
                }

                function SearchProduct(width, height, i)
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
                    var screenName = "TradingStockRegister.jsp";
                    var lovKey = "TrandingProductSearch"
                    popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey + '&textIndex=' + i, 'TrandingProductSearch', attr);
                    popWin.focus();

                }

                function SearchPurchaseOrder(width, height, i)
                {
                    var product_id = document.getElementById("product_id" + i).value;
                    if (product_id == "") {
                        alert("Product Name is Mandatory");
                        return false;

                    }
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
                    var screenName = "TradingStockRegister.jsp";
                    var lovKey = "purchaseOrderSearch";

                    popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey + '&product_id=' + product_id + '&textIndex=' + i, 'ProductSearch', attr);
                    popWin.focus();

                }

                function ShowParent()
                {
                    document.forms[0].action = "TradingStockRegister.jsp";
                    document.forms[0].submit();
                }




            </script>
        </fieldset>
    </body>
</html>
