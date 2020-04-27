<%--
    Document   : MenuHead_PDS
    Created on : Apr 20, 2016, 3:19:56 PM
    Author     : 590685
--%>


<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<head>
    <title>Chrome CSS Drop Down Menu</title>
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/PacsApplication/css/styles.css" />
    <link rel="stylesheet" type="text/css" href="/PacsApplication/css/ButtonAndText.css" />
    <link rel="stylesheet" type="text/css" href="/PacsApplication/css/info.css" />

    <script type="text/javascript" src="/PacsApplication/chromejs/chrome.js">

        /***********************************************
         * Chrome CSS Drop Down Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
         * This notice MUST stay intact for legal use
         * Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
         ***********************************************/

    </script>
    <!-- For User And Site -->
</head>

<body style=" background-color: #FFFAFA ">
    <%
                String userName = new String();
                String pacsName = new String();
                String userRole = new String();
                String RoleName = new String();

                userName = (String) session.getAttribute("UserName");
                userName = userName.toUpperCase();
                pacsName = (String) session.getAttribute("pacsName");
                userRole = (String) session.getAttribute("userRole");
                RoleName = (String) session.getAttribute("RoleName");


    %>

    <div style="width: 100%; height: auto; top: 0; left: 0; margin-bottom: 0 auto;">

        <div id="IPKSimage" style=" top: 0; left: 0; border-bottom:0px;">
            <img src="/PacsApplication/img/PACS.jpg"  width="100%" height="65px" alt="Image - PACS"/>
        </div>

        <div style="border-bottom:0px; border-color: black; color: white; background-color: #006600; ">
            <div style="width: 33%;float: left;padding: 5px; border-radius: 5px;"><b>User Name:</b><font face="Trebuchet MS" size="2.5"> <%=userName%></font></div>
            <div style="width: 33%;float: right; text-align: right;padding: 5px; border-radius: 5px;"><b>PACS Name:</b><font face="Trebuchet MS" size="2.5"> <%=pacsName%></font></div>
            <div style="width: 33%; margin: 0 auto;text-align: center;padding: 5px; border-radius: 5px;"><b>User Type:</b><font face="Trebuchet MS" size="2.5"> <%=RoleName%></font></div>
        </div>

        <div id='cssmenu'>
            <ul>
                <li><a href='./welcome.jsp'><span>Home</span></a></li>

                <%if (userRole.equalsIgnoreCase("201603000004021")) {%>
                <li class='active has-sub'><a href="#" ><span>Parameter</span></a>
                   <ul>
                        <li><a href="./pdsProductCreation.jsp"><span>Product Creation</span></a></li>
                    </ul>
                </li>
                <%}%>

                <%if (userRole.equalsIgnoreCase("201603000004022")) {%>
                <li class='active has-sub'><a href="#" ><span>Member Operation</span></a>
                    <ul>
                        <li><a href="./memberEnrollment.jsp"><span>Member Enrollment</span></a></li>
                        <li><a href="./purchasedetail.jsp"><span>Member Purchase Detail</span></a></li>
                    </ul>
                </li>
                <%}%>

                <%if (userRole.equalsIgnoreCase("201603000004022")) {%>
                <li class='active has-sub'><a href="#" ><span>Operation</span></a>

                    <ul>
                        <li><a href="./pds_raise_requisition.jsp"><span>Raise Requisition</span></a></li>
                        <li><a href="./pds_stock_register.jsp"><span>Stock Register</span></a></li>
                    </ul>


                </li>
                <%}%>

               
                <%if (userRole.equalsIgnoreCase("201603000004022")) {%>
                <li class='active has-sub'><a href="#" ><span>Reports</span></a>
                   
                </li>
                <%}%>

                <li><a href="LogoutServlet">LogOut</a></li>
            </ul>
        </div>

    </div>

</body>

</html>