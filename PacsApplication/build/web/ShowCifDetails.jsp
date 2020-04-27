<%--
    Document   : CifDetails
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>

<%@page import="DataEntryBean.CustomerInfBean"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CIF Details</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
      

    </head>
    <body  onload="noBack()">
    <script type="text/javascript">
            function noBack()
                 {
                    window.history.forward();
                 }
        </script>

        <script language="javascript" type="text/javascript">
            function ShowParent()
            {
                document.forms[0].action="CifDetails.jsp";
                document.forms[0].submit;
            }

        </script>

     <jsp:include page="MenuHead.jsp" flush="true" />

     <%!
         String blankNull(String s){
             return(s==null)?"":s;
             }
        %>
       <%
        CustomerInfBean CustomerInfBean=(CustomerInfBean) request.getAttribute("oCustomerInfBeanobj");
         %>

        <form method="post" action="CifEntryServlet">

            <table
                <thead>

                    <tr>

                        <th colspan>Customer Name and Address</th>
                    </tr>

                </thead>

                <tbody>

                    <tr>
                        <td>CIF Details:*</td>
                        <td><input type="text" name="cif" style="width: 260px" value="<%=blankNull(CustomerInfBean.getCif())%>"/></td>
                    </tr>

                     <tr>
                        <td>Customer Type:*</td>
                        <td><input type="text" name="ctype" style="width: 260px" value="<%=blankNull(CustomerInfBean.getCtype())%>"/></td>
                    </tr>

                     <tr>
                        <td>Title:*</td>
                        <td><input type="text" name="title" value="<%=blankNull(CustomerInfBean.getTitle())%>" /></td>
                    </tr>
                    <tr>
                        <td>First Name:*</td>
                        <td><input type="text" name="fname" style="width: 260px" value="<%=blankNull(CustomerInfBean.getFname())%>" /></td>
                    </tr>
                    <tr>
                        <td>Middle Name:</td>
                        <td><input type="text" name="mname"style="width: 260px" value="<%=blankNull(CustomerInfBean.getMname())%>" /></td>
                    </tr>
                    <tr>
                        <td>Last Name:*</td>
                        <td><input type="text" name="lname" style="width: 260px" value="<%=blankNull(CustomerInfBean.getLname())%>" /></td>
                    </tr>
                    <tr>
                        <td>Father/Spouse Name:</td>
                        <td><input type="text" name="fsname" style="width: 260px" value="<%=blankNull(CustomerInfBean.getFsname())%>" /></td>
                    </tr>
                    <tr>
                        <td>User Mother's Maiden Name:</td>
                        <td><input type="text" name="mthname" style="width: 260px" value="<%=blankNull(CustomerInfBean.getMthname())%>" /></td>
                    </tr>

                    <tr>
                        <td>Door/Flat No;Building/Society:* </td>
                        <td><input type="text" name="flatno" style="width: 260px" value="<%=blankNull(CustomerInfBean.getFlatno())%>" /></td>
                    </tr>
                    <tr>
                        <td>Block: </td>
                        <td><input type="text" name="streetname" style="width: 260px" value="<%=blankNull(CustomerInfBean.getStreetname())%>" /></td>
                    </tr>
                    <tr>
                        <td>Gram Panchayet:* </td>
                        <td><input type="text" name="localityname" style="width: 260px" value="<%=blankNull(CustomerInfBean.getLocalityname())%>" /></td>
                    </tr>

                    <tr>
                        <td>District: </td>
                        <td><input type="text" name="distname" style="width: 260px" value="<%=blankNull(CustomerInfBean.getDistname())%>" /></td>
                    </tr>

                    <tr>
                        <td>City/Town:* </td>
                        <td><input type="text" name="cityname"  value="<%=blankNull(CustomerInfBean.getCityname())%>" /></td>

                        <td>    State:* </td>
                        <td><input type="text" name="statename" value="<%=blankNull(CustomerInfBean.getStatename())%>" /></td>
                    </tr>

                      <tr>
                        <td>Country </td>
                        <td><input type="text" name="countryname" value="<%=blankNull(CustomerInfBean.getCountryname())%>" /></td>

                        <td>    Post Code:* </td>
                        <td><input type="text" name="postcode" value="<%=blankNull(CustomerInfBean.getPostcode())%>" /></td>
                    </tr>

                      <tr>
                        <td>Language </td>
                        <td><input type="text" name="language" value="<%=blankNull(CustomerInfBean.getLanguage())%>" /></td>

                        <td>    Phone(Home) </td>
                        <td><input type="text" name="phhome" value="<%=blankNull(CustomerInfBean.getPhhome())%>" /></td>
                    </tr>

                      <tr>
                        <td>Date Of Birth:* </td>
                        <td><input type="text" name="dob" value="<%=blankNull(CustomerInfBean.getDob())%>" /></td>

                        <td>    Phone(Business) </td>
                        <td><input type="text" name="phbusiness" value="<%=blankNull(CustomerInfBean.getPhbusiness())%>" /></td>
                    </tr>

                      <tr>
                        <td>Gender Code:* </td>
                        <td><input type="text" name="gencode" value="<%=blankNull(CustomerInfBean.getGencode())%>" /></td>

                        <td>    Mobile No: </td>
                        <td><input type="text" name="mob" value="<%=blankNull(CustomerInfBean.getMob())%>" /></td>
                    </tr>

                      <tr>
                        <td>Marital Status: </td>
                        <td><input type="text" name="mstatus" value="<%=blankNull(CustomerInfBean.getMstatus())%>" /></td>

                        <td>Fax No: </td>
                        <td><input type="text" name="fax" value="<%=blankNull(CustomerInfBean.getFax())%>" /></td>
                    </tr>

                      <tr>
                        <td>Nationality: </td>
                        <td><input type="text" name="nationality" value="<%=blankNull(CustomerInfBean.getNationality())%>" /></td>

                        <td>    Domicile: </td>
                        <td><input type="text" name="Domicile" value="<%=blankNull(CustomerInfBean.getDomicile())%>" /></td>
                    </tr>

                      <tr>
                        <td>Occupancy: </td>
                        <td><input type="text" name="Occupation" value="<%=blankNull(CustomerInfBean.getOccupation())%>" /></td>

                        <td>    Resident Status: </td>
                        <td><input type="text" name="resstatus" value="<%=blankNull(CustomerInfBean.getResstatus())%>" /></td>
                    </tr>

                </tbody>
            </table><br><br>
            <center>
            <input type="submit" value="Search" name="action">
            <input type="submit" value="Reset" name="reset" onclick="ShowParent();" />
            </center>
        </form>
         <p>         "*" fields are mandatory </p>
    </body>

</html>

