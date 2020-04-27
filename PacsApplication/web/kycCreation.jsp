<%-- 
    Document   : kycCreation
    Created on : Mar 18, 2016, 12:19:23 PM
    Author     : TCS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KYC Creation</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }
            function checkDiv(kycCreateForm)
            {
                if (kycCreateForm.linkedAccount.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.linkedAccount.focus();
                    return false;
                }
                if (kycCreateForm.tittle.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.tittle.focus();
                    return false;
                }
                if (kycCreateForm.fName.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.fName.focus();
                    return false;
                }
                if (kycCreateForm.lName.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.lName.focus();
                    return false;
                }
                if (kycCreateForm.add1.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.add1.focus();
                    return false;
                }
                if (kycCreateForm.add3.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.add3.focus();
                    return false;
                }
                if (kycCreateForm.distname.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.distname.focus();
                    return false;
                }
                if (kycCreateForm.gender.value == "")
                {
                    alert("!! * marked fields must be filled !!");
                    kycCreateForm.gender.focus();
                    return false;
                }


                if (kycCreateForm.cif.value.length != 11)
                {
                    alert("!!CIF Details must contain 11 digit !!");
                    kycCreateForm.cif.focus();
                    return false;
                }
                if (kycCreateForm.mNumber.value != "")
                {

                    if (kycCreateForm.mNumber.value.length != 10)
                    {
                        alert("!!Mobile Number Details must contain 10 digit !!");
                        kycCreateForm.mNumber.focus();
                        return false;
                    }
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(kycCreateForm.cif.value))
                {
                    alert("!!CIF Details could only contain numbers !!");
                    kycCreateForm.cif.focus();
                    return false;
                }
                return true;
            }


            function submitform(kycCreateForm)
            {
                if (checkDiv(kycCreateForm))
                {
                    document.forms[0].handle_id.value = "Create";
                    document.kycCreateForm.submit();
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
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">CUSTOMER (KYC) DETAILS CREATION</legend>
        <form action="kycCreationServlet" method="post" name="kycCreateForm"> 

            <br>
           
            <br>

            <%if (!error_msg.equalsIgnoreCase("")) {%>
            <div id="errorMessage" style="height:5px;"  >
                <font color="DarkGreen" > <%= error_msg%> </font>
            </div>        
            <% }%>
            <br><br>

            <div id="create" align="left" >
                <table>
                    <tbody>
                        <tr>
                            <td>CBS CIF No:*</td>
                            <td><input type="text" name="cif" id="cif" style="width: 260px;" /></td>
                        </tr>
                        <tr>
                            <td>Customer Type: </td>
                            <td><input type="text" name="cType"  id="cType" style="width: 260px" /></td>
                        </tr>

                        <tr>
                            <td>Linked CBS A/C No.*</td>
                            <td><input type="text" name="linkedAccount" id="linkedAccount"  /></td>
                        </tr>
                        <tr>
                            <td>Tittle:*</td>
                            <td><input type="text" name="tittle" id="tittle" /></td>
                        </tr>
                        <tr>
                            <td>First Name:*</td>
                            <td><input type="text" name="fName" style="width: 260px" id="fName" /></td>
                        </tr>
                        <tr>
                            <td>Middle Name: </td>
                            <td><input type="text" name="mName" style="width: 260px" id="mName"/></td>
                        </tr>    
                        <tr>
                            <td>Last Name:*</td>
                            <td><input type="text" name="lName" style="width: 260px" id="lName" /></td>
                        </tr>
                        <tr>
                            <td>Guardian Name: </td>
                            <td><input type="text" name="gName" style="width: 260px" id="gName"  /></td>
                        </tr>
                        <tr>
                            <td>
                                Address Line1:*
                            </td>
                            <td>
                                <textarea name="add1" id="add1" ></textarea>
                            </td>

                            <td>
                                Address Line2:
                            </td>
                            <td>
                                <textarea name="add2" id="add2"></textarea>
                            </td>
                            <td>
                                Address Line3:*
                            </td>
                            <td>
                                <textarea name="add3" id="add3"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>District:*</td>
                            <td><input type="text" name="distname" style="width: 260px" id="distname" /></td>
                            <td>City/Town: </td>
                            <td><input type="text" name="cityname" id="cityname" /></td>

                            <td>State: </td>
                            <td><input type="text" name="statename" id="statename" /></td>
                        </tr>
                        <tr>
                            <td>Date Of Birth: </td>
                            <td><input type="text" name="dob"  id="dob"/></td>
                        </tr>
                        <tr>
                            <td>Gender:*</td>
                            <td><input type="text" name="gender" id="gender" /></td>
                        </tr>
                        <tr>
                            <td>Mobile Number: </td>
                            <td><input type="text" maxlength=10 name="mNumber" id="mNumber" /></td>
                        </tr>
                        <tr>
                            <td>ID Type: </td>
                            <td><input type="text" name="idType" id="idType" /></td>
                            <td>ID Number: </td>
                            <td><input type="text" name="idNumber" id="idNumber" /></td>
                        </tr>
                        <tr>
                            <td>ID Issue Date: </td>
                            <td><input type="text" name="idIssueDate" id="idIssueDate" /></td>
                            <td>ID Issued At: </td>
                            <td><input type="text" name="idIssueAt"  id="idIssueAt"/></td>
                        </tr>
                    </tbody> 
                </table>
                <br>
                <center><input type="button" value="Submit" onclick="javascript:submitform(kycCreateForm)">
                    <input type="reset" value="Reset" name="reset" />
                </center>
            </div>
            <input type="hidden" name="handle_id" value="" />
        </form>
</fieldset>
    </body>
</html>
