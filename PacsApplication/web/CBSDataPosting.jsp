<%-- 
    Document   : CBS Data Posting
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DataEntryBean.CBSDataPostingBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />

        <title>CBS Data Posting</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function cbs_upload(cbsDataPostingForm)
            {
                document.getElementById("handle_id").value = "cbsUpload";
                document.forms[0].action = '/PacsApplication/cbsExtractPostingServlet';
                document.forms[0].submit();
            }
            function cbs_post(cbsDataPostingForm)
            {
                document.getElementById("handle_id").value = "cbsPost";
                document.forms[0].action = '/PacsApplication/cbsExtractPostingServlet';
                document.forms[0].submit();
            }
            function download_report(cbsDataPostingForm)
            {
                document.getElementById("handle_id").value = "downloadReport";
                document.forms[0].action = '/PacsApplication/ExcelReportServlet';

                document.forms[0].submit();
            }
            function view_status(cbsDataPostingForm)
            {
                document.getElementById("handle_id").value = "viewStatus";
                document.forms[0].action = '/PacsApplication/cbsExtractPostingServlet';
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
            Object alCBSDataPostingBeanObj = request.getAttribute("alCBSDataPostingBean");
            ArrayList<CBSDataPostingBean> alCBSDataPostingBean = new ArrayList<CBSDataPostingBean>();
            if (alCBSDataPostingBeanObj != null) {
                alCBSDataPostingBean = (ArrayList<CBSDataPostingBean>) request.getAttribute("alCBSDataPostingBean");
            }
        %>
        <%
            Object oCBSDataPostingBeanSearchObj = request.getAttribute("oCBSDataPostingBeanSearchObj");
            CBSDataPostingBean oCBSDataPostingBean = new CBSDataPostingBean();
            CBSDataPostingBean oCBSDataPostingBeanSearch = new CBSDataPostingBean();
            if (oCBSDataPostingBeanSearchObj != null) {
                oCBSDataPostingBean = (CBSDataPostingBean) request.getAttribute("oCBSDataPostingBeanSearchObj");
            }
        %>
        
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">CBS DATA POSTING</legend>
        <form id="cbsDataPostingForm" name="cbsDataPostingForm" method="post" action="cbsExtractPostingServlet">
           
            <%if (!error_msg.equalsIgnoreCase("")) {%>
             <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div>       
            <% }%>
            <br>

            <center>
                <br><br>
                <table style="column-gap: 5px; ">
                    <tr>
                        <td><input name="uploadCBSData" id="uploadCBSData" type="button" value="Upload CBS Data" onclick="cbs_upload();" /></td>
                        <td>&nbsp;</td>
                        <td><input name="postCBSTransaction" id="postCBSTransaction" type="button" value="Post CBS Transaction" onclick="cbs_post();" /></td>
                        <td>&nbsp;</td>
                        <td><input name="viewPostingStatus" id="viewPostingStatus" type="button" value="View Posting Status" onclick="view_status();" /></td>
                        <td>&nbsp;</td>
                        <td><input name="downloadReport" id="downloadReport" type="button" value="Download Report" onclick="download_report();" /></td>


                    </tr>
                </table>
            </center>
            <input name="handle_id" id="handle_id" type="hidden" value="" />
            <input name="screen_name" id="screen_name" type="hidden" value="CBSDataPosting.jsp" />
            <input name="reportname" id="reportname" type="hidden" value="BULK_TRANSACTION_REPORT" />
            <input name="inputparam1" id="inputparam1" type="hidden" value="" />
            <input name="inputparam1" id="inputparam1" type="hidden" value="" />

        </form>

        <%if (displayFlag.equalsIgnoreCase("Y")) {%>
        <br><br>
    <center>
        <div id="displayDiv" >

            <table border="2" width="auto" cellspacing="1" cellpadding="1" style="text-align: center ;overflow-y: scroll; font-size: 15px">
                <thead class="CSSTableGenerator">
                    <tr>
                        <td>Serial Number</td>
                        <td>File Name</td>
                        <td>DCCB Name</td>
                        <td >Upload Status</td>

                    </tr>
                </thead>
                <tbody style="background-color: white; font-size: 15px">
                    <%
                        oCBSDataPostingBean = null;

                        for (int i = 0; i < alCBSDataPostingBean.size(); i++) {
                            oCBSDataPostingBean = alCBSDataPostingBean.get(i);
                    %>

                    <tr>
                        <td><%=(i + 1)%></td>
                        <td><%=blankNull(oCBSDataPostingBean.getFileName())%></td>
                        <td><%=blankNull(oCBSDataPostingBean.getDccbName())%></td>
                        <td <% if ((oCBSDataPostingBean.getUploadStatus().equalsIgnoreCase("PENDING"))) { %>style="color: red"<%}%>><%=blankNull(oCBSDataPostingBean.getUploadStatus())%></td>


                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </center>
    <%}%>
        </fieldset>
</body>
</html>





