<%--
    Document   : PACS_REPORT
    Created on : Sep 17, 2015, 12:59:59 PM
    Author     : 590685
--%>

<%@page import="DataEntryBean.adhocReportBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />

        <script>

            function downloadReport() {

                

                document.forms[0].handle_id.value = "Download Report";
                document.forms[0].action = '/PacsApplication/HrmAdhocReportServlet';
                document.forms[0].submit();

            }

            function getDetails() {

                document.forms[0].handle_id.value = "Get Data";
                document.forms[0].action = '/PacsApplication/HrmAdhocReportServlet';
                document.forms[0].submit();

            }

            function searchReport(width, height, reportId) {
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
                var screenName = "AdhocReport.jsp";
                var lovKey = "reportSearch"
                popWin = open('CommonSearchInformationLOV.jsp?reportId=' + reportId + '&screenName=' + screenName + '&lovKey=' + lovKey, 'reportSearch', attr);
                popWin.focus();

            }

        </script>

        <title>Adhoc Report</title>
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
            Object oadhocReportBeanObj = request.getAttribute("oadhocReportBeanObj");
            adhocReportBean oadhocReportBean = new adhocReportBean();

            if (oadhocReportBeanObj != null) {
                oadhocReportBean = (adhocReportBean) request.getAttribute("oadhocReportBeanObj");

            }
        %>


        <div style="top:500px">
            <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
                <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">ADHOC REPORT</legend>

                <form name="Adhocreport" method="post" action="/PacsApplication/HrmAdhocReportServlet">
                    <br>
                    <%if (!error_msg.equalsIgnoreCase("")) {%>
                    <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                                <% }%>
                    <br>
                    
                    <center>

                        <label style=" font-family: Berlin Sans FB; font-weight:normal; ">Report ID: </label><input value="<%=blankNull(oadhocReportBean.getReportID())%>" type="text" name="reportID" id="reportID"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Search" name="reportIDSearch" id="reportIDSearch" onclick="javascript:searchReport(220, 180, document.Adhocreport.reportID.value);">
                        <label style=" font-family: Berlin Sans FB; font-weight:normal; ">Report Name: </label><input style="width: 500px;" value="<%=blankNull(oadhocReportBean.getReportName())%>" type="text" name="reportName" id="reportName" readonly="true"/>
                        <br><br>

                        <label style=" font-family: Berlin Sans FB; font-weight:normal; ">Report Query :</label><br>
                        <br>
                        <textarea name="reportQuery" id="reportQuery" cols="100" rows="12" readonly="true"><%=blankNull(oadhocReportBean.getReportQuery())%></textarea>
                        <br>
                        <input type="button" value="Get Details" onclick="javascript:getDetails();">
                        <hr>
                        <br>
                        <table style="width : 100%">

                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 1 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter1" id="parameter1" value="<%=blankNull(oadhocReportBean.getParameter1())%>" readonly="true" />
                                <td style="float: right; width: 50%;" > Param Value 1 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value1" id="value1" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 2 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter2" id="parameter2" value="<%=blankNull(oadhocReportBean.getParameter2())%>" readonly="true"  />
                                <td style="float: right; width: 50%;" > Param Value 2 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value2" id="value2" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 3 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter3" id="parameter3" value="<%=blankNull(oadhocReportBean.getParameter3())%>" readonly="true"  />
                                <td style="float: right; width: 50%;" > Param Value 3 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value3" id="value3" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 4 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter4" id="parameter4" value="<%=blankNull(oadhocReportBean.getParameter4())%>" readonly="true" />
                                <td style="float: right; width: 50%;" > Param Value 4 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value4" id="value4" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 5 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter5" id="parameter5" value="<%=blankNull(oadhocReportBean.getParameter5())%>" readonly="true" />
                                <td style="float: right; width: 50%;" > Param Value 5 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value5" id="value5" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 6 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter6" id="parameter6" value="<%=blankNull(oadhocReportBean.getParameter6())%>" readonly="true" />
                                <td style="float: right; width: 50%;" > Param Value 6 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value6" id="value6" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 7 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter7" id="parameter7" value="<%=blankNull(oadhocReportBean.getParameter7())%>" readonly="true" />
                                <td style="float: right; width: 50%;" > Param Value 7 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value7" id="value7" value="" />
                            </tr>

                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 8 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter8" id="parameter8" value="<%=blankNull(oadhocReportBean.getParameter8())%>" readonly="true" />
                                <td style="float: right; width: 50%;" > Param Value 8 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value8" id="value8" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 9 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter9" id="parameter9" value="<%=blankNull(oadhocReportBean.getParameter9())%>" readonly="true"  />
                                <td style="float: right; width: 50%;" > Param Value 9 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value9" id="value9" value="" />
                            </tr>
                            <tr style="text-align: center;">
                                <td style="float: left; width: 50%;" > Parameter 10 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="parameter10" id="parameter10" value="<%=blankNull(oadhocReportBean.getParameter10())%>" readonly="true" />
                                <td style="float: right; width: 50%;" > Param Value 10 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="value10" id="value10" value="" />
                            </tr>

                        </table>
                        <br><br>
                        <input type="button" value="DOWNLOAD REPORT" onclick="javascript:downloadReport();">

                    </center>  
                    <input type="hidden" name="handle_id" id="handle_id" value="" >
                </form>
            </fieldset>
        </div>
    </body>
</html>
