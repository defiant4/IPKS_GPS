<%-- 
    Document   : ProcurementRegister
    Created on : Jul 15, 2016, 2:15:03 PM
    Author     : Tcs Helpdesk10
--%>

<%@page import="DataEntryBean.ProcurementRegisterBean"%>
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
    <title>Procurement Register</title>
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
        Object gPSProcurementRegisterBeanObjObj = request.getAttribute("ProcurementRegisterBeanObj");

        ProcurementRegisterBean gPSProcurementRegisterBeanObjApend = new ProcurementRegisterBean();
        if (gPSProcurementRegisterBeanObjObj != null) {
            gPSProcurementRegisterBeanObjApend = (ProcurementRegisterBean) request.getAttribute("ProcurementRegisterBeanObj");
        }

        Object alProcurementRegisterBeanObj = request.getAttribute("alProcurementRegisterBean");
        ArrayList<ProcurementRegisterBean> alProcurementRegisterBean = new ArrayList<ProcurementRegisterBean>();
        if (alProcurementRegisterBeanObj != null) {
            alProcurementRegisterBean = (ArrayList<ProcurementRegisterBean>) request.getAttribute("alProcurementRegisterBean");
        }
        ProcurementRegisterBean gPSProcurementRegisterBeanObj = new ProcurementRegisterBean();
    %>

    <jsp:include page="MenuHead_GPS.jsp" flush="true" />
    <br>
    <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

        <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
            Procurement Register Details
        </legend>

        <form id="procurementregister" name="procurementregister" method="post" action="">

            <%if (!error_msg.equalsIgnoreCase("")) {%>
            <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                        <% }%>
            <br>

            <div id="amend" style="display: block;">
                <center>
                    <table>
                        <tr>
                            <td>Item Type: </td>
                            <td> <input type="text" name="itemtype" id="itemtype" value="<%=blankNull(gPSProcurementRegisterBeanObjApend.getItemCode())%>" /></td>
                        <td><input type="button"  value="Search" onclick="javascript:popup_member(320, 180, document.procurementregister.itemtype.value, document.procurementregister.itemsubtype.value)" /></td>
                        </tr>
                        <tr>
                            <td>Item Sub Type: </td>
                            <td><input type="text" name="itemsubtype" id="itemsubtype" value="<%=blankNull(gPSProcurementRegisterBeanObjApend.getItemSubTypeCode())%>" /></td>
                            <td><input type="button"  value="Search" onclick="javascript:popup_member(320, 180, document.procurementregister.itemtype.value, document.procurementregister.itemsubtype.value)" /></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>From Date: </td>
                            <td><input type="text" name="fromdate" id="fromdate" readonly="readonly" value="<%=blankNull(gPSProcurementRegisterBeanObjApend.getFromDate())%>"/><a href="#" onclick="return getCalendar(getElementById('fromdate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>To Date: </td>
                            <td><input type="text" name="todate" id="todate" readonly="readonly" value="<%=blankNull(gPSProcurementRegisterBeanObjApend.getToDate())%>"/><a href="#" onclick="return getCalendar(getElementById('todate'));"><img src="${pageContext.request.contextPath}/img/calendar.gif" name="imgr" border="0" width="15" height="15" /></a></td>
                        </tr>
                        <tr ><br><br>
                        <td><br><br><br><br></td>
                        <td style="text-align:center;"><input type="button"  value="Search" onclick="javascript:SearchProcureItem();" /></td>
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

                                <td>Govt.Procurement Code</td>
                                <td>Procurement ID</td>
                                <td>Procurement Date</td>
                                <td>Item Type:Desc</td>
                                <td>Item Sub Type:Desc</td>
                                <td>Unit</td>
                                <td>Rate Per Unit</td>
                                <td>Base Quantity</td>
                                <td>Quantity Available</td>


                            </tr>
                        </thead>

                        <tbody>
                            <% for (int i = 0; i < alProcurementRegisterBean.size(); i++) {
                                    gPSProcurementRegisterBeanObj = alProcurementRegisterBean.get(i);
                            %>
                            <tr>

                                <td style="text-align:center;"><input type="text" value="<%=gPSProcurementRegisterBeanObj.getProcurementCode()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSProcurementRegisterBeanObj.getProcurementId()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSProcurementRegisterBeanObj.getProcurementDate()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSProcurementRegisterBeanObj.getItemCodeAmmend()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=gPSProcurementRegisterBeanObj.getItemSubTypeCodeAmmend()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" size="12" value="<%=gPSProcurementRegisterBeanObj.getUnit()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" size="12" value="<%=gPSProcurementRegisterBeanObj.getRatePerUnit()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" size="12" value="<%=gPSProcurementRegisterBeanObj.getBaseQty()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text"  value="<%=gPSProcurementRegisterBeanObj.getQtyAvailable()%>" readonly="true"></td>
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


            function SearchProcureItem()
            {

                //var name = document.getElementById("custName").value;
                //var memberId = document.getElementById("custId").value;
                //if (name == "" || memberId == "") {

                //alert("All Searc Fields are mandatory");
                // return false;
                //}
                //else {

                document.forms[0].action = '/PacsApplication/ProcurementRegisterServlet';
                document.forms[0].submit();
                //}

            }

            function ShowParent()
            {
                document.forms[0].action = "/PacsApplication/GPS_JSP/ProcurementRegister.jsp";
                document.forms[0].submit();
            }

            function popup_member(width, height, itemType, itemSubType) {

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
                var screenName = "ProcurementRegister.jsp";
                var lovKey = "procuredetails"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_GPS_LOV.jsp?itemType=' + itemType + '&itemSubType=' + itemSubType + '&screenName=' + screenName + '&lovKey=' + lovKey, 'procuredetails', attr);
                popWin.focus();

            }





        </script>
    </fieldset>
</body>


