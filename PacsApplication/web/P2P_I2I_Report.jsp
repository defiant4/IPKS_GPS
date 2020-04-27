<%--
    Document   : PACS_REPORT
    Created on : Sep 17, 2015, 12:59:59 PM
    Author     : 590685
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

                var e = document.getElementById("dccb_code");

                if (e.options[e.selectedIndex].value == "")
                {
                    alert("!! DCCB Name Cannot Be Empty !!");
                    document.forms[0].dccb_code.focus();
                    return false;
                }

                document.forms[0].reportPath.value = "/Reports/P2PI2I_POSTING_REPORT.jasper";
                document.forms[0].reportName.value = "P2P_I2I";
                document.forms[0].DOWNLOAD.value = "P";

                document.forms[0].action = '/PacsApplication/jasperReportServlet';
                document.forms[0].submit();

            }

        </script>

        <title>P2P And I2I Report</title>
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
                <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">PRINCIPAL TO PRINCIPAL/INTEREST TO INTEREST REPORT</legend>

                <form name="pacsreport" method="post" action="/PacsApplication/jasperReportServlet">
                    <br>

                    <table>

                        <tr></tr>
                        <tr></tr>
                        <tr></tr>
                        <tr></tr>
                        <tr></tr>
                        <tr></tr>
                        <tr></tr>
                        <tr></tr>

                        <tr>
                            <td style=" font-family: Berlin Sans FB; font-weight:normal;">Select Date: <input type="text" style="text-align:center;" name="txn_date" maxlength="11" resize="yes" readonly="true"><a href="#" onclick="return getCalendar(document.forms[0].txn_date);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>

                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style=" font-family: Berlin Sans FB; font-weight:normal; ">DCCB Name: </td>
                            <td> <select id="dccb_code" name="dccb_code" >                
                                    <option value="" disabled selected style="display:none;" >--Select--</option>
                                    <option value="1">1:Birbhum District Central Co-operative Bank</option>
                                    <option value="2">2:Bankura District Central Co-operative Bank</option>
                                    <option value="3">3:Balageria Central Co-operative Bank</option>
                                    <option value="4">4:Dhakshin Dinajpur District Central Co-operative Bank</option>
                                    <option value="5">5:Darjeeling District Central Co-operative Bank</option>
                                    <option value="6">6:Hooghly District Central Co-operative Bank</option>
                                    <option value="7">7:Howrah District Central Co-operative Bank</option>
                                    <option value="8">8:Jalpaiguri District Central Co-operative Bank</option>
                                    <option value="9">9:Murshidabad District Central Co-operative Bank</option>
                                    <option value="10">10:Malda District Central Co-operative Bank</option>
                                    <option value="11">11:Mugberia District Central Co-operative Bank</option>
                                    <option value="12">12:Nadia District Central Co-operative Bank</option>
                                    <option value="13">13:Purulia Central Co-operative Bank</option>
                                    <option value="14">14:Raiganj District Central Co-operative Bank</option>
                                    <option value="15">15:Tamluk-Ghatal Central Co-operative Bank</option>
                                    <option value="16">16:The West Bengal State Co-operative Bank</option>
                                    <option value="17">17:Vidyasagar Central Co-operative Bank</option>
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
