<%-- 
    Document   : sellregister
    Created on : Jul 14, 2016, 5:03:36 PM
    Author     : Tcs Help desk122
--%>

<%@page import="DataEntryBean.GPSSellRegisterBean"%>
<%@page import="java.lang.String"%>
<%@page import="LoginDb.DbHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>


<head>
    <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
     <title>Sell Register</title>
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
    <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
    <script>

        function noBack()
        {
            window.history.forward();
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
        String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
        Object gPSSellRegisterBeanObjObj = request.getAttribute("gPSSellRegisterBeanObj");

            GPSSellRegisterBean gPSSellRegisterBeanObjApend = new GPSSellRegisterBean();
            if (gPSSellRegisterBeanObjObj != null) {
                gPSSellRegisterBeanObjApend = (GPSSellRegisterBean) request.getAttribute("gPSSellRegisterBeanObj");
            }
            
        Object alGPSSellRegisterBeanObj = request.getAttribute("alGPSSellRegisterBean");
        ArrayList<GPSSellRegisterBean> alGPSSellRegisterBean = new ArrayList<GPSSellRegisterBean>();
        if (alGPSSellRegisterBeanObj != null) {
            alGPSSellRegisterBean = (ArrayList<GPSSellRegisterBean>) request.getAttribute("alGPSSellRegisterBean");
        }
        GPSSellRegisterBean gPSSellRegisterBeanObj = new GPSSellRegisterBean();
    %>

    <jsp:include page="MenuHead_GPS.jsp" flush="true" />
    <br>
    <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

        <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
            Sale Register
        </legend>

        <form id="sellregister" name="sellregister" method="post" action="">

            <%if (!error_msg.equalsIgnoreCase("")) {%>
            <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                        <% }%>
            <br>

            <div id="amend" style="display: block;">
                <center>
                    <table>
                        <tr>
                            <td>Item Type: </td>
                             <td> <input type="text" name="itemtypeDesc" id="itemtypeDesc" value="<%=blankNull(gPSSellRegisterBeanObjApend.getItemCode())%>" /></td>
                            <td><input type="button"  value="Search" onclick="javascript:popup_Item(320, 180, document.sellregister.itemtypeDesc.value, document.sellregister.itemsubtypeDesc.value)" /></td>
                        </tr>
                        <tr>
                            <td>Item Sub Type: </td>
                            <td><input type="text" name="itemsubtypeDesc" id="itemsubtypeDesc" value="<%=blankNull(gPSSellRegisterBeanObjApend.getItemSubTypeCode())%>" /></td>
                            <td><input type="button"  value="Search" onclick="javascript:popup_Item(320, 180, document.sellregister.itemtypeDesc.value, document.sellregister.itemsubtypeDesc.value)" /></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>From Date: </td>
                            <td><input type="text" name="fromdate" id="fromdate" readonly="readonly" value="<%=blankNull(gPSSellRegisterBeanObjApend.getFromDate())%>"/><a href="#" onclick="return getCalendar(getElementById('fromdate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>To Date: </td>
                            <td><input type="text" name="todate" id="todate" readonly="readonly" value="<%=blankNull(gPSSellRegisterBeanObjApend.getToDate())%>"/><a href="#" onclick="return getCalendar(getElementById('todate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                        </tr>
                        <tr ><br><br>
                            <td><br><br><br><br></td>
                            <td style="text-align:center;"><input type="button"  value="Submit" onclick="javascript:SearchSellItem();" /></td>
                            <td style="text-align:left;"><input type="button" value="Reset" name="reset" onclick="ShowParent();" /> </td>
                        </tr>
                    </table>
                        <input type="hidden" id="itemTypeId" name="itemTypeId" />
                        <input type="hidden" id="itemSubTypeId" name="itemSubTypeId" />
                        <input type="hidden" id="commodityId" name="commodityId" />
                </center>
            </div>


            <%
                if (displayFlag.equalsIgnoreCase("Y")) { 
                  
            %>


            <div id="create" style="display:block;">
                <hr>
                <center>
                    <table id="order-list" style="margin-left: 25px;">
                        <thead class="CSSTableGenerator" >
                            <tr>

                                <td>Sell To</td>
                                <td>Delivered To</td>
                                <td>Procurement Code</td>
                                <td>Quantity</td>
                                <td>Price</td>
                                <td>Total</td>
                                <td>Expense</td>
                                <td>Sell Date</td>

                            </tr>
                        </thead>

                        <tbody>
                            <% for (int i = 0; i < alGPSSellRegisterBean.size(); i++) {
                                    gPSSellRegisterBeanObj = alGPSSellRegisterBean.get(i);
                            %>
                            <tr>

                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getSellTo()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getDeliveredTo()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getProcurementCode()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getQuantity()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getPrice()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getTotal()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getExpense()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSSellRegisterBeanObj.getSellDate()%>" readonly="true"></td>

                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </center>
                <br/><br/>

            </div>


            <%  }%>




        </form>

        <script>


            function SearchSellItem()
            {

                //var name = document.getElementById("custName").value;
                //var memberId = document.getElementById("custId").value;
                //if (name == "" || memberId == "") {

                    //alert("All Searc Fields are mandatory");
                   // return false;
                //}
                //else {

                    document.forms[0].action = '/PacsApplication/GPSSellRegisterServlet';
                    document.forms[0].submit();
                //}

            }
            
            function ShowParent()
            {
                document.forms[0].action = "/PacsApplication/GPS_JSP/sellregister.jsp";
                document.forms[0].submit();
            }

            function popup_Item(width, height, itemType, itemSubType) {

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
                var screenName = "sellregister.jsp";
                var lovKey = "itemdetails"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_GPS_LOV.jsp?itemType=' + itemType + '&itemSubType=' + itemSubType + '&screenName=' + screenName + '&lovKey=' + lovKey, 'itemdetails', attr);
                popWin.focus();

            }





        </script>
    </fieldset>
</body>


