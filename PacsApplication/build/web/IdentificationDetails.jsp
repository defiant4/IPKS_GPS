<%-- 
    Document   : IdentificationDetails
    Created on : Aug 3, 2015, 2:25:40 PM
    Author     : Administrator
--%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Identification Details</title>
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
    
     <%!
         String blankNull(String s){
             return(s==null)?"":s;
             }
        %>

        <fieldset style="border-color: black; border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">Identification</legend>
        <form method="post" action="/PacsApplication/IdenticationEntryServet">

            <table

                <thead>

                    <tr>
                        <th colspan>Identification</th>
                    </tr>

                </thead>

                <tbody>

                    <tr>
                        <td>CIF Details:*</td>
                        <td><input type="text" name="cif" style="width: 260px" value=""/></td>
                    </tr>

                     <tr>
                        <td>First ID Type:</td>
                        <td><input type="text" name="idype" style="width: 260px" value=""/></td>
                    </tr>

                     <tr>
                        <td>ID Issued at:</td>
                        <td><input type="text" name="issueat" style="width: 260px" value=""/></td>
                    </tr>
                    <tr>
                        <td>Remark:</td>
                        <td><input type="text" name="remark" style="width: 260px" value=""/></td>

                  </tr>
                    <tr>
                        <td>First ID No:*</td>
                        <td><input type="text" name="fidno"  value=""/></td>
                    <td>ID Issue Date:</td>
                        <td><input type="text" name="idissuedate"  value="" /></td>
                    </tr>

                    <tr>
                        <td>Second ID Type:</td>
                        <td><input type="text" name="secondid" style="width: 260px" value=""/></td>
                    </tr>
                    <tr>
                        <td>Second ID No:</td>
                        <td><input type="text" name="secondidno"  value=""/></td>
                     <td>Relationship Manager:</td>
                        <td><input type="text" name="rmanager"  value=""/></td>
                   </tr>

                    <tr>
                        <td>Home Branch:</td>
                        <td><input type="text" name="homebr"  value=""/></td>
                     <td>Customer Evalution Rate:</td>
                        <td><input type="text" name="cusevltn"  value=""/></td>
                     </tr>

                    <tr>
                        <td>Introducer: </td>
                        <td><input type="text" name="intro"  value=""/></td>
                    </tr>

                    <tr>
                        <th colspan>Internet Banking Details</th>
                    </tr>

                    <tr>
                        <td>Request For INB: </td>
                        <td><input type="text" name="inb"  value=""/></td>

                        <td>Email ID: </td>
                        <td><input type="text" name="emailid"  value=""/></td>
                    </tr>

                    <tr>
                        <td>Email Address: </td>
                        <td><input type="text" name="emailadd"  value=""/></td>
                    </tr>

                    <tr>
                        <td>Internet Banking Ref: </td>
                        <td><input type="text" name="bankref"  value=""/></td>
                     </tr>

                      <tr>
                        <th colspan>Visa Details</th>
                    </tr>

                      <tr>
                        <td>Visa Details: </td>
                        <td><input type="text" name="visadet" style="width: 260px" value=""/></td>
                     </tr>

                      <tr>
                        <td>Vise Issued By: </td>
                        <td><input type="text" name="visaissueby" style="width: 260px" value=""/></td>
                    </tr>

                      <tr>
                        <td>Visa Issue Date: </td>
                        <td><input type="text" name="visaissuedate" value="" /></td>

                        <td>    Visa Expiry Date:</td>
                        <td><input type="text" name="visaexpr" value="" /></td>
                    </tr>

                    <tr>
                        <th colspan>Customer Risk</th>
                    </tr>

                      <tr>
                        <td>Domestic Risk:* </td>
                        <td><input type="text" name="domrisk" style="width: 260px" value=""/></td>
                       </tr>

                          <tr>
                        <td>  Country Risk: </td>
                        <td><input type="text" name="countryrisk"  style="width: 260px" value=""/></td>
                    </tr>

                      <tr>
                        <td>Cross Border Risk:* </td>
                        <td><input type="text" name="borderrisk"  style="width: 260px" value=""/></td>
                    </tr>

                     <tr>
                        <th colspan>Customer Details</th>
                    </tr>
                      <tr>
                        <td>Segment Code: </td>
                        <td><input type="text" name="segment" value=""/></td>

                        <td>    Locker Holder: </td>
                        <td><input type="text" name="locker" value=""/></td>
                    </tr>

                      <tr>
                        <td>CIS Organisation Code: </td>
                        <td><input type="text" name="cis" value=""/></td>

                        <td>    TFN Indicator: </td>
                        <td><input type="text" name="tfn" value=""/></td>
                    </tr>

                </tbody>
            </table><br><br>
            <center>
            <input type="submit" value="Search" name="action">
            <input type="reset" value="Reset" name="reset" />
            </center>

        </form>
        <p> "*" fields are mandatory </p>
        </fieldset>
    </body>

   </html>
