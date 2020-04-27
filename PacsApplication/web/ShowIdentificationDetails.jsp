<%--
    Document   : IdentificationDetails
    Created on : Aug 3, 2015, 2:25:40 PM
    Author     : Administrator
--%>

<%@page import="DataEntryBean.CustomerIdentificationBean"%>

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

         <script language="javascript" type="text/javascript">
            function ShowParent()
            {
                document.forms[0].action="IdentificationDetails.jsp";
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
        CustomerIdentificationBean CustomerIdentificationBean=(CustomerIdentificationBean) request.getAttribute("oCustomerIdentificationBeanObj");
        %>

        <form method="post" action="IdenticationEntryServet">

            <table

                <thead>

                    <tr>
                        <th colspan>Identification</th>
                    </tr>

                </thead>

                <tbody>

                    <tr>
                        <td>CIF Details:*</td>
                        <td><input type="text" name="cif" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getCif())%>"/></td>
                    </tr>

                     <tr>
                        <td>First ID Type:</td>
                        <td><input type="text" name="idype" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getIdype())%>" /></td>
                    </tr>

                     <tr>
                        <td>ID Issued at:</td>
                        <td><input type="text" name="issueat" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getIssueat())%>" /></td>
                    </tr>
                    <tr>
                        <td>Remark:</td>
                        <td><input type="text" name="remark" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getRemark())%>"  /></td>

                  </tr>
                    <tr>
                        <td>First ID No:*</td>
                        <td><input type="text" name="fidno"  value="<%=blankNull(CustomerIdentificationBean.getFidno())%>"  /></td>
                    <td>ID Issue Date:</td>
                        <td><input type="text" name="idissuedate"  value="<%=blankNull(CustomerIdentificationBean.getIdissuedate())%>"  /></td>
                    </tr>

                    <tr>
                        <td>Second ID Type:</td>
                        <td><input type="text" name="secondid" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getSecondid())%>" /></td>
                    </tr>
                    <tr>
                        <td>Second ID No:</td>
                        <td><input type="text" name="secondidno"  value="<%=blankNull(CustomerIdentificationBean.getSecondidno())%>" /></td>
                     <td>Relationship Manager:</td>
                        <td><input type="text" name="rmanager"  value="<%=blankNull(CustomerIdentificationBean.getRmanager())%>" /></td>
                   </tr>

                    <tr>
                        <td>Home Branch:</td>
                        <td><input type="text" name="homebr"  value="<%=blankNull(CustomerIdentificationBean.getHomebr())%>" /></td>
                     <td>Customer Evalution Rate:</td>
                        <td><input type="text" name="cusevltn"  value="<%=blankNull(CustomerIdentificationBean.getCusevltn())%>" /></td>
                     </tr>

                    <tr>
                        <td>Introducer: </td>
                        <td><input type="text" name="intro"  value="<%=blankNull(CustomerIdentificationBean.getIntro())%>" /></td>
                    </tr>

                    <tr>
                        <th colspan>Internet Banking Details</th>
                    </tr>

                    <tr>
                        <td>Request For INB: </td>
                        <td><input type="text" name="inb"  value="<%=blankNull(CustomerIdentificationBean.getInb())%>" /></td>

                        <td>Email ID: </td>
                        <td><input type="text" name="emailid"  value="<%=blankNull(CustomerIdentificationBean.getEmailid())%>" /></td>
                    </tr>

                    <tr>
                        <td>Email Address: </td>
                        <td><input type="text" name="emailadd"  value="<%=blankNull(CustomerIdentificationBean.getEmailadd())%>" /></td>
                    </tr>

                    <tr>
                        <td>Internet Banking Ref: </td>
                        <td><input type="text" name="bankref"  value="<%=blankNull(CustomerIdentificationBean.getBankref())%>" /></td>
                     </tr>

                      <tr>
                        <th colspan>Visa Details</th>
                    </tr>

                      <tr>
                        <td>Visa Details: </td>
                        <td><input type="text" name="visadet" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getVisadet())%>" /></td>
                     </tr>

                      <tr>
                        <td>Vise Issued By: </td>
                        <td><input type="text" name="visaissueby" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getVisaissueby())%>" /></td>
                    </tr>

                      <tr>
                        <td>Visa Issue Date: </td>
                        <td><input type="text" name="visaissuedate" value="<%=blankNull(CustomerIdentificationBean.getVisaissuedate())%>"  /></td>

                        <td>    Visa Expiry Date:</td>
                        <td><input type="text" name="visaexpr" value="<%=blankNull(CustomerIdentificationBean.getVisaexpr())%>"  /></td>
                    </tr>

                    <tr>
                        <th colspan>Customer Risk</th>
                    </tr>

                      <tr>
                        <td>Domestic Risk:* </td>
                        <td><input type="text" name="domrisk" style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getDomrisk())%>" /></td>
                       </tr>

                          <tr>
                        <td>  Country Risk: </td>
                        <td><input type="text" name="countryrisk"  style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getCountryrisk())%>" /></td>
                    </tr>

                      <tr>
                        <td>Cross Border Risk:* </td>
                        <td><input type="text" name="borderrisk"  style="width: 260px" value="<%=blankNull(CustomerIdentificationBean.getBorderrisk())%>" /></td>
                    </tr>

                     <tr>
                        <th colspan>Customer Details</th>
                    </tr>
                      <tr>
                        <td>Segment Code: </td>
                        <td><input type="text" name="segment" value="<%=blankNull(CustomerIdentificationBean.getSegment())%>" /></td>

                        <td>    Locker Holder: </td>
                        <td><input type="text" name="locker" value="<%=blankNull(CustomerIdentificationBean.getLocker())%>" /></td>
                    </tr>

                      <tr>
                        <td>CIS Organisation Code: </td>
                        <td><input type="text" name="cis" value="<%=blankNull(CustomerIdentificationBean.getCis())%>" /></td>

                        <td>    TFN Indicator: </td>
                        <td><input type="text" name="tfn" value="<%=blankNull(CustomerIdentificationBean.getTfn())%>" /></td>
                    </tr>

                </tbody>
            </table><br><br>
            <center>
            <input type="submit" value="Search" name="action">
             <input type="submit" value="Reset" name="reset" onclick="ShowParent();" />
            </center>

        </form>
        <p> "*" fields are mandatory </p>
    </body>

   </html>
