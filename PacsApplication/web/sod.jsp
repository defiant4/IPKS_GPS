
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SOD</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }
        </script>
    </head>
    <body  onload="noBack()">
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
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">SOD OPERATION</legend>
            <form name="sod" id="sod" method="post" action="SodServlet">
                <br>

                <br>
                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>
                <br>
                <center>
                    <input type="submit" name="sod" value="Start SOD Operation"/>
                </center>
            </form>
        </fieldset>
    </body>
</html>
