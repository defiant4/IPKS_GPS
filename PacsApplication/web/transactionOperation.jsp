<%-- 
    Document   : ADHOC transaction
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="DataEntryBean.transactionOperationBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>

        <title>ADHOC Transaction</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }


            function submitform(transactionForm)
            {
                if (checkDiv(transactionForm))
                {
                    transactionForm.submit();
                }

            }

            function checkDiv(transactionForm)
            {
                if (transactionForm.tranType.value == "")
                {
                    alert("!! Value must be selected !!");
                    transactionForm.tranType.focus();
                    return false;
                }
                if (transactionForm.accNo.value == "")
                {
                    alert("!! Value must be selected !!");
                    transactionForm.accNo.focus();
                    return false;
                }
                if (transactionForm.trAmount.value == "")
                {
                    alert("!! All fields must be filled !!");
                    transactionForm.trAmount.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(transactionForm.accNo.value))
                {
                    alert("!! Account No. could only contain numbers !!");
                    transactionForm.accNo.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(transactionForm.trAmount.value))
                {
                    alert("!! Transaction amount could only contain numbers !!");
                    transactionForm.trAmount.focus();
                    return false;
                }
                return true;
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
                var screenName = "transactionOperation.jsp";
                var lovKey = "depositAccount"
                popWin = open('CommonSearchInformationLOV.jsp?accNo=' + accNo + '&screenName=' + screenName + '&lovKey=' + lovKey, 'depositAccount', attr);
                popWin.focus();

            }

        </script>

        <%
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>

        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>


        <jsp:include page="MenuHead.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object otransactionOperationBeanObj = request.getAttribute("otransactionOperationBeanObj");
            transactionOperationBean otransactionOperationBean = new transactionOperationBean();
            if (otransactionOperationBeanObj != null) {
                otransactionOperationBean = (transactionOperationBean) request.getAttribute("otransactionOperationBeanObj");
                session.setAttribute("otransactionOperationBeanObj", otransactionOperationBeanObj);
            }
        %>

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">ADHOC TRANSACTION OPERATION</legend>
            <form name="transactionForm" method="post" action="transactionOperationServlet"> 


                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>

                <div id="transaction" style="display:block;">
                    <table>
                        <tbody>
                            <tr>
                                <td>Select Transaction Type:</td>
                                <td><select id="tranType" name="tranType">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="1">KCC Repayment</option>
                                        <option value="2">KCC Disbursment</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Account No:</td>
                                <td><input type="text" name="accNo" value="" /></td>
                                <td><input type="button" name="accNoSearch" id="accNoSearch" value="Search" onclick="javascript:popup_depAccount(220, 180, document.transactionForm.accNo.value);"/></td>
                            </tr>
                            <tr>
                                <td>Transaction Amount:</td>
                                <td><input type="text" name="trAmount" size="15" value="" /></td>
                            </tr>
                        </tbody>
                    </table><br><br>

                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(transactionForm)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                </div>
            </form>
        </fieldset>
    </body>
</html>





