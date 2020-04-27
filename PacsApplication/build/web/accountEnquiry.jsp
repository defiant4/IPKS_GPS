<%-- 
    Document   : accountEnquiry
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DataEntryBean.EnquiryBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
        <title>Account Enquiry</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function accountsubmitform(enquiryForm)
            {
                document.forms[0].action = '/PacsApplication/EnquiryServlet';
                document.forms[0].submit();
            }
            function ShowParent()
            {
                document.forms[0].action = "accountEnquiry.jsp";
                document.forms[0].submit();
            }


            function excelDownload() {

                document.forms[0].action = '/PacsApplication/ExcelReportServlet';
                document.forms[0].submit();
            }
        </script>

        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>

        <jsp:include page="MenuHead.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>

        <%
            Object alEnquiryBeanObj = request.getAttribute("alEnquiryBean");
            ArrayList<EnquiryBean> alEnquiryBean = new ArrayList<EnquiryBean>();
            if (alEnquiryBeanObj != null) {
                alEnquiryBean = (ArrayList<EnquiryBean>) request.getAttribute("alEnquiryBean");
            }
        %>
        <%
            Object oEnquiryBeanSearchObj = request.getAttribute("oEnquiryBeanSearchObj");
            EnquiryBean oEnquiryBean = new EnquiryBean();
            EnquiryBean oEnquiryBeanSearch = new EnquiryBean();
            if (oEnquiryBeanSearchObj != null) {
                oEnquiryBean = (EnquiryBean) request.getAttribute("oEnquiryBeanSearchObj");
                session.setAttribute("oEnquiryBeanSearchObj",oEnquiryBeanSearchObj);
            }
        %>
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">ACCOUNT ENQUIRY DETAILS</legend>
        <form id="enquiryForm" name="enquiryForm" method="post" action="EnquiryServlet"> 
           
            
            <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                <% }%>
                <br>
            <br>


            <div id="filterDiv" >
                <center>
                    <table>
                        <tr>
                            <td style="text-align: right">Account No.: </td>
                            <td><input type="text" name="accountNo" id="accountNo" value="<%=blankNull(oEnquiryBean.getAccountNo())%>"/></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td style="text-align: right">Product Name: </td>
                            <td><select id="productName" name="productName" >    
                                    <%if (oEnquiryBean.getProductName() == null) { %>
                                    <option value="" disabled selected style="display:none;">--Select--</option>
                                    <%
                                        Connection connection = null;
                                        ResultSet rs = null;
                                        Statement statement = null;
                                        connection = DbHandler.getDBConnection();
                                        try {
                                            statement = connection.createStatement();
                                            rs = statement.executeQuery("select id, prod_name from dep_product");
                                            while (rs.next()) {%>
                                    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                    <%}
                                            statement.close();
                                            connection.close();
                                        } catch (Exception e) {
                                        }
                                    } else {%>
                                    <option value="<%=blankNull(oEnquiryBean.getProductId())%>" selected style="display:none;"><%=blankNull(oEnquiryBean.getProductName())%></option>     
                                    <%
                                        Connection connection = null;
                                        ResultSet rs = null;
                                        Statement statement = null;
                                        connection = DbHandler.getDBConnection();
                                        try {
                                            statement = connection.createStatement();
                                            rs = statement.executeQuery("select id, prod_name from dep_product where id!='" + oEnquiryBean.getProductId() + "'");
                                            while (rs.next()) {%>
                                    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                    <%}
                                                statement.close();
                                                connection.close();
                                            } catch (Exception e) {
                                            }
                                        }%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><br></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">From Date: </td>
                            <td><input value="<%=blankNull(oEnquiryBean.getFromDate())%>" type="text" id="fromDate" style="text-align:center;" name="fromDate" readonly /><a href="#" onclick="return getCalendar(document.forms[0].fromDate);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>                            
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td style="text-align: right">To Date: </td>
                            <td><input value="<%=blankNull(oEnquiryBean.getToDate())%>" type="text" id="toDate" style="text-align:center;" name="toDate" readonly /><a href="#" onclick="return getCalendar(document.forms[0].toDate);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>
                        </tr>
                        <tr>
                            <td><br></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">From Amount: </td>
                            <td><input value="<%=blankNull(oEnquiryBean.getFromAmount())%>" type="text" style="text-align:center;" name="fromAmount" /></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td style="text-align: right">To Amount: </td>
                            <td><input value="<%=blankNull(oEnquiryBean.getToAmount())%>" type="text" style="text-align:center;" name="toAmount"/></td>
                        </tr>
                        <tr>
                            <td><br></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Linked SB Account No.: </td>
                            <td><input value="<%=blankNull(oEnquiryBean.getLinkedSbAccount())%>" type="text" style="text-align:center;" name="linkedSbAccount" /></td>
                        </tr>
                    </table>
                    <br><br>

                    <input type="button" value="Submit" onclick="javascript:accountsubmitform(enquiryForm)">
                    <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                </center>
            </div><br><br>
            <input type="hidden" value="accountEnquiry" name="screenName" />

            <input name="handle_id" id="handle_id" type="hidden" value="" />
            <input name="reportname" id="reportname" type="hidden" value="ACCOUNT_ENQUIRY_REPORT" />

        </form>

        <%if (displayFlag.equalsIgnoreCase("Y")) {%>
    <center>
        <div id="displayDiv" >

            <table border="2" width="auto" cellspacing="1" cellpadding="1" style="text-align: center ;overflow-y: scroll; font-size: 15px">
                <thead class="CSSTableGenerator">
                    <tr>
                        <td>Account Number</td>
                        <td>Link CBS Account Number</td>
                        <td>Customer Number</td>
                        <td>Product Name</td>
                        <td >Customer Name</td>
                        <td>Opening Date</td>
                        <td>Sanction Amount</td>
                        <td>Available Balance</td>
                        <td>Limit Expiry Date</td>
                        <td>Principal Paid</td>
                        <td>Principal Outstanding</td>
                        <td>Interest Paid</td>
                        <td>Interest Outstanding</td>
                        <td>Penal Interest Paid</td>
                        <td>Penal Interest Outstanding</td>
                    </tr>
                </thead>
                <tbody style="background-color: white; font-size: 15px">
                    <%
                        oEnquiryBean = null;

                        for (int i = 0; i < alEnquiryBean.size(); i++) {
                            oEnquiryBean = alEnquiryBean.get(i);
                    %>

                    <tr>
                        <td><%=blankNull(oEnquiryBean.getAccountNo())%></td>
                        <td><%=blankNull(oEnquiryBean.getLinkAccNo())%></td>
                        <td><%=blankNull(oEnquiryBean.getCustomerNo())%></td>
                        <td><%=blankNull(oEnquiryBean.getProductNameDisplay())%></td>
                        <td><%=blankNull(oEnquiryBean.getCustomerName())%></td>
                        <td><%=blankNull(oEnquiryBean.getAccountOpenDate())%></td>
                        <td><%=blankNull(oEnquiryBean.getSanctionAmount())%></td>
                        <td><%=blankNull(oEnquiryBean.getAvailBalance())%></td>
                        <td><%=blankNull(oEnquiryBean.getLimitExpiryDate())%></td>
                        <td><%=blankNull(oEnquiryBean.getPrinPaid())%></td>
                        <td><%=blankNull(oEnquiryBean.getPrinOutstanding())%></td>
                        <td><%=blankNull(oEnquiryBean.getInttPaid())%></td>
                        <td><%=blankNull(oEnquiryBean.getInttOutstanding())%></td>
                        <td><%=blankNull(oEnquiryBean.getPenalIntt())%></td>
                        <td><%=blankNull(oEnquiryBean.getPenalInttOutstanding())%></td>
                    </tr>
                    <%}%>
                </tbody>

            </table><br><br>
            <input type="button" value="Export Result" onclick="javascript:excelDownload()">
        </div>
    </center>
    <%}%>
        </fieldset>
</body>
</html>





