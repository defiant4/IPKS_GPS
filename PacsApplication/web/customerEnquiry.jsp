<%-- 
    Document   : customerEnquiry
    Created on : Mar 15, 2016, 3:46:48 PM
    Author     : Kaushik
--%>

<%@page import="DataEntryBean.customerEnquiryBean"%>
<%@page import="java.sql.ResultSet"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Enquiry</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">

        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function popup_CIF(width, height, cifNumber, cifName) {


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
                var screenName = "customerEnquiry.jsp";
                popWin = open('CommonSearchInformationLOV.jsp?cifNumber=' + cifNumber + '&cifName=' + cifName + '&screenName=' + screenName, 'CifDetails', attr);
                popWin.focus();
            }

            function popup_CIFNAME(width, height, cifName, cifNumber) {


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
                var screenName = "customerEnquiry.jsp";
                popWin = open('CommonSearchInformationLOV.jsp?cifName=' + cifName + '&cifNumber=' + cifNumber + '&screenName=' + screenName, 'CifDetails', attr);
                popWin.focus();
            }

            function submitform(customerEnquiry)
            {
                if (customerEnquiry.cifNumber.value == "" && customerEnquiry.cifName.value == "")
                {
                    alert("!! All the Search Fields are Empty !!");
                    return false;
                }
                document.customerEnquiry.submit();
            }
            function ShowParent()
            {
                document.forms[0].action = "customerEnquiry.jsp";
                document.forms[0].submit();
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

        <%
            String displayFlag = "";
            Object display = request.getAttribute("flag");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">CUSTOMER (KYC) DETAILS</legend>
            <form name="customerEnquiry" id="customerEnquiry" action="customerEnquiryServlet" method="post">
               
                
                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                <% }%>
                <br>
                <br>

                <center>
                    <table>
                        <tr><td>Enter CIF Number</td><td><input type="text" name="cifNumber" id="cifNumber"/><input type="button" value="Search" id="Search" onclick="javascript:popup_CIF(850, 200, document.customerEnquiry.cifNumber.value, document.customerEnquiry.cifName.value);"/></td></tr>
                        <tr><td> <br></td></tr>
                        <tr><td>Enter CIF Name</td><td><input type="text" name="cifName" id="cifName"/><input type="button" value="Search" id="Search" onclick="javascript:popup_CIFNAME(850, 200, document.customerEnquiry.cifName.value, document.customerEnquiry.cifNumber.value);"/></td></tr>
                        <tr><td> <br></td></tr>
                    </table>
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="Submit" id="Submit" onclick="javascript:submitform(customerEnquiry)"/>
                    <input type="button" value="Reset" id="Reset" onclick="ShowParent();" />
                </center>

            </form>

            <br>
           
            <%!
                String blankNull(String s) {
                    return (s == null) ? "" : s;
                }
            %>
            <%

                if (displayFlag.equalsIgnoreCase("Y")) {
                    customerEnquiryBean ocustomerEnquiryBean = (customerEnquiryBean) request.getAttribute("ocustomerEnquiryBeanObj");
            %>
            <div id="show" align="left" >
                <hr>
                <table>
                    <tbody>
                        <tr>
                            <td>CIF Details:*</td>
                            <td><input readonly type="text" name="cif" style="width: 260px" value="<%=blankNull(ocustomerEnquiryBean.getCif())%>" readonly /></td>
                        </tr>
                        <tr>
                            <td>Customer Type:*</td>
                            <td><input readonly type="text" name="cType" style="width: 260px" value="<%=blankNull(ocustomerEnquiryBean.getcType())%>"/></td>
                        </tr>

                        <tr>
                            <td>Linked CBS A/C No.</td>
                            <td><input readonly type="text" name="linkedAccount" value="<%=blankNull(ocustomerEnquiryBean.getLinkedAccount())%>" /></td>
                        </tr>
                        <tr>
                            <td>Tittle</td>
                            <td><input readonly type="text" name="tittle" value="<%=blankNull(ocustomerEnquiryBean.getTittle())%>" /></td>
                        </tr>
                        <tr>
                            <td>First Name:</td>
                            <td><input readonly type="text" name="fName" style="width: 260px" value="<%=blankNull(ocustomerEnquiryBean.getfName())%>" /></td>
                        </tr>
                        <tr>
                            <td>Middle Name:</td>
                            <td><input readonly type="text" name="mName" style="width: 260px" value="<%=blankNull(ocustomerEnquiryBean.getmName())%>" /></td>
                        </tr>    
                        <tr>
                            <td>Last Name:</td>
                            <td><input readonly type="text" name="lName" style="width: 260px" value="<%=blankNull(ocustomerEnquiryBean.getlName())%>" /></td>
                        </tr>
                        <tr>
                            <td>Guardian Name:</td>
                            <td><input readonly type="text" name="gName" style="width: 260px" value="<%=blankNull(ocustomerEnquiryBean.getgName())%>" /></td>
                        </tr>
                        <tr>
                            <td>
                                Address Line1:
                            </td>
                            <td>
                                <textarea readonly name="add1" id="add1"><%=blankNull(ocustomerEnquiryBean.getAdd1())%></textarea>
                            </td>

                            <td>
                                Address Line2:
                            </td>
                            <td>
                                <textarea readonly name="add2" id="add2"><%=blankNull(ocustomerEnquiryBean.getAdd2())%></textarea>
                            </td>
                            <td>
                                Address Line3:
                            </td>
                            <td>
                                <textarea readonly name="add3" id="add3"><%=blankNull(ocustomerEnquiryBean.getAdd3())%></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>District: </td>
                            <td><input readonly type="text" name="distname" style="width: 260px" value="<%=blankNull(ocustomerEnquiryBean.getDistname())%>" /></td>
                            <td>City/Town: </td>
                            <td><input readonly type="text" name="cityname"  value="<%=blankNull(ocustomerEnquiryBean.getCityname())%>" /></td>

                            <td>State: </td>
                            <td><input readonly type="text" name="statename" value="<%=blankNull(ocustomerEnquiryBean.getStatename())%>" /></td>
                        </tr>
                        <tr>
                            <td>Date Of Birth: </td>
                            <td><input readonly type="text" name="dob" value="<%=blankNull(ocustomerEnquiryBean.getDob())%>" /></td>
                        </tr>
                        <tr>
                            <td>Gender: </td>
                            <td><input readonly type="text" name="gender" value="<%=blankNull(ocustomerEnquiryBean.getGender())%>" /></td>
                        </tr>
                        <tr>
                            <td>Mobile Number: </td>
                            <td><input readonly type="text" name="mNumber" value="<%=blankNull(ocustomerEnquiryBean.getmNumber())%>" /></td>
                        </tr>
                        <tr>
                            <td>ID Type: </td>
                            <td><input readonly type="text" name="idType" value="<%=blankNull(ocustomerEnquiryBean.getIdType())%>" /></td>
                            <td>ID Number: </td>
                            <td><input readonly type="text" name="idNumber" value="<%=blankNull(ocustomerEnquiryBean.getIdNumber())%>" /></td>
                        </tr>
                        <tr>
                            <td>ID Issue Date: </td>
                            <td><input readonly type="text" name="idIssueDate" value="<%=blankNull(ocustomerEnquiryBean.getIdIssueDate())%>" /></td>
                            <td>ID Issued At: </td>
                            <td><input readonly type="text" name="idIssueAt" value="<%=blankNull(ocustomerEnquiryBean.getIdIssueAt())%>" /></td>
                        </tr>
                    </tbody> 
                </table>
            </div>
            <% }%>
        </fieldset>
    </body>
</html>
