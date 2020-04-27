<%-- 
    Document   : mark_unmark_NPA_Operations
    Created on : Mar 22, 2016, 12:37:45 PM
    Author     : Shubhrangshu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }
            function checkSubmit(npaOperation)
            {
                if (npaOperation.accountNumber.value == "")
                {
                    alert("!! All fields must be filled !!");
                    npaOperation.accountNumber.focus();
                    return false;
                }
                if (npaOperation.checkOperation.value == "")
                {
                    alert("!! All fields must be filled !!");
                    npaOperation.checkOperation.focus();
                    return false;
                }


                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(npaOperation.accountNumber.value))
                {
                    alert("!! Account Number could only contain numbers !!");
                    npaOperation.accountNumber.focus();
                    return false;
                }
            }
            
            function popup_depAccount(width, height, accNo) {
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
                var screenName = "mark_unmark_NPA_Operations.jsp";
                var lovKey = "depositAccount"
                popWin = open('CommonSearchInformationLOV.jsp?accNo=' + accNo + '&screenName=' + screenName + '&lovKey=' + lovKey, 'depositAccount', attr);
                popWin.focus();

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

        <br>
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">MARK/UNMARK AS NPA OPERATION</legend>
            <form action="Mark_Unmark_NPAOperationsServlet" method="post" name="npaOperation" onsubmit="checkSubmit(this)">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>
                <br>
                <center>
                    <table >
                        <tbody>
                            <tr>
                                <td>Enter Account Number:</td>
                                <td><input type="text" value="" name="accountNumber" size="20" /></td>
                                <td><input type="button" name="accNoSearch" id="accNoSearch" value="Search" onclick="javascript:popup_depAccount(220, 180, document.npaOperation.accountNumber.value);"/></td>
                            </tr>
                            <tr>
                                <td><br></td>
                            </tr>
                            <tr>
                                <td>Select Account as</td>
                                <td><select id="checkOperation" name="checkOperation" >
                                        <option value="" disabled selected style="display:none;" >--select--</option>
                                        <option value="1" >1:Standard</option>
                                        <option value="4" >4:Substandard</option>
                                        <option value="5" >5:Doubtful Asset 1</option>
                                        <option value="6" >6:Doubtful Asset 2</option>
                                        <option value="7" >7:Doubtful Asset 3</option>
                                        <option value="8" >8:Lost Asset</option>
                                    </select></td>
                            </tr>
                            <tr>
                                <td><br></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Submit"/></td>

                            </tr>

                        </tbody>
                    </table>
                </center>
            </form>
        </fieldset>
    </body>

</html>
