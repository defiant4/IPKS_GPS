<%-- 
    Document   : pacsFileUpload
    Created on : Aug 4, 2015, 12:57:41 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>




<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>File Upload</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack();">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function ActionMapping(Action_name)
            {
                if (Action_name == 'Upload' || Action_name == "Upload") {

                    var e = document.getElementById("UploadType");
                    if (e.options[e.selectedIndex].value == "")
                    {
                        alert("Please select Upload Type");
                        return false;
                    }

                    document.forms[0].action = '/PacsApplication/UploadExcelServlet';
                    document.forms[0].submit();
                }

                else if (Action_name == 'Download' || Action_name == "Download") {

                    document.forms[0].action = '/PacsApplication/DownloadExcelServlet';
                    document.forms[0].submit();

                }

                else if (Action_name == 'TrickleFeed' || Action_name == "TrickleFeed") {

                    var e = document.getElementById("UploadType");
                    if (e.options[e.selectedIndex].value == "")
                    {
                        alert("Please select Upload Type");
                        return false;
                    }

                    document.forms[0].action = '/PacsApplication/GenerateTrickleFeedServlet';
                    document.forms[0].submit();

                }
            }

        </script>

        <jsp:include page="MenuHead.jsp" flush="true" />
        <br>

        <%
                    String error_msg = "";
                    Object error = request.getAttribute("message");
                    if (error != null) {
                        error_msg = error.toString();
                    }
        %>

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">PACS FILE UPLOAD</legend>
            <form method="post" action="" enctype="multipart/form-data">
                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                <% }%>
                <center>
                    <br><br>
                    <table>
                        <tr>
                            <td style=" font-family: Berlin Sans FB; font-weight: normal; ">Select File Upload Type:</td>
                            <td>
                                <select name="UploadType" id="UploadType">
                                    <option value="">Please Select</option>
                                    <option value="SB">Bulk Savings Account Opening</option>
                                    <!-- <option value="CC">CC Account Opening</option> -->
                                </select>
                            </td>
                        </tr>
                        <tr><td><br></td></tr>
                        <tr>
                            <td style=" font-family: Berlin Sans FB; font-weight: normal;">Select file to upload:</td>
                            <td><input type="file" name="file" size="60"/></td>
                        </tr>
                    </table>
                    <br><br>
                    <input type="button" value="Upload" onclick="ActionMapping('Upload');"/> 
                    <input type="button" value="Download Template" onclick="ActionMapping('Download');"/>
                    <input type="button" value="Genrate Trickle Feed" onclick="ActionMapping('TrickleFeed');"/>

                </center>
            </form>
        </fieldset>
    </body>
</html>