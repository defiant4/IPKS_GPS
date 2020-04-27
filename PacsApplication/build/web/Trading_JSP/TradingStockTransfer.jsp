<%-- 
    Document   : TradingStockTransfer
    Created on : Jul 8, 2016, 12:02:55 PM
    Author     : Tcs Help desk122
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.TrandinStockRegisterBean"%>
<%@page import="DataEntryBean.TradingStockTransferBean"%>
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
            function submitform(trendingstocktransfer)
            {
                if (checkDiv(trendingstocktransfer))
                {
                    document.forms[0].handle_id.value = "Create";
                    document.forms[0].action = '/PacsApplication/TradingStockTransferServlet';
                    document.forms[0].submit();
                }
            }
            function searchStock(trendingstocktransfer)
            {
                document.forms[0].handle_id.value = "checkStock";
                document.forms[0].action = '/PacsApplication/TradingStockTransferServlet';
                document.forms[0].submit();
            }


            function checkDiv(trendingstocktransfer)
            {

                var counter = document.forms[0].rowCounter.value;

                for (var i = 1; i <= counter; i++) {

                    var toPacsName = document.getElementById("toPacsName" + i).value;
                    var product = document.getElementById("product" + i).value;
                    var salePrice = document.getElementById("salePrice" + i).value;
                    var quantity = document.getElementById("quantity" + i).value;
                    var transportOption = document.getElementById("transportOption" + i).value;
                    var stockQuantity = document.getElementById("stockQuantity" + i).value;

                    if (toPacsName === "" || product === "" || salePrice === "" || quantity === "" || transportOption === "") {

                        alert("Fill The Required Fields");
                        return false;
                    }
                    if (quantity > stockQuantity) {
                        alert("Entered Quantity larger than stock");
                        return false;
                    }


                }
                return true;

            }
            function checkop()
            {
                if (document.getElementById("checkOption").value === "stockTransfer")
                {

                    document.getElementById('stockTransfer').style.display = 'block';
                    document.getElementById('stockTransferDetail').style.display = 'none';
                    document.getElementById('displayDiv').style.display = 'none';
                }
                if (document.getElementById("checkOption").value === "stockTransferDetail")
                {
                    document.getElementById('stockTransfer').style.display = 'none';
                    document.getElementById('stockTransferDetail').style.display = 'block';
                    document.getElementById('displayDiv').style.display = 'none';
                }
            }

            function checkTransport(i)
            {
                if (document.getElementById("transportOption" + i).value === "self")
                {
                    document.getElementById('transportCost' + i).disabled = true;

                }
                if (document.getElementById("transportOption" + i).value === "vendor")
                {
                    document.getElementById('transportCost' + i).disabled = false;
                }
            }
            function Total(i) {

                var priceDetails = document.getElementById("salePrice" + i).value;
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
            function download() {

                document.forms[0].reportPath.value = "/Reports/trading_stock_transfer.jasper";
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
            Object alTradingStockTransferBeanApendObj = request.getAttribute("alTradingStockTransferBeanApend");
            ArrayList<TradingStockTransferBean> alTradingStockTransferBeanApend = new ArrayList<TradingStockTransferBean>();
            if (alTradingStockTransferBeanApendObj != null) {
                alTradingStockTransferBeanApend = (ArrayList<TradingStockTransferBean>) request.getAttribute("alTradingStockTransferBeanApend");
            }
        %>



        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            String fromDate = "";
            Object from_Date = request.getAttribute("fromDate");
            String toDate = "";
            Object to_Date = request.getAttribute("toDate");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>

        <jsp:include page="MenuHead_TRADING.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                Trading Stock Transfer
            </legend>

            <form id="trendingstocktransfer" name="trendingstocktransfer" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                            <% }%>
                <br>

                <center><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</label>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" >--select--</option>
                        <option value="stockTransfer" >Transfer Stock</option>
                        <option value="stockTransferDetail" >Check Transfer Detail</option>
                    </select>
                </center>
                <br>
                <div id="stockTransfer" style="display:none;">
                    <table id="order-list"  >
                        <thead  class="CSSTableGenerator" >
                            <tr>
                                <td></td>
                                <td>From Pacs</td>
                                <td colspan="2">To Pacs</td>
                                <td colspan="2">Product ID</td>
                                <td>Stock Quantity</td>
                                <td>Price/Unit</td>
                                <td>Sale Rate/Unit</td>
                                <td>Quantity</td>
                                <td>Total</td>
                                <td>Transportation Type</td>
                                <td>Transportation Cost</td>





                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                <td><input type="text" readonly="true" name="fromPacsName<%=count%>" id="fromPacsName<%=count%>" value="<%=session.getAttribute("pacsName")%>"/></td>
                                <td><input type="text" readonly="true" name="toPacsName<%=count%>" id="toPacsName<%=count%>" /></td>
                                <td><input type="button" name="SearchPacs<%=count%>" id="SearchPacs<%=count%>" value="Search"  onclick="SearchPacs(220, 180,<%=count%>)" /></td>
                                <td><input type="text" readonly="true" name="product<%=count%>" id="product<%=count%>"/></td>
                                <td><input type="button" name="SearchProduct<%=count%>" id="SearchProduct<%=count%>" value="Search"  onclick="SearchProduct(220, 180,<%=count%>)" /></td>
                                <td><input size="10" type="text" readonly name="stockQuantity<%=count%>" id="stockQuantity<%=count%>"/></td>
                                <td><input size="10" type="text" readonly name="price<%=count%>" id="price<%=count%>"/></td>
                                <td><input size="10" type="text"  name="salePrice<%=count%>" id="salePrice<%=count%>" onchange="Total(<%=count%>);"/></td>
                                <td><input size="7" type="text"  name="quantity<%=count%>" id="quantity<%=count%>" onchange="Total(<%=count%>);"/></td>
                                <td><input size="7" type="text" readonly name="total<%=count%>" id="total<%=count%>"/></td>
                                <td>
                                    <select id="transportOption<%=count%>" onchange="checkTransport(<%=count%>)" name="transportOption<%=count%>" >
                                        <option value="" disabled selected style="display:none;" >--select--</option>
                                        <option value="self" >Self</option>
                                        <option value="vendor" >Vendor</option>
                                    </select>

                                </td>
                                <td><input size="10" type="text" name="transportCost<%=count%>" id="transportCost<%=count%>" /></td>


                                <td><input type="hidden" name="product_id<%=count%>" id="product_id<%=count%>"/></td>
                                <td><input type="hidden" name="toPacsId<%=count%>" id="toPacsId<%=count%>"/></td>
                                <td><input type="hidden" name="stockId<%=count%>" id="stockId<%=count%>"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <br/><br/>
                    <center>
                        <input type="button" id="addRow" value="Add Row"/>
                        <input type="button" id="deleteRow" value="Delete Row"/>
                        <input type="button" value="Submit" onclick="javascript:submitform(trendingstocktransfer)"/>
                        <input type="button" value="Reset" onclick="ShowParent();" />
                        <input type="hidden" name="pacs_id" id="pacs_id" value="<%=session.getAttribute("pacsId")%>"/>


                    </center>
                    <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">
                </div>
                <br>
                <div id="stockTransferDetail" style="display: none;">
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
                            <td></td> <td style="text-align: right;"><label style=" font-family: Berlin Sans FB; font-weight:normal;">From Date:</label><input type="text" name="fromDate" id="fromDate" readonly="readonly"/><a href="#" onclick="return getCalendar(document.forms[0].fromDate);"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                            <td></td><td><label style=" font-family: Berlin Sans FB; font-weight:normal;">To Date:</label><input type="text" name="toDate" id="toDate" readonly="readonly"/><a href="#" onclick="return getCalendar(document.forms[0].toDate);"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                        </tr>
                    </table><br>
                    <center>
                        <input type="button" value="Search"  onclick="javascript:searchStock(trendingstocktransfer)">
                    </center>


                </div>
                <%if (displayFlag.equalsIgnoreCase("Y")) {%>
                <div id="displayDiv" >


                    <table id="order-listAmend" style="margin-left: 215px; overflow-y: scroll" border="1.5" >
                        <thead  class="CSSTableGenerator" >
                            <tr> 
                                <td style="text-align:center;"><b>Product Name</b>  </td>
                                <td style="text-align:center;"><b>Product Code</b></td>
                                <td style="text-align:center;"><b>PACS Name</b></td>
                                <td style="text-align:center;"><b>To PACS Name</b></td>
                                <td style="text-align:center;"><b>Sale Rate/Unit</b></td>
                                <td style="text-align:center;"><b>Quantity</b></td>
                                <td style="text-align:center;"><b>Total</b></td>
                                <td style="text-align:center;"><b>Transportation Type</b></td>
                                <td style="text-align:center;"><b>Transportation Cost</b></td>
                                <td style="text-align:center;"><b>Transfer Date</b></td>
                            </tr>
                        </thead>
                        <tbody style="background-color: white; font-size: 15px">
                            <%
                                TradingStockTransferBean oTradingStockTransferBeanApend = new TradingStockTransferBean();

                                for (int i = 0; i < alTradingStockTransferBeanApend.size(); i++) {
                                    oTradingStockTransferBeanApend = alTradingStockTransferBeanApend.get(i);
                            %>
                            <tr>

                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getProduct_name())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getProduct_code())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getFromPacsId())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getToPacsId())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getSellingRate())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getQuantity())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getTotal())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getTransportationType())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getTransportationCost())%></td>
                                <td style="text-align:center;"><%=blankNull(oTradingStockTransferBeanApend.getTransferDate())%></td>




                            </tr>
                            <%}%>
                        </tbody></table>
                    <br><br>
                    <center>
                        <table>
                            <tr>
                                <td><p> Download The Report</p></td>
                                <td><input type="button"  value="Download" onclick="javascript:download();" /></td>
                            </tr></table></center>
                    <input type="hidden" name="from_Date" id="from_Date" value="<%=from_Date%>">
                    <input type="hidden" name="to_Date" id="to_Date" value="<%=to_Date%>">
                    <input type="hidden" name="reportPath" value=""/>
                    <input type="hidden" name="reportName" value=""/>
                    <input type="hidden" name="DOWNLOAD" value=""/>


                </div>
                <%}%>
                <input type="hidden" name="handle_id" value="" />
            </form>
            <script>

                $("#addRow").click(function () {
                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr> <td align="center"><input type="checkbox" name="chckbox' + counter + '" id="chckbox' + counter + '"/></td><td><input type="text" name="fromPacsName' + counter + '" id="fromPacsName' + counter + '" value="<%=session.getAttribute("pacsName")%>"/></td><td><input type="text" name="toPacsName' + counter + '" id="toPacsName' + counter + '" /></td><td><input type="button" name="SearchPacs' + counter + '" id="SearchPacs' + counter + '" value="Search"  onclick="SearchPacs(220, 180,' + counter + ')" /></td><td><input type="text" name="product' + counter + '" id="product' + counter + '"/></td><td><input type="button" name="SearchProduct' + counter + '" id="SearchProduct' + counter + '" value="Search"  onclick="SearchProduct(220, 180,' + counter + ')" /></td><td><input size="10" type="text" readonly name="stockQuantity' + counter + '" id="stockQuantity' + counter + '"/></td><td><input size="10" type="text" readonly name="price' + counter + '" id="price' + counter + '"/></td><td><input type="text" size="10"  name="salePrice' + counter + '" id="salePrice' + counter + '" onchange="Total(' + counter + ');"/></td><td><input size="7"  type="text"  name="quantity' + counter + '" id="quantity' + counter + '" onchange="Total(' + counter + ');"/></td><td><input size="7"  type="text" readonly name="total' + counter + '" id="total' + counter + '"/></td><td> <select id="transportOption' + counter + '" onchange="checkTransport(' + counter + ')" name="transportOption' + counter + '" ><option value="" disabled selected style="display:none;" >--select--</option> <option value="self" >Self</option><option value="vendor" >Vendor</option></select></td><td><input size="10" type="text" name="transportCost' + counter + '" id="transportCost' + counter + '" /></td><td><input type="hidden" name="product_id' + counter + '" id="product_id' + counter + '"/></td><td><input type="hidden" name="toPacsId' + counter + '" id="toPacsId' + counter + '"/></td><td><input type="hidden" name="stockId' + counter + '" id="stockId' + counter + '"/></td></tr>');
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
                    attr = 'resizable=yes,scrollbars=yes,width=' + width + ',height=' + height + ',screenX=300,screenY=200,left=' + LeftPosition + ',top=' + TopPosition + '';
                    var screenName = "TradingStockTransfer.jsp";
                    var lovKey = "TrandingProductSearch"
                    popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey + '&textIndex=' + i, 'TrandingProductSearch', attr);
                    popWin.focus();

                }

                function SearchPacs(width, height, i)
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
                    var screenName = "TradingStockTransfer.jsp";
                    var lovKey = "pacsSearch";

                    popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey + '&textIndex=' + i, 'pacsSearch', attr);
                    popWin.focus();

                }



                function ShowParent()
                {
                    document.forms[0].action = "TradingStockTransfer.jsp";
                    document.forms[0].submit();
                }




            </script>
        </fieldset>
    </body>
</html>
