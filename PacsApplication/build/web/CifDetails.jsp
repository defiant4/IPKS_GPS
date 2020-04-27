<%-- 
    Document   : CifDetails
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>

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
     <jsp:include page="MenuHead.jsp" flush="true" />
     
     
        <form method="post" action="/PacsApplication/CifEntryServlet">
                        
            <table>
                <thead>

                    <tr>
                        
                        <th colspan="1">Customer Name and Address</th>
                    </tr>

                </thead>

                <tbody>

                    <tr>
                        <td>CIF Details:*</td>
                        <td><input type="text" name="cif" style="width: 260px" value=""/></td>
                    </tr>

                     <tr>
                        <td>Customer Type:*</td>
                        <td><input type="text" name="ctype" style="width: 260px" value=""/></td>
                    </tr>

                     <tr>
                        <td>Title:*</td>
                        <td><input type="text" name="title" value="" /></td>
                    </tr>
                    <tr>
                        <td>First Name:*</td>
                        <td><input type="text" name="fname" style="width: 260px" value="" /></td>
                    </tr>
                    <tr>
                        <td>Middle Name:</td>
                        <td><input type="text" name="mname"style="width: 260px" value="" /></td>
                    </tr>
                    <tr>
                        <td>Last Name:*</td>
                        <td><input type="text" name="lname" style="width: 260px" value="" /></td>
                    </tr>
                    <tr>
                        <td>Father/Spouse Name:</td>
                        <td><input type="text" name="fsname" style="width: 260px" value="" /></td>
                    </tr>
                    <tr>
                        <td>User Mother's Maiden Name:</td>
                        <td><input type="text" name="mthname" style="width: 260px" value="" /></td>
                    </tr>

                    <tr>
                        <td>Door/Flat No;Building/Society:* </td>
                        <td><input type="text" name="flatno" style="width: 260px" value="" /></td>
                    </tr>
                    <tr>
                        <td>Block: </td>
                        <td><input type="text" name="streetname" style="width: 260px" value="" /></td>
                    </tr>
                    <tr>
                        <td>Gram Panchayet:* </td>
                        <td><input type="text" name="localityname" style="width: 260px" value="" /></td>
                    </tr>

                    <tr>
                        <td>District: </td>
                        <td><input type="text" name="distname" style="width: 260px" value="" /></td>
                    </tr>

                    <tr>
                        <td>City/Town:* </td>
                        <td><input type="text" name="cityname"  value="" /></td>

                        <td>    State:* </td>
                        <td><input type="text" name="statename" value="" /></td>
                    </tr>

                      <tr>
                        <td>Country </td>
                        <td><input type="text" name="countryname" value="" /></td>

                        <td>    Post Code:* </td>
                        <td><input type="text" name="postcode" value="" /></td>
                    </tr>

                      <tr>
                        <td>Language </td>
                        <td><input type="text" name="language" value="" /></td>

                        <td>    Phone(Home) </td>
                        <td><input type="text" name="phhome" value="" /></td>
                    </tr>

                      <tr>
                        <td>Date Of Birth:* </td>
                        <td><input type="text" name="dob" value="" /></td>

                        <td>    Phone(Business) </td>
                        <td><input type="text" name="phbusiness" value="" /></td>
                    </tr>

                      <tr>
                        <td>Gender Code:* </td>
                        <td><input type="text" name="gencode" value="" /></td>

                        <td>    Mobile No: </td>
                        <td><input type="text" name="mob" value="" /></td>
                    </tr>

                      <tr>
                        <td>Marital Status: </td>
                        <td><input type="text" name="mstatus" value="" /></td>

                        <td>Fax No: </td>
                        <td><input type="text" name="fax" value="" /></td>
                    </tr>

                      <tr>
                        <td>Nationality: </td>
                        <td><input type="text" name="nationality" value="" /></td>

                        <td>    Domicile: </td>
                        <td><input type="text" name="Domicile" value="" /></td>
                    </tr>

                      <tr>
                        <td>Occupancy: </td>
                        <td><input type="text" name="Occupation" value="" /></td>

                        <td>    Resident Status: </td>
                        <td><input type="text" name="resstatus" value="" /></td>
                    </tr>

                </tbody>
            </table><br><br>
            <center>
            <input type="submit" value="Search" name="action">
            <input type="reset" value="Reset" name="reset" />
            </center>
        </form>
         <p>         "*" fields are mandatory </p>
    </body>

</html>

