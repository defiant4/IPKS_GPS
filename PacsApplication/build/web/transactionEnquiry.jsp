<%-- 
    Document   : Enquiry
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="DataEntryBean.TransactionEnquiryBean"%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
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
                document.forms[0].action = "transactionEnquiry.jsp";
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
            Object alTransactionEnquiryBeanObj = request.getAttribute("alTransactionEnquiryBean");
            ArrayList<TransactionEnquiryBean> alTransactionEnquiryBean = new ArrayList<TransactionEnquiryBean>();
            if (alTransactionEnquiryBeanObj != null) {
                alTransactionEnquiryBean = (ArrayList<TransactionEnquiryBean>) request.getAttribute("alTransactionEnquiryBean");

            }
        %>
        <%
            Object oTransactionEnquiryBeanobj = request.getAttribute("oTransactionEnquiryBeanSearchObj");
            TransactionEnquiryBean oTransactionEnquiryBean = new TransactionEnquiryBean();
            if (oTransactionEnquiryBeanobj != null) {
                oTransactionEnquiryBean = (TransactionEnquiryBean) request.getAttribute("oTransactionEnquiryBeanSearchObj");
                session.setAttribute("oTransactionEnquiryBeanSearchObj", oTransactionEnquiryBeanobj);

            }
        %>
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">TRANSACTION ENQUIRY DETAILS</legend>
            <form name="enquiryForm" method="post" action="EnquiryServlet"> 

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>


                <div id="filterDiv">
                    <center>
                        <table>
                            <tr>
                                <td align="right">Account Number:</td>
                                <td align="left"><input value="<%=blankNull(oTransactionEnquiryBean.getAccountNo())%>" type="text" name="accountNo" id="accountNo"/></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align="right">Product Name:</td>
                                <td align="left"><select id="productName" name="productName" >       
                                        <%if (oTransactionEnquiryBean.getProductName() == null) { %>
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
                                        <option value="<%=blankNull(oTransactionEnquiryBean.getProductId())%>" selected style="display:none;"><%=blankNull(oTransactionEnquiryBean.getProductName())%></option>     
                                        <%
                                            Connection connection = null;
                                            ResultSet rs = null;
                                            Statement statement = null;
                                            connection = DbHandler.getDBConnection();
                                            try {
                                                statement = connection.createStatement();
                                                rs = statement.executeQuery("select id, prod_name from dep_product where id!='" + oTransactionEnquiryBean.getProductId() + "'");
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
                            <tr><td><br></td></tr>
                            <tr>
                                <td align="right">From Date:</td>
                                <td align="left"><input value="<%=blankNull(oTransactionEnquiryBean.getFromDate())%>" type="text" style="text-align:center;" name="fromDate"  resize="yes" readonly="true"/><a href="#" onclick="return getCalendar(document.forms[0].fromDate);"/><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align="right">To Date:</td>
                                <td align="left"><input value="<%=blankNull(oTransactionEnquiryBean.getToDate())%>" type="text" style="text-align:center;" name="toDate"  resize="yes" readonly="true"/><a href="#" onclick="return getCalendar(document.forms[0].toDate);"/><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>
                            </tr>
                            <tr><td><br></td></tr>
                            <tr>
                                <td align="right">From Amount:</td>
                                <td align="left"><input value="<%=blankNull(oTransactionEnquiryBean.getFromAmount())%>" type="text"  name="fromAmount"  /></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align="right">To Amount:</td>
                                <td align="left"><input value="<%=blankNull(oTransactionEnquiryBean.getToAmount())%>" type="text" name="toAmount" /></td>
                            </tr>
                            <tr>
                            <td><br></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">Linked SB Account No.: </td>
                            <td><input value="<%=blankNull(oTransactionEnquiryBean.getLinkedSbAccount())%>" type="text" style="text-align:center;" name="linkedSbAccount" /></td>
                        </tr>
                        </table>
                        <br>
                        <br>
                        <input type="button" value="Submit" onclick="javascript:accountsubmitform(enquiryForm)">
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                    </center>
                </div><br><br>
                <input type="hidden" value="transactionEnquiry" name="screenName" />

                <input name="handle_id" id="handle_id" type="hidden" value="" />
                <input name="reportname" id="reportname" type="hidden" value="TRANSACTION_ENQUIRY_REPORT" />
            </form>

            <%if (displayFlag.equalsIgnoreCase("Y")) {%>
            <center>
                <div id="displayDiv" >

                    <table border="2" width="auto" cellspacing="1" cellpadding="1" style="text-align: center ;overflow-y: scroll">
                        <thead class="CSSTableGenerator">
                            <tr>
                                <td>Account No.</td>
                                <td>Link CBS Account Number</td>
                                <td>Reference No.</td>
                                <td>Product Name</td>
                                <td>Limit Expiry Date</td>
                                <td>Transaction Date</td>   
                                <td>Transaction Type</td>
                                <td>Transaction Amount</td>
                                
                                <td>Available Balance</td>
                            </tr>
                        </thead>
                        <tbody style="background-color: white; font-size: 15px">
                            <%
                                for (int i = 0; i < alTransactionEnquiryBean.size(); i++) {
                                    oTransactionEnquiryBean = alTransactionEnquiryBean.get(i);
                            %>

                            <tr>
                                <td><%=blankNull(oTransactionEnquiryBean.getAccountNo())%></td>
                                <td><%=blankNull(oTransactionEnquiryBean.getLinkAccNo())%></td>
                                <td><%=blankNull(oTransactionEnquiryBean.getCbs_Ref_No())%></td>
                                <td><%=blankNull(oTransactionEnquiryBean.getProductNameDisplay())%></td>
                                <td><%=blankNull(oTransactionEnquiryBean.getLimitExpiryDate())%></td>
                                <td><%=blankNull(oTransactionEnquiryBean.getTransactionDate())%></td>
                                <td><%=blankNull(oTransactionEnquiryBean.getTransactionType())%></td>
                                <td><%=blankNull(oTransactionEnquiryBean.getTransactionAmount())%></td>
                                
                                <td><%=blankNull(oTransactionEnquiryBean.getAvailableBalance())%></td>
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





