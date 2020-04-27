<%-- 
    Document   : EODinttComputation
    Created on : Mar 18, 2016, 2:00:29 PM
    Author     : Tcs Helpdesk10
--%>

<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />

        <title>Interest Computation</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }


            function intt_post()
            {
                document.getElementById("handle_id").value = "InterestPosting";
                document.forms[0].action = '/PacsApplication/interestComputationServlet';
                document.forms[0].submit();
            }
            function download_report()
            {
                document.getElementById("handle_id").value = "downloadReport";
                document.forms[0].action = '/PacsApplication/ExcelReportServlet';

                document.forms[0].submit();
            }





        </script>

        
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


 <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">EOD INTEREST COMPUTATION</legend>

        <form id="interestComputation" name="interestComputation" method="post" action="interestComputationServlet">
           
            <br>

            <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                <%}%>
            <br>

            <center>
                <br><br>
                <table style="column-gap: 5px; ">
                    <tr>
                        <td><input name="inttComputation" id="inttComputation" type="button" value="EOD Interest Computation" onclick="intt_post();" /></td>
                        <td>&nbsp;</td>
                        <td><input name="downloadReport" id="downloadReport" type="button" value="Download Report" onclick="download_report();" /></td>
                    </tr>
                </table>
            </center>
            <input name="handle_id" id="handle_id" type="hidden" value="" />
            <input name="screen_name" id="screen_name" type="hidden" value="EODinttComputation.jsp" />
            <input name="reportname" id="reportname" type="hidden" value="EOD_INTT_COMPUTATION_REPORT" />
            <input name="inputparam1" id="inputparam1" type="hidden" value="" />
            <input name="inputparam1" id="inputparam1" type="hidden" value="" />

        </form>
</fieldset>
    </body>
</html>
