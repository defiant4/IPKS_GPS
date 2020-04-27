<%-- 
    Document   : SellItem
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
        <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
        <script>

            function noBack()
            {
                window.history.forward();
            }
            function submitform(tradingsaleitem)
            {
                if (checkDiv(tradingsaleitem))
                {

                    document.forms[0].handle_id.value = "Create";
                    document.forms[0].action = '/PacsApplication/TradingSaleItemEntry';
                    document.forms[0].submit();
                }
            }
            
            function checkDiv(tradingsaleitem)
            {
                //if(document.forms[0].memberId.value=="" || document.forms[0].memberName.value=="" )
                //{
                //alert("Please fill the member details");
                //return false;  
                //}


                var counter = document.forms[0].rowCounter.value;

                for (var i = 1; i <= counter; i++) {

                    var productDetails = document.getElementById("product" + i).value;
                    var priceDetails = document.getElementById("price" + i).value;
                    var quantityDetails = document.getElementById("quantity" + i).value;
                    var quantityAvailable = document.getElementById("quantity_avl" + i).value;
                    var total = document.getElementById("total" + i).value;
                    var restQuantity = quantityAvailable - quantityDetails;

                    if (productDetails == "") {
                        alert("Product Details Is Not Available");
                        return false;
                    }
                    if (restQuantity <= 0) {
                        alert(quantityDetails + " Items Is Not Available");
                        return false;
                    }



                    if (productDetails == "" || priceDetails == "" || quantityDetails == "" || total == "") {

                        alert("All Fields are mandatory");
                        return false;
                    }

                }
                return true;

            }
            function checkop()
            {
                if (document.getElementById("checkOption").value ==  "member")
                {
                    document.getElementById('member').style.display = 'block';
                    document.getElementById('productTable').style.display = 'block';
                    document.getElementById('nonmember').style.display = 'none';
                    document.getElementById('displayDiv').style.display = 'none';
                }
                if (document.getElementById("checkOption").value == "nonmember")
                {
                    document.getElementById('member').style.display = 'none';
                    document.getElementById('nonmember').style.display = 'block';
                    document.getElementById('productTable').style.display = 'block';
                    document.getElementById('displayDiv').style.display = 'none';
                }
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

        

        <jsp:include page="MenuHead_TRADING.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                Sell Item
            </legend>

            <form id="tradingsaleitem" name="tradingsaleitem" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                            <% }%>
                <br>

                <center><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Customer Type</label>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" >--select--</option>
                        <option value="member" >Member</option>
                        <option value="nonmember" >Non Member</option>
                    </select>
                </center>
                <br>
                <div id="member" style="display:none;">
                    <center>
                        <table>
                            <tbody>
                                <tr>
                                    <td>Member ID:</td>
                                    <td> <input type="text" id="memberId" name="memberId">&nbsp;&nbsp;&nbsp;</td>
                                    <td> <input type="button" id="searchMemberId" name="searchMemberId" value="Search" onclick="javascript:popup_CIF(220, 180, document.tradingsaleitem.memberId.value, document.tradingsaleitem.memberName.value);" ></td>
                                </tr></br>
                                <tr>
                                    <td>Member Name:</td>
                                    <td> <input type="text" id="memberName" name="memberName">&nbsp;&nbsp;&nbsp;</td>
                                    <td> <input type="button" id="searchMemberName" name="searchMemberName" value="Search" onclick="javascript:popup_CIF(220, 180, document.tradingsaleitem.memberId.value, document.tradingsaleitem.memberName.value);"></td>
                                </tr>
                            </tbody>
                        </table>
                </div>
                <br>
                <br>

                <div id="nonmember" style="display: none;">
                    <table>
                        <tbody>
                            <tr>
                                <td>Customer Name:</td>
                                <td><input type="text" name="custName" id="custName"style="width: 260px" value="" /></td>
                            </tr>

                            <tr>
                                <td>Customer Contact:</td>
                                <td><input type="text" name="contactNo" id="contactNo"style="width: 260px" value="" /></td>
                            </tr>
                            <tr>
                                <td>Customer Address:</td>
                                <td><textarea rows="4" cols="50"  name="address" id="address" style="width: 259px"></textarea></td>
                            </tr>


                            <tr>
                                <td>Customer DOB:</td>
                                <td><input type="text" name="dob" id="dob" readonly="readonly"/><a href="#" onclick="return getCalendar(getElementById('dob'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                            </tr>
                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            <tr><td><label>All fields are mandatory</label></td></tr>
                        </tbody>
                    </table>
                </div>
                <br>

                <div id="productTable" style="display:none;">
                    <center>
                        <table id="order-list" >
                            <thead  class="CSSTableGenerator" >
                                <tr>
                                    <td></td>
                                    <td colspan="2">Product Name</td>
                                    <td>Stock ID</td>
                                    <td>Price/Unit</td>
                                    <td>Quantity</td>
                                    <td>Total</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                    <td><input type="text" name="product<%=count%>" id="product<%=count%>"/></td>
                                    <td><input type="button" name="SearchProduct<%=count%>" id="SearchProduct<%=count%>" value="Search"  onclick="SearchProduct(520, 180,<%=count%>)" /></td>
                                    <td><input type="text" name="stockId<%=count%>" id="stockId<%=count%>"/></td>
                                    <td><input type="text" name="price<%=count%>" id="price<%=count%>"/></td>
                                    <td><input type="text" name="quantity<%=count%>" id="quantity<%=count%>" onchange="Total(<%=count%>);"/></td>
                                    <td><input type="text" readonly="readonly" name="total<%=count%>" id="total<%=count%>"/></td>
                                    <td><input type="hidden" name="product_id<%=count%>" id="product_id<%=count%>"/></td>
                                    <td><input type="hidden" name="quantity_avl<%=count%>" id="quantity_avl<%=count%>"/></td>
                                    <td><input type="hidden" name="p_order_id<%=count%>" id="p_order_id<%=count%>"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </center>

                    <br/><br/>
                    <center>
                        <input type="button" id="addRow" value="Add Row"/>
                        <input type="button" id="deleteRow" value="Delete Row"/>
                        <input type="button" value="Submit" onclick="javascript:submitform(tradingsaleitem)"/>
                        <input type="button" value="Reset" onclick="ShowParent();" />


                    </center>
                    <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">
                </div>


                <br>



                </div>

                <input type="hidden" name="handle_id" value="" />
            </form>
            <script>

                $("#addRow").click(function () {

                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr><td><input type="checkbox" name="chckbox' + counter + '" id="chckbox' + counter + '" /></td><td><input type="text" id="product' + counter + '" name="product' + counter + '"/></td><td><input type="button" name="SearchProduct' + counter + '" id="SearchProduct' + counter + '" value="Search"  onclick="SearchProduct(520,180,' + counter + ');" /></td><td><input type="text" name="stockId' + counter + '" id="stockId' + counter + '" /></td>  <td><input type="text" id="price' + counter + '" name="price' + counter + '"/></td><td><input type="text" id="quantity' + counter + '" name="quantity' + counter + '" onchange="Total(' + counter + ')"/></td><td><input type="text" readonly="readonly" name="total' + counter + '" id="total' + counter + '"/></td><td><input type="hidden" name="product_id' + counter + '" id="product_id' + counter + '"/></td><td><input type="hidden" name="quantity_avl' + counter + '" id="quantity_avl' + counter + '"/></td><td><input type="hidden" name="p_order_id' + counter + '" id="p_order_id' + counter + '"/></td> </tr>');
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

                    getCalendar(document.getElementById("purchaseDate" + i));
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
                    var screenName = "SellItem.jsp";
                    var lovKey = "TrandingProductSearch"
                    popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey + '&textIndex=' + i, 'TrandingProductSearch', attr);
                    popWin.focus();

                }

                function ShowParent()
                {
                    document.forms[0].action = "SellItem.jsp";
                    document.forms[0].submit();
                }

                function popup_CIF(width, height, memberId, memberName) {
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
                    var screenName = "SellItem.jsp";
                    var lovKey = "memberDetails"
                    popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?memberId=' + memberId + '&memberName=' + memberName + '&screenName=' + screenName + '&lovKey=' + lovKey, 'memberDetails', attr);
                    popWin.focus();

                }


            </script>
        </fieldset>
    </body>
</html>
