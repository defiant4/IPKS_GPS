<%-- 
    Document   : SellProcureItem
    Created on : Jul 15, 2016, 11:03:20 AM
    Author     : Tcs Helpdesk10
--%>

<%@page import="DataEntryBean.GPSSellProcurementBean"%>
<%@page import="DataEntryBean.GovtOrderCreationExpenseBean"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.SellProcureItemBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sell Procure Item</title>
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

        <%          int count1 = 1;
            String error_msg1 = "";
            Object error1 = request.getAttribute("message");
            if (error1 != null) {
                error_msg1 = error.toString();
            }
        %>
        <script>
            function  calculate()
            {
                var counter = document.forms[0].rowCounter.value;

                for (var i = 1; i <= counter; i++) {
                    var total = document.getElementById("total" + i).value;
                    if (total == "") {
                        alert("All Fields are mandatory");
                        return false;
                    }
                    else {
                        document.forms[0].handle_id.value = "calculate";
                        document.forms[0].action = '/PacsApplication/SellProcureItemServlet';
                        document.forms[0].submit();
                    }
                }
            }
        </script>

        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>


        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }

            Object govtOrderCreationExpenseBeanObj = request.getAttribute("oGovtOrderCreationExpenseBean");

            GovtOrderCreationExpenseBean govtOrderCreationExpenseBeanObjApend = new GovtOrderCreationExpenseBean();
            if (govtOrderCreationExpenseBeanObj != null) {
                govtOrderCreationExpenseBeanObjApend = (GovtOrderCreationExpenseBean) request.getAttribute("oGovtOrderCreationExpenseBean");
            }

            GovtOrderCreationExpenseBean oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();

            Object AlGovtOrderCreationExpenseBean = request.getAttribute("alGovtOrderCreationExpenseBean");
            ArrayList<GovtOrderCreationExpenseBean> alGovtOrderCreationExpenseBean = new ArrayList<GovtOrderCreationExpenseBean>();
            if (AlGovtOrderCreationExpenseBean != null) {
                alGovtOrderCreationExpenseBean = (ArrayList<GovtOrderCreationExpenseBean>) request.getAttribute("alGovtOrderCreationExpenseBean");
            }

            Object AlGPSSellProcurementBean = request.getAttribute("alGPSSellProcurementBean");
            ArrayList<GPSSellProcurementBean> alGPSSellProcurementBean = new ArrayList<GPSSellProcurementBean>();
            if (AlGPSSellProcurementBean != null) {
                alGPSSellProcurementBean = (ArrayList<GPSSellProcurementBean>) request.getAttribute("alGPSSellProcurementBean");
            }
            GPSSellProcurementBean oGPSSellProcurementBean = new GPSSellProcurementBean();
        %>

        <jsp:include page="MenuHead_GPS.jsp" flush="true" />    
        <br>



        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">Sell Procure Item Details</legend>

            <form name="sellProcureForm" method="post" onsubmit="return checkDiv(this)" action="SellProcureItemServlet">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>          
                            <% }%>
                <br>
                <div id="create">
                    <table>
                        <tr><td><h4>Sell Details</h4></td></tr>
                        <tr>
                            <td><lable>Sell To :</lable></td>
                        <td><input type="text" id="sellTo" name="sellTo" value="<%=blankNull(govtOrderCreationExpenseBeanObjApend.getSell())%>" ></td>
                        </tr>
                        <tr>
                            <td><lable>Delievered To :</lable></td>
                        <td><input type="text" id="deliveredTo" name="deliveredTo" value="<%=blankNull(govtOrderCreationExpenseBeanObjApend.getDeliver())%>" ></td>
                        </tr>
                        <tr>
                            <td><lable>Address :</lable></td>
                        <td><textarea type="text" id="addr" name="addr" ><%=blankNull(govtOrderCreationExpenseBeanObjApend.getAddress())%></textarea></td>   
                        </tr> 
                        <tr>
                            <td><lable>Govt.Procurement Code :</lable></td>
                        <td><input type="text" id="govProcCode" name="govProcCode" value="<%=blankNull(govtOrderCreationExpenseBeanObjApend.getGovtOrderCode())%>" ></td>  
                        <td><input type="button"  value="Search" onclick="javascript:popup_Proc(250, 180)" /></td>
                        <td><input type="hidden" id="govtProcId" name="govtProcId" value="<%=blankNull(govtOrderCreationExpenseBeanObjApend.getGovtOrderId())%>" ></td>
                        </tr>
                        <tr><td><hr></td></tr>
                    </table>

                    <h4>Item Details</h4>

                    <center>
                        <table id="order-list" style="margin-left: 20px;">
                            <thead class="CSSTableGenerator" >
                                <tr>
                                    <td></td>
                                    <td>Item Type:Desc</td>
                                    <td >Item SubType:Desc</td>
                                    <td></td>
                                    <td>Procurement ID</td>
                                    <td>Item Unit</td>
                                    <td>Item Rate Per Unit</td>
                                    <td>Item Quantity</td>
                                    <td>Selling Quantity</td>
                                    <td>Total</td>


                                </tr>
                            </thead>
                            <%
                                if (displayFlag.equalsIgnoreCase("Y")) {
                                    for (int i = 0; i < alGPSSellProcurementBean.size(); i++) {
                                        oGPSSellProcurementBean = alGPSSellProcurementBean.get(i);

                            %>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" name="chckbox_AfterCalc<%=i%>" id="chckboxAfterCalc<%=i%>"  /></td>
                                    <td><input type="text" readonly name="item_descAfterCalc<%=i%>" id="item_descAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getItem_desc())%>" /></td>
                                    <td><input type="text" readonly name="subtype_descAfterCalc<%=i%>" id="subtype_descAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getSubtype_desc())%>"/></td>
                                    <td><input type="button" name="SearchItem" id="SearchItem" value="Search"   /></td>
                                    <td><input type="text" readonly name="procIdAfterCalc<%=i%>" id="procIdAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getProcId())%>"/></td>
                                    <td><input type="text" readonly name="item_unitAfterCalc<%=i%>" id="item_unitAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getItem_unit())%>"/></td>
                                    <td><input type="text" readonly name="item_rateperunitAfterCalc<%=i%>" id="item_rateperunitAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getItem_rateperunit())%>" /></td>
                                    <td><input type="text" readonly size="15" name="qtyAfterCalc<%=i%>" id="qtyAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getQty())%>" /></td>
                                    <td><input type="text" size="15" name="sell_qtyAfterCalc<%=i%>" id="sell_qtyAfterCalc<%=i%>"  value="<%=blankNull(oGPSSellProcurementBean.getSell_qty())%>" /></td>
                                    <td><input type="text" readonly size="15" name="totalAfterCalc<%=i%>" id="totalAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getTotal())%>"/></td>
                                    <td><input type="hidden" name="commodityIdAfterCalc<%=i%>" id="commodityIdAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getCommodityId())%>" /></td>
                                    <td><input type="hidden" name="item_typeAfterCalc<%=i%>" id="item_typeAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getItem_type())%>"/></td>
                                    <td><input type="hidden" name="item_subtypeAfterCalc<%=i%>" id="item_subtypeAfterCalc<%=i%>" value="<%=blankNull(oGPSSellProcurementBean.getItem_subtype())%>"/></td>
                                </tr>
                            </tbody>

                            
                            <%}%>
                                    <input type="hidden" name="rowCounter_afterCalculate" id="rowCounter_afterCalculate" value="<%=alGPSSellProcurementBean.size()%>">
                            <%} else {%> 

                            <tbody>
                                <tr>
                                    <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                    <td><input type="text" readonly name="item_desc<%=count%>" id="item_desc<%=count%>"/></td>
                                    <td><input type="text" readonly name="subtype_desc<%=count%>" id="subtype_desc<%=count%>"/></td>
                                    <td><input type="button" name="SearchItem<%=count%>" id="SearchItem<%=count%>" value="Search"  onclick="SearchItem(600, 180,<%=count%>, document.sellProcureForm.govtProcId.value)" /></td>
                                    <td><input type="text" readonly name="procId<%=count%>" id="procId<%=count%>"/></td>
                                    <td><input type="text" readonly name="item_unit<%=count%>" id="item_unit<%=count%>"/></td>
                                    <td><input type="text" readonly name="item_rateperunit<%=count%>" id="item_rateperunit<%=count%>"  onchange="Total(<%=count%>);"/></td>
                                    <td><input type="text" readonly size="15" name="qty<%=count%>" id="qty<%=count%>"  onchange="Total(<%=count%>);"/></td>
                                    <td><input type="text" size="15" name="sell_qty<%=count%>" id="sell_qty<%=count%>"  onchange="Total(<%=count%>);"/></td>
                                    <td><input type="text" readonly size="15" name="total<%=count%>" id="total<%=count%>"/></td>
                                    <td><input type="hidden" name="commodityId<%=count%>" id="commodityId<%=count%>" </td>
                                    <td><input type="hidden" name="item_type<%=count%>" id="item_type<%=count%>"/></td>
                                    <td><input type="hidden" name="item_subtype<%=count%>" id="item_subtype<%=count%>"/></td>
                                </tr>
                            </tbody>
                            <%if (!displayFlag.equalsIgnoreCase("Y")) {%>
                            <tr><td></td></tr><tr><td></td></tr>
                            <tr><td></td></tr><tr><td></td></tr>
                            <tr><td></td></tr><tr><td></td></tr>
                            <tr><td></td></tr>
                        </table>
                        <%}%>
                        <center>
                            <input type="button" id="addRow" value="Add Row"/>
                            <input type="button" id="deleteRow" value="Delete Row"/>
                            <input type="button" value="Reset" onclick="ShowParent();" />
                            <br><br/>
                            <input type="button" id="next" value="Next" style="float:right;" onclick="calculate();"/>
                        </center>


                        <%}%>
                        </table>

                        <br/><br/>

                    </center>




                    <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">


                </div>
                <%
                    if (displayFlag.equalsIgnoreCase("Y")) {

                %>
                <div id="amend">

                    <tr><td><hr></td></tr>


                    <h4>Expense</h4>

                    <center>
                        <table id="order1-list" style="margin-left: 20px;">

                            <thead class="CSSTableGenerator" >
                                <tr>

                                    <td>Expense Details</td>
                                    <td>Expense Charges</td>
                                    <td>Expense Total</td>



                                </tr>
                            </thead>
                            <tbody>
                                <% if (alGovtOrderCreationExpenseBean.size() > 0) {%>
                                <% for (int i = 0; i < alGovtOrderCreationExpenseBean.size(); i++) {
                                        oGovtOrderCreationExpenseBean = alGovtOrderCreationExpenseBean.get(i);
                                %>
                                <tr>

                                    <td><select style="width: 153px;" name="expense_details<%=i%>" id="expense_details<%=i%>">
                                            <%  if (oGovtOrderCreationExpenseBean.getExpense_head().equals("L")) { %>
                                            <option value="L">Labour Charge</option> <%}%>
                                            <%  if (oGovtOrderCreationExpenseBean.getExpense_head().equals("T")) { %>
                                            <option value="T">Transport Charge</option> <%}%>
                                            <%  if (oGovtOrderCreationExpenseBean.getExpense_head().equals("I")) { %>
                                            <option value="I">Interest Charge</option> <%}%>
                                            <%  if (oGovtOrderCreationExpenseBean.getExpense_head().equals("D")) { %>
                                            <option value="D">Driage Charge</option> <%}%>
                                            <%  if (oGovtOrderCreationExpenseBean.getExpense_head().equals("O")) { %>
                                            <option value="O">Others</option> <%}%>
                                        </select></td>
                                    <td><input type="text" name="expense_charges" id="expense_charges" value="<%=oGovtOrderCreationExpenseBean.getExpense_rate_per_unit()%>"/></td>
                                    <td><input type="text" name="expense" id="expense" value="<%=oGovtOrderCreationExpenseBean.getExpense_total_individual()%>"/></td>

                                </tr>
                            </tbody>
                            <%}%>
                            <table style="margin-left: 180px;">
                                <tr><td></td></tr><tr><td></td></tr>
                                <tr><td></td></tr><tr><td></td></tr>
                                <tr><td></td></tr><tr><td></td></tr>
                                <tr><td></td></tr>
                                <tr>
                                    <td><input type="Button" name="" id="" value="Total Expense"/></td>
                                    <td><input type="text" name="expense_total" id="expense_total" value="<%=govtOrderCreationExpenseBeanObjApend.getExpense_total_grand()%>"/></td>
                                </tr></table>
                                <%}%>
                        </table>

                        <br/><br/>
                    </center>
                    <input type="hidden" name="rowCounter1" id="rowCounter1" value="<%=count1%>">
                    <br></br>
                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(sellProcureForm)">
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                    </center>
                    <br>
                    <br>
                </div>
                <%}%>
                <label style=" font-family: Berlin Sans FB; font-weight:normal; ">All fields are mandatory</label>
                <input type="hidden" name="handle_id" id="handle_id">
            </form>
            <script>


                $("#addRow").click(function () {
                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr> <td><input type="checkbox" name="chckbox' + counter + '" id="chckbox' + counter + '" /></td><td><input type="text" name="item_desc' + counter + '" readonly id="item_desc' + counter + '"/></td><td><input type="text" readonly name="subtype_desc' + counter + '" id="subtype_desc' + counter + '"/></td><td><input type="button" name="SearchItem' + counter + '" id="SearchItem' + counter + '" value="Search"  onclick="SearchItem(600, 180,' + counter + ',document.sellProcureForm.govtProcId.value)" /></td><td><input type="text" readonly name="procId' + counter + '" id="procId' + counter + '"/></td><td><input type="text" readonly name="item_unit' + counter + '" id="item_unit' + counter + '"/></td><td><input type="text" readonly name="item_rateperunit' + counter + '" id="item_rateperunit' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" readonly size="15" name="qty' + counter + '" id="qty' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" size="15" name="sell_qty' + counter + '" id="sell_qty' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" size="15" name="total' + counter + '" readonly id="total' + counter + '"</td><td><input type="hidden" name="commodityId' + counter + '" id="commodityId' + counter + '" </td><td><input type="hidden" name="item_type' + counter + '" id="item_type' + counter + '"/></td><td><input type="hidden" name="item_subtype' + counter + '" id="item_subtype' + counter + '"/></td> </tr>');
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

                function popup_Proc(width, height) {
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
                    var screenName = "SellProcureItem.jsp";
                    var lovKey = "govtprocuredetails"
                    popWin = open('/PacsApplication/CommonSearchInformation_GPS_LOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey, 'SellProcureDetails', attr);
                    popWin.focus();

                }

                function SearchItem(width, height, i, govtProcId) {
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
                    var screenName = "SellProcureItem.jsp";
                    var lovKey = "SellProcureDetails"
                    popWin = open('/PacsApplication/CommonSearchInformation_GPS_LOV.jsp?govtProcId=' + govtProcId + '&textIndex=' + i + '&screenName=' + screenName + '&lovKey=' + lovKey, 'SellProcureDetails', attr);
                    popWin.focus();

                }

                function Total(i) {

                    var qtyDetails = document.getElementById("sell_qty" + i).value;
                    var rateDetails = document.getElementById("item_rateperunit" + i).value;

                    document.getElementById("total" + i).value = rateDetails * qtyDetails;

                }

                function ShowParent()
                {
                    document.forms[0].action = "/PacsApplication/GPS_JSP/SellProcureItem.jsp";
                    document.forms[0].submit();
                }

                function submitform(sellProcureForm)
                {
                    if (checkCreateDiv(sellProcureForm))
                    {
                        document.forms[0].handle_id.value = "Create";
                        document.forms[0].action = '/PacsApplication/SellProcureItemServlet';
                        document.forms[0].submit();
                    }
                }
                function checkCreateDiv(sellProcureForm)
                {

                    if (sellProcureForm.sellTo.value === "")
                    {
                        alert("!! All fields must be filled !!");
                        sellProcureForm.sellTo.focus();
                        return false;
                    }
                    if (sellProcureForm.deliveredTo.value === "")
                    {
                        alert("!! All fields must be filled !!");
                        sellProcureForm.deliveredTo.focus();
                        return false;
                    }
                    if (sellProcureForm.addr.value === "")
                    {
                        alert("!! All fields must be filled !!");
                        sellProcureForm.addr.focus();
                        return false;
                    }
                    if (sellProcureForm.govProcCode.value === "")
                    {
                        alert("!! All fields must be filled !!");
                        sellProcureForm.govProcCode.focus();
                        return false;
                    }
                    return true;
                }
   

            </script>

           
            <script>
                //window.onload = hide();
            </script>
        </fieldset>
    </body>
</html>