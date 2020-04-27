<%-- 
    Document   : GovtOrderCreation
    Created on : Jul 14, 2016, 11:09:54 AM
    Author     : Tcs Helpdesk10
--%>


<%@page import="DataEntryBean.GovtOrderCreationExpenseBean"%>
<%@page import="DataEntryBean.GovtOrderCreationDetailBean"%>
<%@page import="DataEntryBean.GovtOrderCreationHeaderBean"%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.GovtOrderCreationBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="${pageContext.request.contextPath}/js/Calendar.js"></script> 
        <title>Government Order Creation</title>
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
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            int count = 1;
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
            ///////////////////////////////////////////
            int count1 = 1;
            String error_msg1 = "";
            Object error1 = request.getAttribute("message");
            if (error1 != null) {
                error_msg1 = error.toString();
            }
            ///////////////////////////////////////////////

            int count3 = 1;
            String error_msg3 = "";
            Object error3 = request.getAttribute("message");
            if (error1 != null) {
                error_msg1 = error.toString();
            }
            ////////////////////////////////////

            int count4 = 1;
            String error_msg4 = "";
            Object error4 = request.getAttribute("message");
            if (error1 != null) {
                error_msg1 = error.toString();
            }

            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
            /////////////////////////////////////////////////////
            Object GovtOrderCreationHeaderBeanObj = request.getAttribute("GovtOrderCreationHeaderBeanObj");
            GovtOrderCreationHeaderBean oGovtOrderCreationHeaderBean = new GovtOrderCreationHeaderBean();
            if (GovtOrderCreationHeaderBeanObj != null) {
                oGovtOrderCreationHeaderBean = (GovtOrderCreationHeaderBean) request.getAttribute("GovtOrderCreationHeaderBeanObj");
            }

            Object alGovtOrderCreationDetailBeanObj = request.getAttribute("alGovtOrderCreationDetailBean");
            ArrayList<GovtOrderCreationDetailBean> alGovtOrderCreationDetailBean = new ArrayList<GovtOrderCreationDetailBean>();
            GovtOrderCreationDetailBean oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
            if (alGovtOrderCreationDetailBeanObj != null) {
                alGovtOrderCreationDetailBean = (ArrayList<GovtOrderCreationDetailBean>) request.getAttribute("alGovtOrderCreationDetailBean");

            }

            //////////////////////////
            Object alGovtOrderCreationExpenseBeanObj = request.getAttribute("alGovtOrderCreationExpenseBean");
            ArrayList<GovtOrderCreationExpenseBean> alGovtOrderCreationExpenseBean = new ArrayList<GovtOrderCreationExpenseBean>();
            GovtOrderCreationExpenseBean oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
            if (alGovtOrderCreationExpenseBeanObj != null) {
                alGovtOrderCreationExpenseBean = (ArrayList<GovtOrderCreationExpenseBean>) request.getAttribute("alGovtOrderCreationExpenseBean");

            }

        %>


        <jsp:include page="MenuHead_GPS.jsp" flush="true" />    
        <br>



        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">Government Order Creation</legend>

            <form name="govtOrderCreatForm" method="post" onsubmit="return checkDiv(this)" action="GovtOrderCreationServlet.jsp">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>          
                            <% }%>
                <br>
                <br>

                <center><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</label>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" >--select--</option>
                        <option value="create" >Create</option>
                        <option value="amend" >Amend</option>

                    </select>
                </center>
                <br>
                <br>

                <div id="create" style="display: none;">
                    <table>
                        <tr><td><hr></td></tr>
                        <tr><td><h4>Government Order Information</h4></td></tr>

                        <tr>
                            <td><lable>Govt.Order Code :</lable></td>
                        <td><input type="text" id="govtOrderCodeCreate" name="govtOrderCodeCreate" ></td>

                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td><lable>Description :</lable></td>
                        <td><input type="text" id="govtOrderDesc" name="govtOrderDesc" ></td>   
                        </tr> 


                        <tr>
                            <td><lable>Procurement Start Date :</lable></td>
                        <td><input type="text" id="procStartDate" name="procStartDate" readonly="true"><a href="#" onclick="return getCalendar(getElementById('procStartDate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>                        
                        </tr>

                        <tr>
                            <td><lable>Procurement End Date :</lable></td>
                        <td><input type="text" id="procEndDate" name="procEndDate" readonly="true"><a href="#" onclick="return getCalendar(document.forms[0].procEndDate);"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>                        
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
                                    <td></td>
                                    <td>Item Unit</td>
                                    <td>Quantity</td>
                                    <td>Item Rate Per Unit</td>
                                    <td>Total</td>


                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                    <td><input readonly type="text" name="item_desc<%=count%>" id="item_desc<%=count%>"/></td>
                                    <td><input readonly type="text" name="subtype_desc<%=count%>" id="subtype_desc<%=count%>"/></td>
                                    <td><input type="button" name="SearchItem<%=count%>" id="SearchItem<%=count%>" value="Search"  onclick="SearchItem(330, 180,<%=count%>)" /></td>
                                    <td><input type="text" name="item_unit<%=count%>" id="item_unit<%=count%>"/></td>
                                    <td><input type="text" name="qty<%=count%>" id="qty<%=count%>"  onchange="Total(<%=count%>);"/></td>
                                    <td><input type="text" name="item_rateperunit<%=count%>" id="item_rateperunit<%=count%>"  onchange="Total(<%=count%>);"/></td>
                                    <td><input type="text" name="total<%=count%>" id="total<%=count%>"/></td>
                                    <td><input type="hidden" name="commodityId<%=count%>" id="commodityId<%=count%>" </td>
                                    <td><input type="hidden" name="item_type<%=count%>" id="item_type<%=count%>"/></td>
                                    <td><input type="hidden" name="item_subtype<%=count%>" id="item_subtype<%=count%>"/></td>
                                </tr>
                            </tbody>
                        </table>

                        <br/><br/>

                    </center>
                    <center>
                        <input type="button" id="addRow" value="Add Row"/>
                        <input type="button" id="deleteRow" value="Delete Row"/>



                    </center>
                    <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">

                    <table>
                        <tr><td><hr></td></tr>
                        <tr><td><h4>Commission Details</h4></td></tr>
                        <tr>
                            <td>Procurement Commission Rate</td>
                            <td><input type="text" id="govtCommission" name="govtCommission" > Per Unit</td>                    
                        </tr>
                        <tr><td><hr></td></tr>
                    </table><br>

                    <h4>Expense Details</h4>

                    <center>
                        <table id="order1-list" style="margin-left: 20px;">
                            <thead class="CSSTableGenerator" >
                                <tr>
                                    <td></td>
                                    <td>Expense Head</td>
                                    <td>Expense Unit</td>
                                    <td>Expense Rate Per Unit</td>



                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" name="chckbox1<%=count1%>" id="chckbox1<%=count1%>" /></td>
                                    <td><select style="width: 153px;" name="expense_head<%=count1%>" id="expense_head<%=count1%>"><option disabled selected>select</option>
                                            <option value="L">Labour Charge</option>
                                            <option value="T">Transport Charge</option>
                                            <option value="I">Interest Charge</option>
                                            <option value="D">Driage Charge</option>
                                            <option value="O">Others</option>
                                        </select></td>
                                    <td><select style="width: 153px;" name="expense_unit<%=count1%>" id="expense_unit<%=count1%>"><option disabled selected>select</option>
                                            <option value="kg">kg</option>
                                            <option value="ltr">litre</option>
                                            <option value="pack">packet</option>
                                            <option value="quin">quintal</option>
                                        </select></td>
                                    <td><input type="text" name="expense_rate_per_unit<%=count1%>" id="expense_rate_per_unit<%=count1%>"/></td>

                                </tr>
                            </tbody>
                        </table>

                        <br/><br/>

                    </center>

                    <center>
                        <input type="button" id="addRow1" value="Add Row"/>
                        <input type="button" id="deleteRow1" value="Delete Row"/>
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />



                    </center>
                    <input type="hidden" name="rowCounter1" id="rowCounter1" value="<%=count1%>">
                    <br></br>
                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(govtOrderCreatForm)">

                    </center>
                    <br>
                    <br>
                    <label style=" font-family: Berlin Sans FB; font-weight:normal; ">All fields are mandatory</label>
                </div>


                <div id="amend" style="display: none;">
                    <center>
                        <table>
                            <tr>
                                <td>Govt. Order Code: </td>
                                <td> <input type="text" name="govtOrderCode" id="govtOrderCode" value=""/></td>
                                <td><input type="button"  value="Search" onclick="javascript:popup_Order_code(220, 180)" /></td>
                            </tr>
                            <tr>
                                <td>Govt. Order Id: </td>
                                <td><input type="text" name="govtOrderId" id="govtOrderId" value=""/></td>

                            </tr>
                        </table>
                        <br>

                        <input type="button"  value="Submit" onclick="javascript:searchOrderdetails()" />


                    </center><br>
                </div> 

                <%if (displayFlag.equalsIgnoreCase("Y")) {%>

                <div id="amend2" >


                    <table>
                        <tbody>
                            <tr><td><hr></td></tr>
                            <tr><td><h4>Government Order Information</h4></td></tr>
                            <tr>
                                <td><lable>Govt.Order Code :</lable></td>
                        <td><input type="text" id="govtOrderCodeCreateAmend" readonly name="govtOrderCodeCreateAmend" value="<%=blankNull(oGovtOrderCreationHeaderBean.getGovtOrderCodeCreate())%>" ></td>

                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td><lable>Description :</lable></td>
                        <td><input type="text" id="govtOrderDescAmend" name="govtOrderDescAmend" value="<%=blankNull(oGovtOrderCreationHeaderBean.getGovtOrderDesc())%>" ></td>   
                        </tr> 
                        <tr>
                            <td><lable>Procurement Start Date :</lable></td>
                        <td><input type="text" id="procStartDateAmend" name="procStartDateAmend" readonly="true" value="<%=blankNull(oGovtOrderCreationHeaderBean.getProcStartDate())%>"><a href="#" onclick="return getCalendar(getElementById('procStartDate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>                        
                        </tr>
                        <tr>
                            <td><lable>Procurement End Date :</lable></td>
                        <td><input type="text" id="procEndDateAmend" name="procEndDateAmend" readonly="true" value="<%=blankNull(oGovtOrderCreationHeaderBean.getProcEndDate())%>"><a href="#" onclick="return getCalendar(document.forms[0].procEndDate);"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>                        
                        </tr>

                        <tr><td><hr></td></tr>
                        </tbody>
                    </table>
                    <input type="hidden" name="orderidAmend" id="orderidAmend" value="<%=blankNull(oGovtOrderCreationHeaderBean.getGovtOrderId())%>" />

                    <h4>Item Details</h4>
                    <center>

                        <table id="order-listAmmend" style="margin-left: 20px;">
                            <thead class="CSSTableGenerator" >
                                <tr>
                                    <td></td>
                                    <td>Item Type</td>
                                    <td >Item SubType</td>
                                    <td></td>
                                    <td>Item Unit</td>
                                    <td>Quantity</td>
                                    <td>Item Rate Per Unit</td>
                                    <td>Total</td>


                                </tr>
                            </thead>
                            <tbody>

                                <%
                                    oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
                                    count3 = 0;

                                    for (int i = 0; i < alGovtOrderCreationDetailBean.size(); i++) {
                                        oGovtOrderCreationDetailBean = alGovtOrderCreationDetailBean.get(i);

                                        count3++;

                                %>

                                <tr>
                                    <td><input type="checkbox" name="chckboxAmend<%=count3%>" id="chckboxAmend<%=count3%>" onclick="checkboxTrueAmend(<%=count3%>);" value="<%=blankNull(oGovtOrderCreationDetailBean.getDetailID())%>" /></td>
                                    <td><input readonly type="text" name="item_descAmend<%=count3%>" id="item_descAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getItem_desc())%>" /></td>
                                    <td><input readonly type="text" name="subtype_descAmend<%=count3%>" id="subtype_descAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getSubtype_desc())%>"/></td>
                                    <td><input type="button" name="SearchItem<%=count3%>" id="SearchItem<%=count3%>" value="Search"  onclick="SearchItem(330, 180,<%=count3%>)" /></td>
                                    <td><input type="text" name="item_unitAmend<%=count3%>" id="item_unitAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getItem_unit())%>"/></td>
                                    <td><input type="text" name="qtyAmend<%=count3%>" id="qtyAmend<%=count3%>"  onchange="TotalAmend(<%=count3%>);" value="<%=blankNull(oGovtOrderCreationDetailBean.getQty())%>"/></td>
                                    <td><input type="text" name="item_rateperunitAmend<%=count3%>" id="item_rateperunitAmend<%=count3%>"  onchange="TotalAmend(<%=count3%>);" value="<%=blankNull(oGovtOrderCreationDetailBean.getItem_rateperunit())%>"/></td>
                                    <td><input type="text" name="totalAmend<%=count3%>" id="totalAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getTotal())%>"/></td>
                                    <td><input type="hidden" name="commodityIdAmend<%=count3%>" id="commodityIdAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getCommodityId())%>" </td>
                                    <td><input type="hidden" name="item_typeAmend<%=count3%>" id="item_typeAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getItem_type())%>"/></td>
                                    <td><input type="hidden" name="item_subtypeAmend<%=count3%>" id="item_subtypeAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getItem_subtype())%>"/></td>
                                    <td><input type="hidden" name="rowStatus<%=count3%>" id="rowStatus<%=count3%>" value="A"/></td>
                                    <td><input type="hidden" name="detailIDAmend<%=count3%>" id="detailIDAmend<%=count3%>" value="<%=blankNull(oGovtOrderCreationDetailBean.getDetailID())%>" /></td>
                                </tr>

                                <%}%>
                            </tbody>
                        </table>
                    </center>
                    <br>
                    <center>
                        <input type="button" id="addRowAmend" value="Add Row"/>
                        <input type="button" id="deleteRowAmend" value="Delete Row"/>

                        <input type="button" value="Reset" onclick="ShowParent();" /> 


                    </center>



                    <table>
                        <tr><td><hr></td></tr>
                        <tr><td><h4>Commission Details</h4></td></tr>
                        <tr>
                            <td>Procurement Commission Rate</td>
                            <td><input type="text" id="govtCommissionAmend" name="govtCommissionAmend" value="<%=blankNull(oGovtOrderCreationHeaderBean.getGovtCommission())%>"> Per Unit</td>                    
                        </tr>
                        <tr><td><hr></td></tr>
                    </table><br>

                    <h4>Expense Details</h4>

                    <center>
                        <table id="order1-listAmend2" style="margin-left: 20px;">
                            <thead class="CSSTableGenerator" >
                                <tr>
                                    <td></td>
                                    <td>Expense Head</td>
                                    <td>Expense Unit</td>
                                    <td>Expense Rate Per Unit</td>



                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
                                    count4 = 0;

                                    for (int i = 0; i < alGovtOrderCreationExpenseBean.size(); i++) {
                                        oGovtOrderCreationExpenseBean = alGovtOrderCreationExpenseBean.get(i);

                                        count4++;

                                %>
                                <tr>
                                    <td><input type="checkbox" name="chckbox1<%=count4%>" id="chckbox1<%=count4%>" /></td>
                                    <td><select style="width: 153px;" name="expense_head<%=count4%>" id="expense_head<%=count4%>">
                                            <option disabled selected>select</option>
                                            <option value="L" <%if (oGovtOrderCreationExpenseBean.getExpense_head().equals("L")) {%> selected <%}%>>Labour Charge</option>
                                            <option value="T" <%if (oGovtOrderCreationExpenseBean.getExpense_head().equals("T")) {%> selected <%}%>>Transport Charge</option>
                                            <option value="I" <%if (oGovtOrderCreationExpenseBean.getExpense_head().equals("I")) {%> selected <%}%>>Interest Charge</option>
                                            <option value="D" <%if (oGovtOrderCreationExpenseBean.getExpense_head().equals("D")) {%> selected <%}%>>Driage Charge</option>
                                            <option value="O" <%if (oGovtOrderCreationExpenseBean.getExpense_head().equals("O")) {%> selected <%}%>>Others</option>
                                        </select></td>
                                    <td><select style="width: 153px;" name="expense_unit<%=count4%>" id="expense_unit<%=count4%>">
                                            <option disabled selected>select</option>
                                            <option value="kg" <%if (oGovtOrderCreationExpenseBean.getExpense_unit().equals("kg")) {%> selected <%}%>>kg</option>
                                            <option value="ltr" <%if (oGovtOrderCreationExpenseBean.getExpense_unit().equals("ltr")) {%> selected <%}%>>litre</option>
                                            <option value="pack" <%if (oGovtOrderCreationExpenseBean.getExpense_unit().equals("pack")) {%> selected <%}%>>packet</option>
                                            <option value="quin" <%if (oGovtOrderCreationExpenseBean.getExpense_unit().equals("quin")) {%> selected <%}%>>quintal</option>
                                        </select></td>
                                    <td><input type="text" name="expense_rate_per_unit<%=count4%>" id="expense_rate_per_unit<%=count4%>" value="<%=blankNull(oGovtOrderCreationExpenseBean.getExpense_rate_per_unit())%>"/></td>

                                </tr>
                                <%}%>
                            </tbody>
                        </table>

                        <br/><br/>

                    </center>

                    <center>
                        <input type="button" id="addRowAmend2" value="Add Row"/>
                        <input type="button" id="deleteRowAmend2" value="Delete Row"/>
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />



                    </center>

                    <br></br>
                    <center>
                        <input type="button" value="Update" onclick="javascript:submitform_afterAmend(govtOrderCreatForm)">

                    </center>
                    <br>
                    <br>
                    <label style=" font-family: Berlin Sans FB; font-weight:normal; ">All fields are mandatory</label>

                </div>
                <%}%>

                <input type="hidden" name="handle_id" value="" />
                
                <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>"/>
                 <input type="hidden" name="rowCounter1" id="rowCounter1" value="<%=count1%>"/>
                <input type="hidden" name="rowCounterAmend" id="rowCounterAmend" value="<%=count3%>"/>
                <input type="hidden" name="rowCounterAmend2" id="rowCounterAmend2" value="<%=count4%>"/>
                
                
                <input type="hidden" name="rowCounterDelete" id="rowCounterDelete" value="<%=count3%>"/>
                <input type="hidden" name="rowCounterDelete_Expn" id="rowCounterDelete_Expn" value="<%=count4%>"/>
                
                <input type="hidden" name="chkboxCounter" id="chkboxCounter" value="0"/>
                <input type="hidden" name="deletedRows" id="deletedRows" value=""/>

            </form>
            <script>

                $("#addRow").click(function () {
                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr> <td><input type="checkbox" name="chckbox' + counter + '" id="chckbox' + counter + '" /></td><td><input type="text" readonly name="item_desc' + counter + '" id="item_desc' + counter + '"/></td><td><input type="text" readonly name="subtype_desc' + counter + '" id="subtype_desc' + counter + '"/></td><td><input type="button" name="SearchItem' + counter + '" id="SearchItem' + counter + '" value="Search"  onclick="SearchItem(330, 180,' + counter + ')" /></td><td><input type="text" name="item_unit' + counter + '" id="item_unit' + counter + '"/></td><td><input type="text" name="qty' + counter + '" id="qty' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" name="item_rateperunit' + counter + '" id="item_rateperunit' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" name="total' + counter + '" id="total' + counter + '"</td><td><input type="hidden" name="commodityId' + counter + '" id="commodityId' + counter + '" </td><td><input type="hidden" name="item_type' + counter + '" id="item_type' + counter + '"/></td><td><input type="hidden" name="item_subtype' + counter + '" id="item_subtype' + counter + '"/></td> </tr>');
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

                $("#addRow1").click(function () {
                    //alert();
                    var counter1 = $("#rowCounter1").val();
                    counter1++;
                    $('#order1-list tr:last').after('<tr> <td><input type="checkbox" name="chckbox1' + counter1 + '" id="chckbox1' + counter1 + '" /></td><td><select style="width: 153px;" name="expense_head' + counter1 + '" id="expense_head' + counter1 + '"><option disabled selected>select</option><option value="L">Labour Charge</option><option value="T">Transport Charge</option><option value="I">Interest Charge</option><option value="D">Driage Charge</option><option value="O">Others</option></select></td><td><select style="width: 153px;" name="expense_unit' + counter1 + '" id="expense_unit' + counter1 + '"><option disabled selected>select</option><option value="kg">kg</option><option value="ltr">litre</option><option value="pack">packet</option><option value="quin">quintal</option></select></td><td><input type="text" name="expense_rate_per_unit' + counter1 + '" id="expense_rate_per_unit' + counter1 + '"/></td> </tr>');
                    $("#rowCounter1").val(counter1);

                });
                $("#deleteRow1").click(function () {

                    var rowcount1 = $("#rowCounter1").val();
                    if (rowcount1 == 1) {

                        return false;
                    }
                    var value1 = $('input:checkbox:checked').length;
                    rowcount1 = rowcount1 - value1;
                    if (rowcount1 == 0) {

                        return false;
                    }
                    $("#rowCounter1").val(rowcount1);
                    $('input:checkbox:checked').closest('tr').remove();

                });
                
                $("#addRowAmend").click(function () {
                    var counter = $("#rowCounterAmend").val();
                    counter++;
                    $('#order-listAmmend tr:last').after('<tr> <td><input type="checkbox" name="chckbox' + counter + '" id="chckbox' + counter + '" /></td><td><input type="text" readonly name="item_desc' + counter + '" id="item_desc' + counter + '"/></td><td><input type="text" readonly name="subtype_desc' + counter + '" id="subtype_desc' + counter + '"/></td><td><input type="button" name="SearchItem' + counter + '" id="SearchItem' + counter + '" value="Search"  onclick="SearchItem(330, 180,' + counter + ')" /></td><td><input type="text" name="item_unit' + counter + '" id="item_unit' + counter + '"/></td><td><input type="text" name="qty' + counter + '" id="qty' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" name="item_rateperunit' + counter + '" id="item_rateperunit' + counter + '"onchange="Total(' + counter + ');"/></td><td><input type="text" name="total' + counter + '" id="total' + counter + '"</td><td><input type="hidden" name="commodityId' + counter + '" id="commodityId' + counter + '" </td><td><input type="hidden" name="item_type' + counter + '" id="item_type' + counter + '"/></td><td><input type="hidden" name="item_subtype' + counter + '" id="item_subtype' + counter + '"/></td> </tr>');
                    $("#rowCounterAmend").val(counter);
                    $("#rowCounterDelete").val(counter);

                });
                $("#deleteRowAmend").click(function () {

                    var rowcountAmend = $("#rowCounterAmend").val();
                    if (rowcountAmend == 1) {

                        return false;
                    }
                    var valueAmend = $('input:checkbox:checked').length;
                    rowcountAmend = rowcountAmend - valueAmend;
                    if (rowcountAmend == 0) {

                        return false;
                    }
                    $("#rowCounterAmend").val(rowcountAmend);
                    $('input:checkbox:checked').closest('tr').remove();
                    
                    var selchbox = [];        // array that will store the value of selected checkboxes

                    selchbox= getSelectedChbox(govtOrderCreatForm);
                    $("#deletedRows").val(selchbox);



                });
                
                $("#addRowAmend2").click(function () {
                    var counter = $("#rowCounterAmend2").val();
                    counter++;
                    $('#order1-listAmend2 tr:last').after('<tr> <td><input type="checkbox" name="chckbox1' + counter + '" id="chckbox1' + counter + '" /></td><td><select style="width: 153px;" name="expense_head' + counter + '" id="expense_head' + counter + '"><option disabled selected>select</option><option value="L">Labour Charge</option><option value="T">Transport Charge</option><option value="I">Interest Charge</option><option value="D">Driage Charge</option><option value="O">Others</option></select></td><td><select style="width: 153px;" name="expense_unit' + counter + '" id="expense_unit' + counter + '"><option disabled selected>select</option><option value="kg">kg</option><option value="ltr">litre</option><option value="pack">packet</option><option value="quin">quintal</option></select></td><td><input type="text" name="expense_rate_per_unit' + counter + '" id="expense_rate_per_unit' + counter + '"/></td> </tr>');
                    $("#rowCounterAmend2").val(counter);
                    $("#rowCounterDelete_Expn").val(counter);

                });
                $("#deleteRowAmend2").click(function () {

                    var rowcountAmend2 = $("#rowCounterAmend2").val();
                    if (rowcountAmend2 == 1) {

                        return false;
                    }
                    var valueAmendt = $('input:checkbox:checked').length;
                    rowcountAmend2 = rowcountAmend2 - valueAmendt;
                    if (rowcountAmend2 == 0) {

                        return false;
                    }
                    $("#rowCounterAmend2").val(rowcountAmend2);
                    $('input:checkbox:checked').closest('tr').remove();
                });

                function SearchItem(width, height, i) {
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
                    var lovKey = "GovtOrderDetails"
                    popWin = open('/PacsApplication/CommonSearchInformation_GPS_LOV.jsp?textIndex=' + i + '&screenName=' + screenName + '&lovKey=' + lovKey, 'GovtOrderDetails', attr);
                    popWin.focus();

                }

                function Total(i) {

                    var qtyDetails = document.getElementById("qty" + i).value;
                    var rateDetails = document.getElementById("item_rateperunit" + i).value;

                    document.getElementById("total" + i).value = rateDetails * qtyDetails;

                }
                function TotalAmend(i) {

                    var qtyDetails = document.getElementById("qtyAmend" + i).value;
                    var rateDetails = document.getElementById("item_rateperunitAmend" + i).value;

                    document.getElementById("totalAmend" + i).value = rateDetails * qtyDetails;

                }

                function ShowParent()
                {
                    document.forms[0].action = "GovtOrderCreation.jsp";
                    document.forms[0].submit();
                }

                function submitform(govtOrderCreatForm)
                {
                    if (checkDiv(govtOrderCreatForm))
                    {
                        document.forms[0].handle_id.value = "Create";
                        document.forms[0].action = '/PacsApplication/GovtOrderCreationServlet';
                        govtOrderCreatForm.submit();
                    }
                }
                function submitform_afterAmend(govtOrderCreatForm)
                {
                    //no null value checking
                        document.forms[0].handle_id.value = "Update";
                        document.forms[0].action = '/PacsApplication/GovtOrderCreationServlet';
                        govtOrderCreatForm.submit();
                    
                }
                function checkDiv(govtOrderCreatForm)
                {

                    if (govtOrderCreatForm.govtOrderCodeCreate.value == "")
                    {
                        alert("!! All fields must be filled !!");
                        govtOrderCreatForm.govtOrderCodeCreate.focus();
                        return false;
                    }

                    if (govtOrderCreatForm.govtOrderDesc.value == "")
                    {
                        alert("!! All fields must be filled !!");
                        govtOrderCreatForm.govtOrderDesc.focus();
                        return false;
                    }

                    if (govtOrderCreatForm.procStartDate.value == "")
                    {
                        alert("!! All fields must be filled !!");
                        govtOrderCreatForm.procStartDate.focus();
                        return false;
                    }

                    if (govtOrderCreatForm.procEndDate.value == "")
                    {
                        alert("!! All fields must be filled !!");
                        govtOrderCreatForm.procEndDate.focus();
                        return false;
                    }

                    var counter = document.forms[0].rowCounter.value;

                    for (var i = 1; i <= counter; i++) {


                        var item_type = document.getElementById("item_type" + i).value;
                        var item_subtype = document.getElementById("item_subtype" + i).value;
                        var item_unit = document.getElementById("item_unit" + i).value;
                        var qty = document.getElementById("qty" + i).value;
                        var item_rateperunit = document.getElementById("item_rateperunit" + i).value;
                        var total = document.getElementById("total" + i).value;

                        if (item_type == "" || item_subtype == "" || item_unit == "" || qty == "" || item_rateperunit == "" || total == "") {

                            alert("All Fields are mandatory");
                            return false;
                        }

                    }

                    if (govtOrderCreatForm.govtCommission.value == "")
                    {
                        alert("!! All fields must be filled !!");
                        govtOrderCreatForm.govtCommission.focus();
                        return false;
                    }

                    var counter1 = document.forms[0].rowCounter1.value;

                    for (var i = 1; i <= counter1; i++) {



                        var expense_head = document.getElementById("expense_head" + i).value;
                        var expense_unit = document.getElementById("expense_unit" + i).value;
                        var expense_rate_per_unit = document.getElementById("expense_rate_per_unit" + i).value;

                        if (expense_head == "" || expense_unit == "" || expense_rate_per_unit == "") {

                            alert("All Fields are mandatory");
                            return false;
                        }

                        return true;
                    }
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
                    popWin = open('/PacsApplication/CommonSearchInformation_GPS_LOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey, 'govtorderdetails', attr);
                    popWin.focus();

                }

                function checkop()
                {
                    if (document.getElementById("checkOption").value == "create")
                    {
                        document.getElementById('create').style.display = 'block';
                        document.getElementById('amend').style.display = 'none';
                        document.getElementById('amend2').style.display = 'none';


                    }
                    if (document.getElementById("checkOption").value == "amend")
                    {
                        document.getElementById('create').style.display = 'none';
                        document.getElementById('amend').style.display = 'block';
                        document.getElementById('active').style.display = 'none';
                        document.getElementById('amend2').style.display = 'none';


                    }


                }

                function searchOrderdetails() {

                    document.forms[0].handle_id.value = "Search";
                    document.forms[0].action = '/PacsApplication/GovtOrderCreationServlet';
                    document.forms[0].submit();

                }
                
                function getSelectedChbox(govtOrderCreatForm) {

                    var selchbox = [];        // array that will store the value of selected checkboxes

                    // gets all the input tags in frm, and their number
                    var inpfields = govtOrderCreatForm.getElementsByTagName('input');
                    var nr_inpfields = inpfields.length;

                    // traverse the inpfields elements, and adds the value of selected (checked) checkbox in selchbox
                    for(var i=0; i<nr_inpfields; i++) {
                        if(inpfields[i].type == 'checkbox' && inpfields[i].checked == true){
                            if  (inpfields[i].value!=null || inpfields[i].value!="" ){

                                selchbox.push(inpfields[i].value);

                            }

                        }

                    }

                    return selchbox;
                }
                
                function checkboxTrueAmend(i){

                    if(document.getElementById("chckboxAmend"+i).checked==true){

                        var counter = $("#chkboxCounter").val();
                        counter++;
                        $("#chkboxCounter").val(counter);
                    }

                    else{

                        var counter = $("#chkboxCounter").val();
                        counter--;
                        $("#chkboxCounter").val(counter);
                    }

                }






            </script>
        </fieldset>
    </body>
</html>

