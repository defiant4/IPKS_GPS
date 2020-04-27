<%-- 
    Document   : gl
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="DataEntryBean.GlProductOperationBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>

        <title>Asset Type Master</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function submitform(tradingPurchaseOrder)
            {
                if (checkCreateDiv(tradingPurchaseOrder))
                {
                    document.forms[0].action = "/PacsApplication/tradingPurchaseOrderServlet";
                    document.forms[0].submit();
                }

            }
            function checkCreateDiv(tradingPurchaseOrder)
            {
                if (tradingPurchaseOrder.trading_ref_no.value == "")
                {
                    alert("!! Purchase Ref. field must be filled !!");
                    tradingPurchaseOrder.trading_ref_no.focus();
                    return false;
                }
                if (tradingPurchaseOrder.trading_code.value == "")
                {
                    alert("!! Product Code field must be filled !!");
                    tradingPurchaseOrder.trading_code.focus();
                    return false;
                }

                if (tradingPurchaseOrder.trading_purchase_desc.value == "")
                {
                    alert("!! purchase description field must be filled !!");
                    tradingPurchaseOrder.trading_purchase_desc.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (tradingPurchaseOrder.unit.value == "")
                {
                    alert("!! Unit field must be filled !!");
                    tradingPurchaseOrder.unit.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(tradingPurchaseOrder.unit_price.value))
                {
                    alert("!! Unit could only contain numbers !!");
                    tradingPurchaseOrder.unit_price.focus();
                    return false;
                }


                return true;
            }
            
             function Total(){

                    var priceDetails = document.getElementById("unit_price").value;
                    var quantityDetails = document.getElementById("unit").value;

                    document.getElementById("total").value=priceDetails*quantityDetails;

                }
                
                function search_product(width, height, trading_code) {

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
                var screenName = "raisePurchaseOrder.jsp";
                var lovKey = "prodDetails"
                popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?trading_code=' + trading_code + '&screenName=' + screenName + '&lovKey=' + lovKey, 'prodDetails', attr);
                popWin.focus();

            }
            
            function isNumber(evt){
                evt = (evt)? evt : window.event;
                var charCode = (evt.which) ? evt.which:evt.keyCode;
                if(charCode > 31 && (charCode<48 || charCode>57)){
                    return false;
                }
                return true;
            }

        </script>

        <%
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>



        <jsp:include page="MenuHead_TRADING.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>



        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">Raise Purchase Order</legend>

            <form name="tradingPurchaseOrder" method="post" action="tradingPurchaseOrderServlet"> 

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>
                <br>


                <br>

                <div id="create" >
                    <table>
                        <tbody>
                            <tr>
                                <td>Purchase Reference No:</td>
                                <td><input type="text" name="trading_ref_no" id="trading_ref_no" style="width: 260px" value="" /></td>
                            </tr>
                            <tr>
                                <td>Item Code: </td>
                                <td> <input type="text" name="trading_code" id="trading_code" /></td>
                                <td><input type="button"  value="Search" onclick="javascript:search_product(220, 180,document.tradingPurchaseOrder.trading_code.value)" /></td>
                            </tr>
                            <tr>
                                <td>Purchase Description:</td>
                                <td><textarea rows="4" cols="50"  name="trading_purchase_desc" id="trading_purchase_desc" style="width: 259px"></textarea></td>
                            </tr>
                            <tr>

                                <td>No. of Units:</td>
                                <td><input type="text" name="unit" id="unit"style="width: 260px" value="" onchange="Total();" onkeypress="return isNumber();" /></td>
                            </tr>
                            <tr>
                                <td>Per/Units Price:</td>
                                <td><input type="text" name="unit_price" id="unit_price"style="width: 260px" value="" onchange="Total();" onkeypress="return isNumber();" /></td>
                            </tr>
                            <tr>
                                <td>Total:</td>
                                <td><input type="text" readonly name="total" id="total"style="width: 260px" value="" /></td>
                            </tr>



                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            <tr><td><label>All fields are mandatory</label></td></tr>
                        </tbody>
                    </table><br><br>

                    <center>
                        <input type="button" value="Generate Purchase Order" onclick="javascript:submitform(tradingPurchaseOrder)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                </div>



            </form>
        </fieldset>   
    </body>
</html>





