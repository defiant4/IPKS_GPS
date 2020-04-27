<%--
    Document   : PACS_REPORT
    Created on : Sep 17, 2015, 12:59:59 PM
    Author     : 454222
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>

        <script>

            function downloadFiles() {

                if (document.forms[0].txn_date.value == "")
                {
                    alert("!! Date Cannot Be Empty !!");
                    document.forms[0].txn_date.focus();
                    return false;
                }

                var e = document.getElementById("reportSelection");

                if (e.options[e.selectedIndex].value == "")
                {
                    alert("!! Report Name Cannot Be Empty !!");
                    document.forms[0].reportSelection.focus();
                    return false;
                }

                switch (e.options[e.selectedIndex].value) {

                    case "1" :

                        document.forms[0].reportPath.value = "/Reports/BGL_DAY_BOOK.jasper";
                        document.forms[0].reportName.value = "BGL TRANSACTION REPORT";
                        document.forms[0].DOWNLOAD.value = "P";
                        break;

                    case "2" :

                        document.forms[0].reportPath.value = "/Reports/BAL_IN_GL_ACC_GLCC_WISE_DET_.jasper";
                        document.forms[0].reportName.value = "BGL BALANCE REPORT";
                        document.forms[0].DOWNLOAD.value = "P";
                        break;

                    case "3" :

                        document.forms[0].reportPath.value = "/Reports/CC_TXN_REPORT.jasper";
                        document.forms[0].reportName.value = "CC ACCOUNT TRANSACTION REPORT";
                        document.forms[0].DOWNLOAD.value = "P";
                        break;

                    case "4" :

                        document.forms[0].reportPath.value = "/Reports/CC_BALANCE_FILE.jasper";
                        document.forms[0].reportName.value = "CC ACCOUNT BALANCE REPORT";
                        document.forms[0].DOWNLOAD.value = "P";
                        break;
                        
                        case "5" :

                        document.forms[0].reportPath.value = "/Reports/NODC_REPORT.jasper";
                        document.forms[0].reportName.value = "NODC REPORT";
                        document.forms[0].DOWNLOAD.value = "P";
                        break;

                    default :

                        null;

                }

                document.forms[0].action = '/PacsApplication/jasperReportServlet';
                document.forms[0].submit();

            }

        </script>

        <title>PACS Report</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack();">
    <script type="text/javascript">
        function noBack()
        {
            window.history.forward();
        }
    </script>
    <jsp:include page="MenuHead.jsp" flush="true" />
    <br>
    <div style="top:500px">
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">PACS REPORT</legend>
        
        <form name="pacsreport" method="post" action="/PacsApplication/DownloadPacsReport">
            <br>

            <table>
                <%if (request.getAttribute("error") != null) {%>
                <tr><td colspan="2" align="center"><%=request.getAttribute("error").toString()%></td></tr>
                    <%}%>

                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>
                <tr></tr>

                <tr>
                    <td style=" font-family: Berlin Sans FB; font-weight:  normal;">Select Date: <input type="text" style="text-align:center;" name="txn_date" maxlength="11" resize="yes" readonly="true"><a href="#" onclick="return getCalendar(document.forms[0].txn_date);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>

                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td style=" font-family: Berlin Sans FB; font-weight:normal; ">Report Name: </td>
                    <td> <select id="reportSelection" name="reportSelection" >                
                            <option value="" disabled selected style="display:none;" >--Select--</option>
                            <option value="1">BGL Transaction Report</option>
                            <option value="2">BGL Wise Balance Report</option>
                            <option value="3">CC Transaction Report</option>
                            <option value="4">CC Balance Report</option>
                            <option value="5">NODC Report</option>
                        </select></td>
                </tr>
            </table><br><br><br><br>
            <center>



              <input type="button" value="FETCH REPORT" onclick="javascript:downloadFiles();">

            </center>   

            <input type="hidden" name="reportPath" value=""/>
            <input type="hidden" name="reportName" value=""/>
            <input type="hidden" name="DOWNLOAD" value=""/>


        </form>
        </fieldset>
    </div>
</body>
</html>
