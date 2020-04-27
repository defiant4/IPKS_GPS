<%-- 
    Document   : ItemProcurement
    Created on : Jul 14, 2016, 5:01:13 PM
    Author     : Tcs Helpdesk10
--%>

<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.ItemProcurementBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
        <title>Item Procurement</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
        <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
        <script>

            function noBack()
            {
                window.history.forward();
            }


        </script>

    </head>

    <body  onload="noBack()">
        <%          int count = 1;
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>
        <jsp:include page="MenuHead_GPS.jsp" flush="true" />    
        <br>



        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">Item Procurement</legend>

            <form name="itemProcurementForm" method="post" onsubmit="return checkDiv(this)" action="ItemProcurementServlet.jsp">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>          
                            <% }%>
                <br>
                <table>

                    <tr><td><h4>Item Procurement</h4></td></tr>

                    <tr>
                        <td><lable>Muster Roll ID :</lable></td>
                    <td><input type="text" id="musterRollId" name="musterRollId" ></td>
                    <td><input type="button"  value="Search" onclick="javascript:popup_Master(220, 180, document.itemProcurementForm.musterRollId.value, document.itemProcurementForm.name.value)" /></td>

                    </tr>

                    <tr>
                        <td><lable>Name :</lable></td>
                    <td><input type="text" id="name" name="name" ></td>

                    </tr>

                    <tr>
                        <td><lable>Govt.Procurement Code :</lable></td>
                    <td><input type="text" id="govtOrderCode" name="govtOrderCode" ></td> 
                    <td><input type="button"  value="Search" onclick="javascript:popup_Order_code(220, 180)" /></td>
                    <td><input type="hidden" id="govtOrderId" name="govtOrderId" ></td>
                    </tr> 

                    <tr><td><hr></td></tr>
                </table>


                <h4>Item Details</h4>

                <center>
                    <table id="order-list" style="margin-left: 20px;">
                        <thead class="CSSTableGenerator" >
                            <tr>
                                <td></td>
                                <td>Item Type</td>
                                <td >Item SubType</td>
                                <td>Rate Per Unit</td>
                                <td></td>
                                <td>Quantity Unit</td>
                                <td>Quantity</td>
                                <td>Total</td>


                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                <td><input type="text" name="item_desc<%=count%>" id="item_desc<%=count%>"/></td>
                                <td><input type="text" name="subtype_desc<%=count%>" id="subtype_desc<%=count%>"/></td>
                                <td><input type="text" name="rate_per_unit<%=count%>" id="rate_per_unit<%=count%>"onchange="Total(<%=count%>);"/></td>
                                <td><input type="button" name="SearchItem<%=count%>" id="SearchItem<%=count%>" value="Search"  onclick="SearchItem(400, 180,<%=count%>, document.itemProcurementForm.govtOrderId.value)" /></td>
                                <td><input type="text" name="qty_unit<%=count%>" id="qty_unit<%=count%>"/></td>
                                <td><input type="text" name="qty<%=count%>" id="qty<%=count%>"  onchange="Total(<%=count%>);"/></td>
                                <td><input type="text" name="total<%=count%>" id="total<%=count%>"/></td>
                                <td><input type="hidden" name="commodityId<%=count%>" id="commodityId<%=count%>" </td>
                                <td><input type="hidden" name="item_type<%=count%>" id="item_type<%=count%>"/></td>
                                <td><input type="hidden" name="item_subtype<%=count%>" id="item_subtype<%=count%>"/></td>
                            </tr>
                        </tbody>

                    </table>
                    <table style="margin-left: 837px;">
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr> 
                            <td><input type="button" name="tota" id="tota" value="Grand Total" onclick="grandTotal1()"/></td>
                            <td><input type="text" name="grandTotal" id="grandTotal" value="0"/></td>
                        </tr> 

                    </table>

                    <br/><br/>

                </center>
                <center>
                    <input type="button" id="addRow" value="Add Row"/>
                    <input type="button" id="deleteRow" value="Delete Row"/>
                    <input type="button" value="Submit" onclick="javascript:submitform(itemProcurementForm)">
                    <input type="button" value="Reset" name="reset" onclick="ShowParent();" />

                </center>
                <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">
                <br></br>

                <br>
                <label style=" font-family: Berlin Sans FB; font-weight:normal; ">All fields are mandatory</label>

            </form>
        </form>

        <script>


            $("#addRow").click(function () {
                var counter = $("#rowCounter").val();
                counter++;
                $('#order-list tr:last').after('<tr> <td><input type="checkbox" name="chckbox' + counter + '" id="chckbox' + counter + '" /></td><td><input type="text" name="item_desc' + counter + '" id="item_desc' + counter + '"/></td><td><input type="text" name="subtype_desc' + counter + '" id="subtype_desc' + counter + '"/></td><td><input type="text" name="rate_per_unit' + counter + '" id="rate_per_unit' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="button" name="SearchItem' + counter + '" id="SearchItem' + counter + '" value="Search"  onclick="SearchItem(400, 180,' + counter + ',document.itemProcurementForm.govtOrderId.value)" /></td><td><input type="text" name="qty_unit' + counter + '" id="qty_unit' + counter + '"/></td><td><input type="text" name="qty' + counter + '" id="qty' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" name="total' + counter + '" id="total' + counter + '"</td><td><input type="hidden" name="commodityId' + counter + '" id="commodityId' + counter + '" </td><td><input type="hidden" name="item_type' + counter + '" id="item_type' + counter + '"/></td><td><input type="hidden" name="item_subtype' + counter + '" id="item_subtype' + counter + '"/></td> </tr>');
                $("#rowCounter").val(counter);

            });
            $("#deleteRow").click(function () {

                var rowcount = $("#rowCounter").val();
                if (rowcount === 1) {

                    return false;
                }
                var value = $('input:checkbox:checked').length;
                rowcount = rowcount - value;
                if (rowcount === 0) {

                    return false;
                }
                $("#rowCounter").val(rowcount);
                $('input:checkbox:checked').closest('tr').remove();

                



            });
            function popup_Master(width, height, masterId, masterName) {
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
                var screenName = "ItemProcurement.jsp";
                var lovKey = "masterdetails"
                popWin = open('/PacsApplication/CommonSearchInformation_GPS_LOV.jsp?masterId=' + masterId + '&masterName=' + masterName + '&screenName=' + screenName + '&lovKey=' + lovKey, 'masterdetails', attr);
                popWin.focus();

            }

            function popup_Order_code(width, height) {
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
                var screenName = "GovtOrderCreation.jsp";
                var lovKey = "Orderdetails"
                popWin = open('/PacsApplication/CommonSearchInformation_GPS_LOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey, 'ItemProcurementDetails', attr);
                popWin.focus();



            }

            function SearchItem(width, height, i, orderId) {
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
                var screenName = "ItemProcurement.jsp";
                var lovKey = "ItemProcurementDetails"
                popWin = open('/PacsApplication/CommonSearchInformation_GPS_LOV.jsp?orderId=' + orderId + '&textIndex=' + i + '&screenName=' + screenName + '&lovKey=' + lovKey, 'ItemProcurementDetails', attr);
                popWin.focus();

            }


            function Total(i) {

                var qtyDetails = document.getElementById("qty" + i).value;
                var rateDetails = document.getElementById("rate_per_unit" + i).value;

                document.getElementById("total" + i).value = rateDetails * qtyDetails;

            }
            function grandTotal1() {
                
                var counter = document.forms[0].rowCounter.value;
              
                var total = 0;
                for (var i = 1; i <= counter; i++) {
                
                    total = parseInt(total) + parseInt(document.getElementById("total" + i).value);
                    
                    document.getElementById("grandTotal").value = total;
                }

            }

            function ShowParent()
            {
                document.forms[0].action = "ItemProcurement.jsp";
                document.forms[0].submit();
            }

            function submitform(itemProcurementForm)
            {
                if (checkDiv(itemProcurementForm))
                {
                    document.forms[0].action = '/PacsApplication/ItemProcurementServlet'
                    itemProcurementForm.submit();
                }
            }
            function checkDiv(itemProcurementForm)
            {

                if (itemProcurementForm.musterRollId.value == "")
                {
                    alert("!! All fields must be filled !!");
                    itemProcurementForm.musterRollId.focus();
                    return false;
                }


                if (itemProcurementForm.name.value == "")
                {
                    alert("!! All fields must be filled !!");
                    itemProcurementForm.name.focus();
                    return false;
                }

                if (itemProcurementForm.govtOrderId.value == "")
                {
                    alert("!! All fields must be filled !!");
                    itemProcurementForm.govtOrderId.focus();
                    return false;
                }



                var counter = document.forms[0].rowCounter.value;

                for (var i = 1; i <= counter; i++) {


                    var item_desc = document.getElementById("item_desc" + i).value;
                    var subtype_desc = document.getElementById("subtype_desc" + i).value;
                    var rate_per_unit = document.getElementById("rate_per_unit" + i).value;
                    var qty_unit = document.getElementById("qty_unit" + i).value;
                    var qty = document.getElementById("qty" + i).value;
                    var total = document.getElementById("total" + i).value;

                    if (item_desc == "" || subtype_desc == "" || rate_per_unit == "" || qty_unit == "" || qty == "" || total == "") {

                        alert("All Fields are mandatory");
                        return false;
                    }
                }
                return true;
            }

        </script>
    </fieldset>
</body>
</html>

