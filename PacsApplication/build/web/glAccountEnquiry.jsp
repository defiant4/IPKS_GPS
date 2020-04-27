<%-- 
    Document   : glAccountEnquiry
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DataEntryBean.GlAccountEnquiryBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />

        <title>GL Account Enquiry</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }
            function checkAmount(enquiryForm)
            {
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains int and float
                if (!re.test(enquiryForm.fromAmount.value))
                {
                    alert("!! Amount could only contain numbers !!");
                    enquiryForm.fromAmount.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains int and float
                if (!re.test(enquiryForm.toAmount.value))
                {
                    alert("!! Amount could only contain numbers !!");
                    enquiryForm.toAmount.focus();
                    return false;
                }
                return true;
            }
            function accountsubmitform(enquiryForm)
            {
                document.forms[0].action = '/PacsApplication/EnquiryServlet';
                document.forms[0].submit();

            }
            function ShowParent()
            {
                document.forms[0].action = "glAccountEnquiry.jsp";
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
            Object alGlAccountEnquiryBeanObj = request.getAttribute("alGlAccountEnquiryBean");
            ArrayList<GlAccountEnquiryBean> alGlAccountEnquiryBean = new ArrayList<GlAccountEnquiryBean>();
            if (alGlAccountEnquiryBeanObj != null) {
                alGlAccountEnquiryBean = (ArrayList<GlAccountEnquiryBean>) request.getAttribute("alGlAccountEnquiryBean");
            }
        %>
        <%
            Object oGlAccountEnquiryBeanSearchObj = request.getAttribute("oGlAccountEnquiryBeanSearchObj");
            GlAccountEnquiryBean oGlAccountEnquiryBean = new GlAccountEnquiryBean();
            GlAccountEnquiryBean oGlAccountEnquiryBeanSearch = new GlAccountEnquiryBean();
            if (oGlAccountEnquiryBeanSearchObj != null) {
                oGlAccountEnquiryBean = (GlAccountEnquiryBean) request.getAttribute("oGlAccountEnquiryBeanSearchObj");

                session.setAttribute("oGlAccountEnquiryBeanSearchObj", oGlAccountEnquiryBeanSearchObj);

            }
        %>

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">GL ACCOUNT ENQUIRY DETAILS</legend>
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
                                <td style="text-align: right">GL Account No.:</td>
                                <td><input type="text" name="accountNo" id="accountNo" value="<%=blankNull(oGlAccountEnquiryBean.getAccountNo())%>"/></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td style="text-align: right">Product Name:</td>
                                <td><select id="productName" name="productName" >    
                                        <%if (oGlAccountEnquiryBean.getProductName() == null) { %>
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
                                        <option value="<%=blankNull(oGlAccountEnquiryBean.getProductId())%>" selected style="display:none;"><%=blankNull(oGlAccountEnquiryBean.getProductName())%></option>     
                                        <%
                                            Connection connection = null;
                                            ResultSet rs = null;
                                            Statement statement = null;
                                            connection = DbHandler.getDBConnection();
                                            try {
                                                statement = connection.createStatement();
                                                rs = statement.executeQuery("select id, gl_name from gl_product where id!='" + oGlAccountEnquiryBean.getProductId() + "'");
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
                                <td style="text-align: right">From Date:</td>
                                <td><input value="<%=blankNull(oGlAccountEnquiryBean.getFromDate())%>" type="text" id="fromDate" style="text-align:center;" name="fromDate" resize="yes" readonly="true"><a href="#" onclick="return getCalendar(document.forms[0].fromDate);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>                            
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td style="text-align: right">To Date:</td>
                                <td><input value="<%=blankNull(oGlAccountEnquiryBean.getToDate())%>" type="text" id="toDate" style="text-align:center;" name="toDate" resize="yes" readonly="true"><a href="#" onclick="return getCalendar(document.forms[0].toDate);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>
                            </tr>
                            <tr>
                                <td><br></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">From Amount:</td>
                                <td><input value="<%=blankNull(oGlAccountEnquiryBean.getFromAmount())%>" type="text" style="text-align:center;" name="fromAmount" id="fromAmount"></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td style="text-align: right">To Amount:</td>
                                <td><input value="<%=blankNull(oGlAccountEnquiryBean.getToAmount())%>" type="text" style="text-align:center;" name="toAmount" id="toAmount" ></td>
                            </tr>
                        </table>
                        <br><br>

                        <input type="button" value="Submit" onclick="javascript:accountsubmitform(enquiryForm)">
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                    </center>
                </div><br><br>
                <input type="hidden" value="glAccountEnquiry" name="screenName" />

                <input name="handle_id" id="handle_id" type="hidden" value="" />
                <input name="reportname" id="reportname" type="hidden" value="GL_ACCOUNT_ENQUIRY_REPORT" />
            </form>

            <%if (displayFlag.equalsIgnoreCase("Y")) {%>
            <center>
                <div id="displayDiv" >

                    <table border="2" width="auto" cellspacing="1" cellpadding="1" style="text-align: center ;overflow-y: scroll">
                        <thead class="CSSTableGenerator">
                            <tr>
                                <td>BGL Account Number</td>
                                <td>Ledger Name</td>
                                <td>A/C Opening Date</td>
                                <td>Cumulative Balance</td>
                                <td>Status</td>
                                <td>Global GL Code</td>
                                <td>Global GL Name</td>
                            </tr>
                        </thead>
                        <tbody style="background-color: white; font-size: 15px">
                            <%
                                oGlAccountEnquiryBean = null;

                                for (int i = 0; i < alGlAccountEnquiryBean.size(); i++) {
                                    oGlAccountEnquiryBean = alGlAccountEnquiryBean.get(i);
                            %>

                            <tr>
                                <td><%=blankNull(oGlAccountEnquiryBean.getAccountNo())%></td>
                                <td><%=blankNull(oGlAccountEnquiryBean.getLedgerName())%></td>
                                <td><%=blankNull(oGlAccountEnquiryBean.getAccountOpenDate())%></td>
                                <td><%=blankNull(oGlAccountEnquiryBean.getCumulativeBalance())%></td>
                                <td><%=blankNull(oGlAccountEnquiryBean.getStatus())%></td>
                                <td><%=blankNull(oGlAccountEnquiryBean.getCglCode())%></td>
                                <td><%=blankNull(oGlAccountEnquiryBean.getCglName())%></td>
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





