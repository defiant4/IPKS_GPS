<%-- 
    Document   : Enquiry
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="DataEntryBean.GLTransactionEnquiryBean"%>
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
                document.forms[0].action = "glTransactionEnquiry.jsp";
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
            Object alGlTransactionEnquiryBeanObj = request.getAttribute("alGlTransactionEnquiryBean");
            ArrayList<GLTransactionEnquiryBean> alTransactionEnquiryBean = new ArrayList<GLTransactionEnquiryBean>();
            if (alGlTransactionEnquiryBeanObj != null) {
                alTransactionEnquiryBean = (ArrayList<GLTransactionEnquiryBean>) request.getAttribute("alGlTransactionEnquiryBean");

            }
        %>
        <%
            Object oGlTransactionEnquiryBeanobj = request.getAttribute("oGlTransactionEnquiryBeanSearchObj");
            GLTransactionEnquiryBean oGLTransactionEnquiryBean = new GLTransactionEnquiryBean();
            if (oGlTransactionEnquiryBeanobj != null) {
                oGLTransactionEnquiryBean = (GLTransactionEnquiryBean) request.getAttribute("oGlTransactionEnquiryBeanSearchObj");

                session.setAttribute("oGlTransactionEnquiryBeanobj", oGlTransactionEnquiryBeanobj);

            }
        %>

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">GL TRANSACTION ENQUIRY DETAILS</legend>
            <form name="enquiryForm" method="post" action="EnquiryServlet"> 

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>
                <br>


                <div id="filterDiv">
                    <center>
                        <table>
                            <tr>
                                <td align="right">GL Account Number:</td>
                                <td align="left"><input value="<%=blankNull(oGLTransactionEnquiryBean.getAccountNo())%>" type="text" name="accountNo" id="accountNo"/></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align="right">Product Name:</td>
                                <td align="left"><select id="productName" name="productName" >       
                                        <%if (oGLTransactionEnquiryBean.getProductName() == null) { %>
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <%
                                            Connection connection = null;
                                            ResultSet rs = null;
                                            Statement statement = null;
                                            connection = DbHandler.getDBConnection();
                                            try {
                                                statement = connection.createStatement();
                                                rs = statement.executeQuery("select id, gl_name from gl_product");
                                                while (rs.next()) {%>
                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                        <%}
                                                statement.close();
                                                connection.close();
                                            } catch (Exception e) {
                                            }
                                        } else {%>
                                        <option value="<%=blankNull(oGLTransactionEnquiryBean.getProductId())%>" selected style="display:none;"><%=blankNull(oGLTransactionEnquiryBean.getProductName())%></option>     
                                        <%
                                            Connection connection = null;
                                            ResultSet rs = null;
                                            Statement statement = null;
                                            connection = DbHandler.getDBConnection();
                                            try {
                                                statement = connection.createStatement();
                                                rs = statement.executeQuery("select id, gl_name from gl_product where id!='" + oGLTransactionEnquiryBean.getProductId() + "'");
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
                                <td align="left"><input value="<%=blankNull(oGLTransactionEnquiryBean.getFromDate())%>" type="text" style="text-align:center;" name="fromDate"  resize="yes" readonly="true"/><a href="#" onclick="return getCalendar(document.forms[0].fromDate);"/><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align="right">To Date:</td>
                                <td align="left"><input value="<%=blankNull(oGLTransactionEnquiryBean.getToDate())%>" type="text" style="text-align:center;" name="toDate"  resize="yes" readonly="true"/><a href="#" onclick="return getCalendar(document.forms[0].toDate);"/><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>
                            </tr>
                            <tr><td><br></td></tr>
                            <tr>
                                <td align="right">From Amount:</td>
                                <td align="left"><input value="<%=blankNull(oGLTransactionEnquiryBean.getFromAmount())%>" type="text"  name="fromAmount"  /></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align="right">To Amount:</td>
                                <td align="left"><input value="<%=blankNull(oGLTransactionEnquiryBean.getToAmount())%>" type="text" name="toAmount" /></td>
                            </tr>
                        </table>
                        <br>
                        <br>
                        <input type="button" value="Submit" onclick="javascript:accountsubmitform(enquiryForm)">
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                    </center>
                </div><br><br>
                <input type="hidden" value="glTransactionEnquiry" name="screenName" />

                <input name="handle_id" id="handle_id" type="hidden" value="" />
                <input name="reportname" id="reportname" type="hidden" value="GL_TRANSACTION_ENQUIRY_REPORT" />
            </form>

            <%if (displayFlag.equalsIgnoreCase("Y")) {%>
            <center>
                <div id="displayDiv" >

                    <table border="2" width="auto" cellspacing="1" cellpadding="1" style="text-align: center ;overflow-y: scroll">
                        <thead class="CSSTableGenerator">
                            <tr>
                                <td>Account No.</td>
                                <td>Reference No.</td>
                                <td>Transaction Date</td>
                                <td>Journal No.</td>
                                <td>Transaction Type</td>
                                <td>Transaction Amount</td>

                            </tr>
                        </thead>
                        <tbody style="background-color: white; font-size: 15px">
                            <%
                                for (int i = 0; i < alTransactionEnquiryBean.size(); i++) {
                                    oGLTransactionEnquiryBean = alTransactionEnquiryBean.get(i);
                            %>

                            <tr>
                                <td><%=blankNull(oGLTransactionEnquiryBean.getAccountNo())%></td>
                                <td><%=blankNull(oGLTransactionEnquiryBean.getCbs_Ref_No())%></td>
                                <td><%=blankNull(oGLTransactionEnquiryBean.getTransactionDate())%></td>
                                <td><%=blankNull(oGLTransactionEnquiryBean.getJournalNumber())%></td>
                                <td><%=blankNull(oGLTransactionEnquiryBean.getTransactionType())%></td>
                                <td><%=blankNull(oGLTransactionEnquiryBean.getTransactionAmount())%></td>
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





