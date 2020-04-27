<%-- 
    Document   : pds_stock_register
    Created on : May 5, 2016, 12:31:09 PM
    Author     : 590685
--%>

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
        <script src="js/Calendar.js"></script>
        <script>

            function noBack()
            {
                window.history.forward();
            }
            function submitform(validationform)
            {
                if (checkDiv(validationform))
                {
                    document.forms[0].handle_id.value="Create";
                    document.forms[0].action='/PacsApplication/pdsStockRegisterServlet';
                    document.forms[0].submit();
                }
            }
            function searchStock(validationform)
            {
                document.forms[0].handle_id.value="checkStock";
                document.forms[0].action='/PacsApplication/pdsStockRegisterServlet';
                document.forms[0].submit();
            }
            function checkDiv(validationform)
            {

                var counter = document.forms[0].rowCounter.value;


                for(var i=1; i<=counter; i++){

                    var productDetails = document.getElementById("product"+i).value;
                    var priceDetails = document.getElementById("price"+i).value;
                    var quantityDetails = document.getElementById("quantity"+i).value;
                    var unitDetails = document.getElementById("unit"+i).value;
                    var purchaseDateDetails= document.getElementById("purchaseDate"+i).value;
                    

                    if(productDetails=="" || priceDetails=="" || quantityDetails=="" || unitDetails==""||purchaseDateDetails==""){

                        alert("All Fields are mandatory");
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
            function Total(i){

                var priceDetails = document.getElementById("price"+i).value;
                var quantityDetails = document.getElementById("quantity"+i).value;

                document.getElementById("total"+i).value=priceDetails*quantityDetails;

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
                    Object alpdsStockRegisterBeanApendObj = request.getAttribute("alpdsStockRegisterBeanApend");
                    ArrayList<pdsStockRegisterBean> alpdsStockRegisterBeanApend = new ArrayList<pdsStockRegisterBean>();
                    if (alpdsStockRegisterBeanApendObj != null) {
                        alpdsStockRegisterBeanApend = (ArrayList<pdsStockRegisterBean>) request.getAttribute("alpdsStockRegisterBeanApend");
                    }
        %>

        <%
                    String displayFlag = "";
                    Object display = request.getAttribute("displayFlag");
                    if (display != null) {
                        displayFlag = display.toString();
                    }
        %>

        <jsp:include page="MenuHead_PDS.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                Stock Register
            </legend>

            <form id="validationform" name="validationform" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                <% }%>
                <br>

                <center><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</label>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" >--select--</option>
                        <option value="enterStock" >Enter Stock</option>
                        <option value="checkStock" >Check Stock</option>
                    </select>
                </center>
                <br>
                <div id="enterStock" style="display:none; ">
                    <table id="order-list" style="margin-left: 180px;"  >
                        <thead  class="CSSTableGenerator" >
                            <tr>
                                <td></td>
                                <td>Product Name</td>
                                <td></td>
                                <td>Unit</td>
                                <td>Price/Unit</td>
                                <td>Quantity</td>
                                <td>Total</td>
                                <td>Purchase Date</td>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                <td><input type="text" name="product<%=count%>" id="product<%=count%>"/></td>
                                <td><input type="button" name="SearchProduct<%=count%>" id="SearchProduct<%=count%>" value="Search"  onclick="SearchProduct(220,180,<%=count%>)" /></td>
                                <td><input type="text" name="unit<%=count%>" id="unit<%=count%>"/></td>
                                <td><input type="text" name="price<%=count%>" id="price<%=count%>"/></td>
                                <td><input type="text" name="quantity<%=count%>" id="quantity<%=count%>" onchange="Total(<%=count%>);"/></td>
                                <td><input type="text" readonly="readonly" name="total<%=count%>" id="total<%=count%>"/></td>
                                <td><input type="text" name="purchaseDate<%=count%>" id="purchaseDate<%=count%>" readonly="readonly"/><a href="#" onclick="return getCalendar(getElementById('purchaseDate<%=count%>'));"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                                <td><input type="hidden" name="product_id<%=count%>" id="product_id<%=count%>"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <br/><br/>
                    <center>
                        <input type="button" id="addRow" value="Add Row"/>
                        <input type="button" id="deleteRow" value="Delete Row"/>
                        <input type="button" value="Submit" onclick="javascript:submitform(validationform)"/>
                        <input type="button" value="Reset" onclick="ShowParent();" />


                    </center>
                    <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">
                </div>
                <br>
                <div id="checkStock" style="display: none;">
                    <table style="margin-left: 315px;" colspan="15px">
                    <tr><td></td><td></td><td><label style=" font-family: Berlin Sans FB; font-weight:bold;">Select Product:</label><select id="productName" name="productName">
                                <option value="" disabled selected style="display:none;">--Select--</option>
                                <%
                                            Connection connection = null;
                                            ResultSet rs = null;
                                            Statement statement = null;
                                             connection = DbHandler.getDBConnection();
                                            try {
                                                statement = connection.createStatement();
                                                rs = statement.executeQuery("select id,product_name from pds_product_mst");
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
                        <td></td> <td style="text-align: right;"><label style=" font-family: Berlin Sans FB; font-weight:bold;">From Date:</label><input type="text" name="fromDate" id="fromDate" readonly="readonly"/><a href="#" onclick="return getCalendar(getElementById('fromDate'));"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                        <td></td><td><label style=" font-family: Berlin Sans FB; font-weight:bold;">To Date:</label><input type="text" name="toDate" id="toDate" readonly="readonly"/><a href="#" onclick="return getCalendar(getElementById('toDate'));"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                    </tr>
                    </table><br>
                    <center>
                        <input type="button" value="Search"  onclick="javascript:searchStock(validationform)">
                    </center>


                </div>
                <%if (displayFlag.equalsIgnoreCase("Y")) {%>
                <div id="displayDiv" >


                    <table id="order-listAmend" style="margin-left: 290px; overflow-y: scroll" border="1.5" >
                        <thead  class="CSSTableGenerator" >
                            <tr> <td style="text-align:center;"> <b>  Product</b></td><td style="text-align:center;"><b>Product Code</b></td><td style="text-align:center;"><b>Unit</b></td><td style="text-align:center;"><b>Stock Entry Date</b></td><td style="text-align:center;"><b> Price</b></td><td style="text-align:center;"><b>Base Quantity</b></td><td style="text-align:center;"><b>Quantity Availed</b></td><td style="text-align:center;"><b>Quantity Available</b></td><td style="text-align:center;"><b>Stock ID</b></td></tr>
                        </thead>
                        <tbody style="background-color: white; font-size: 15px">
                            <%
                                pdsStockRegisterBean opdsStockRegisterBeanApend = new pdsStockRegisterBean();

                                for (int i = 0; i < alpdsStockRegisterBeanApend.size(); i++) {
                                    opdsStockRegisterBeanApend = alpdsStockRegisterBeanApend.get(i);
                            %>
                            <tr>

                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getProductName())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getProductId())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getUnit())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getPurchaseDate())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getPrice())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getQuantity())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getQuantityAbled())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getQuantityAvailable())%></td>
                                <td style="text-align:center;"><%=blankNull(opdsStockRegisterBeanApend.getStockId())%></td>
                                


                            </tr>
                        <%}%>
                        </tbody>
                    </table>
                </div>
                <%}%>
                <input type="hidden" name="handle_id" value="" />
            </form>
            <script>

                $("#addRow").click(function(){

                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr> <td align="center"><input type="checkbox" name="chckbox'+counter+'" id="chckbox'+counter+'"/></td><td><input type="text" id="product'+counter+'" name="product'+counter+'"/></td><td><input type="button" name="SearchProduct'+counter+'" id="SearchProduct'+counter+'" value="Search"  onclick="SearchProduct(220,180,'+counter+');" /></td><td><input type="text" name="unit'+counter+'" id="unit'+counter+'" /></td><td><input type="text" id="price'+counter+'" name="price'+counter+'"/></td><td><input type="text" id="quantity'+counter+'" name="quantity'+counter+'" onchange="Total('+counter+')"/></td><td><input type="text" readonly="readonly" id="total'+counter+'" name="total'+counter+'"/></td><td><input type="text" id="purchaseDate'+counter+'" name="purchaseDate'+counter+'" readonly="readonly"/><a href="#" onclick="ShowCalender('+counter+')"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td><td><input type="hidden" name="product_id'+counter+'" id="product_id'+counter+'"/></td> </tr>');
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


                
                function ShowCalender(i){

                    getCalendar(document.getElementById("purchaseDate"+i));
                }

                function SearchProduct(width, height,i)
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
                    var screenName = "pds_stock_register.jsp";
                    var  lovKey="PdsProductSearch"
                    popWin = open('CommonSearchInformationLOV.jsp?screenName=' + screenName+'&lovKey='+lovKey+'&textIndex='+i , 'ProductSearch', attr);
                    popWin.focus();

                }

                function ShowParent()
                {
                    document.forms[0].action="pds_stock_register.jsp";
                    document.forms[0].submit();
                }

                
            </script>
        </fieldset>
    </body>
</html>
