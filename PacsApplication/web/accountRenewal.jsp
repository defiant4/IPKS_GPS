<%-- 
    Document   : accountRenewal
    Created on : Mar 8, 2016, 1:20:58 PM
    Author     : Tcs Helpdesk10
--%>

<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.AccountRenewalBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <title>Account Renewal</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }
            function submitform(accRenewalForm)
            {
                if (checkDiv(accRenewalForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    accRenewalForm.submit();
                }
            }
            function getform()
            {
                if (accRenewalForm.cifNumber.value == "" && accRenewalForm.ccAccount.value == "")
                {
                    alert("!! All the Search Fields are Empty !!");
                    return false;
                }

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/AccountRenewalServlet';
                document.forms[0].submit();
            }
            function checkDiv(accRenewalForm)
            {

                if (accRenewalForm.productCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.productCode.focus();
                    return false;
                }
                if (accRenewalForm.inttCategory.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.inttCategory.focus();
                    return false;
                }
                if (accRenewalForm.segmentCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.segmentCode.focus();
                    return false;
                }
                if (accRenewalForm.cifNumber.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.cifNumber.focus();
                    return false;
                }
                if (accRenewalForm.cbsSavingsAccount.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.cbsSavingsAccount.focus();
                    return false;
                }
                if (accRenewalForm.limit.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.limit.focus();
                    return false;
                }
                if (accRenewalForm.limitExpiryDate.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.limitExpiryDate.focus();
                    return false;
                }
                if (accRenewalForm.collateralType.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.collateralType.focus();
                    return false;
                }
                if (accRenewalForm.landinAcres.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.landinAcres.focus();
                    return false;
                }
                if (accRenewalForm.description.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.description.focus();
                    return false;
                }
                if (accRenewalForm.currentValuation.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.currentValuation.focus();
                    return false;
                }
                if (accRenewalForm.safeLendingMargin.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.safeLendingMargin.focus();
                    return false;
                }
                if (accRenewalForm.activityCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.activityCode.focus();
                    return false;
                }
                if (accRenewalForm.customerType.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accRenewalForm.customerType.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(accRenewalForm.cifNumber.value))
                {
                    alert("!! CIF number could only contain numbers !!");
                    accRenewalForm.cifNumber.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(accRenewalForm.cbsSavingsAccount.value))
                {
                    alert("!! CBS savings account could only contain numbers !!");
                    accRenewalForm.cbsSavingsAccount.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(accRenewalForm.limit.value))
                {
                    alert("!! Limit could only contain numbers !!");
                    accRenewalForm.limit.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(accRenewalForm.currentValuation.value))
                {
                    alert("!! CurrentValuation could only contain numbers !!");
                    accRenewalForm.currentValuation.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(accRenewalForm.safeLendingMargin.value))
                {
                    alert("!! SafeLendingMargin could only contain numbers !!");
                    accRenewalForm.safeLendingMargin.focus();
                    return false;
                }
                return true;
            }


            function ShowParent()
            {
                document.forms[0].action = "accountRenewal.jsp";
                document.forms[0].submit();
            }
            function popup_ccAccount(width, height, cifNumber, ccAccountNo) {
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
                var screenName = "accountRenewal.jsp";
                var lovKey = "renewalAccNumberSearch"
                popWin = open('CommonSearchInformationLOV.jsp?cifNumber=' + cifNumber + '&ccAccountNo=' + ccAccountNo + '&screenName=' + screenName + '&lovKey=' + lovKey, 'renewalAccNumberSearch', attr);
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

        <%
            Object oAccountRenewalBeanObj = request.getAttribute("oAccountRenewalBeanObj");
            AccountRenewalBean oAccountRenewalBean = new AccountRenewalBean();
            if (oAccountRenewalBeanObj != null) {
                oAccountRenewalBean = (AccountRenewalBean) request.getAttribute("oAccountRenewalBeanObj");

            }
        %>

        <jsp:include page="MenuHead.jsp" flush="true" />    
        <br>

        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">ACCOUNT RENEWAL</legend>

            <form name="accRenewalForm" method="post" onsubmit="return checkDiv(this)" action="AccountRenewalServlet">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>          
                            <%}%>
                <br>
                <% if (displayFlag.equalsIgnoreCase("")) {%>
                <div id="searchDetails">
                    <center>
                        <table>
                            <tr><td>Enter CIF Number</td><td><input type="text" name="cifNumber" id="cifNumber"/><input type="button" value="Search" id="Search" onclick="javascript:popup_ccAccount(600, 180, document.accRenewalForm.cifNumber.value, document.accRenewalForm.ccAccount.value);"/></td></tr>
                            <tr><td> <br></td></tr>
                            <tr><td>Enter CC Account Number</td><td><input type="text" name="ccAccount" id="ccAccount"/><input type="button" value="Search" id="Search" onclick="javascript:popup_ccAccount(600, 180, document.accRenewalForm.cifNumber.value, document.accRenewalForm.ccAccount.value);"/></td></tr>
                            <tr><td> <br></td></tr>
                        </table>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="Get Details" id="Submit" onclick="javascript:getform(accRenewalForm)"/>
                        <input type="button" value="Reset" id="Reset" onclick="ShowParent();" />
                    </center>
                </div>
                <%}%>
                <br>
                <%
                    if (displayFlag.equalsIgnoreCase("Y")) {
                %>

                <div id="showDetails" align="left">

                    <table>
                        <tr><td><hr></td></tr>
                        <tr><td><h3>Account Information :</h3></td></tr>
                        <tr>
                            <td><lable>Account Number :</lable></td>
                        <td><input type="text" id="accNumber" name="accNumber" readonly="true" value="<%=blankNull(oAccountRenewalBean.getAccNumber())%>" /></td>
                        </tr>
                        <tr>
                            <td><lable>Product Code :</lable></td>
                        <td><input type="text" id="productName" name="productName" value="<%=blankNull(oAccountRenewalBean.getProductName())%>" readonly="true" /></td> 

                        </tr>
                        <tr>
                            <td><lable>Intt Category :</lable></td>
                        <td><input type="text" id="inttDescription" name="inttDescription" value="<%=blankNull(oAccountRenewalBean.getInttDescription())%>"  readonly="true" /></td>   
                        </tr> 

                        <tr>
                            <td><lable>Segment Code :</lable></td>
                        <td>
                            <select id="segmentCode" name="segmentCode" disabled="true">
                                <option value="" disabled selected style="display:none;">--Select--</option>
                                <option value="0706"<%if (oAccountRenewalBean.getSegmentCode().equals("0706")) {%> selected <%}%>>0706:INDIVIDUAL</option>
                                <option value="0306"<%if (oAccountRenewalBean.getSegmentCode().equals("0306")) {%> selected <%}%>>0306:STAFF</option>
                                <option value="5003"<%if (oAccountRenewalBean.getSegmentCode().equals("5003")) {%> selected <%}%>>5003:SENIOR CITIZEN</option>
                                <option value="5010"<%if (oAccountRenewalBean.getSegmentCode().equals("5010")) {%> selected <%}%>>5010:SHG</option>
                                <option value="5000"<%if (oAccountRenewalBean.getSegmentCode().equals("5000")) {%> selected <%}%>>5000:BANKS</option>
                                <option value="5009"<%if (oAccountRenewalBean.getSegmentCode().equals("5009")) {%> selected <%}%>>5009:INSTITUTIONS</option>
                                <option value="5050"<%if (oAccountRenewalBean.getSegmentCode().equals("5050")) {%> selected <%}%>>5050:OTHERS</option>
                                <option value="5007"<%if (oAccountRenewalBean.getSegmentCode().equals("5007")) {%> selected <%}%>>5007:SOCIETY</option>
                                <option value="5011"<%if (oAccountRenewalBean.getSegmentCode().equals("5011")) {%> selected <%}%>>5011:GOV/SEMI GOV</option>
                                <option value="5012"<%if (oAccountRenewalBean.getSegmentCode().equals("5012")) {%> selected <%}%>>5012:PACS</option>
                                <option value="5013"<%if (oAccountRenewalBean.getSegmentCode().equals("5013")) {%> selected <%}%>>5013:UCB</option>
                                <option value="5014"<%if (oAccountRenewalBean.getSegmentCode().equals("5014")) {%> selected <%}%>>5014:SCB</option>
                                <option value="5015"<%if (oAccountRenewalBean.getSegmentCode().equals("5015")) {%> selected <%}%>>5015:CCB</option>
                            </select>
                        </td>
                        </tr>
                        <tr>
                            <td><lable>CIF Number :</lable></td>
                        <td><input type="text" id="cifNumber" name="cifNumber" value="<%=blankNull(oAccountRenewalBean.getCifNumber())%>" readonly></td>
                        </tr>
                        <tr>
                            <td><lable>Linked CBS Savings Account :</lable></td>
                        <td><input type="text" id="cbsSavingsAccount" name="cbsSavingsAccount" value="<%=blankNull(oAccountRenewalBean.getCbsSavingsAccount())%>" readonly="true"></td>                        
                        </tr>

                        <tr><td><hr></td></tr>
                        <tr><td><h3>Limit Information</h3></td></tr>

                        <tr>
                            <td><lable>Limit :</lable></td>
                        <td><input type="text" id="limit" name="limit" ></td>                        
                        </tr>
                        <tr>
                            <td><lable>Limit Expiry Date :</lable></td>
                        <td><input type="text" id="limitExpiryDate" name="limitExpiryDate" readonly="true"><a href="#" onclick="return getCalendar(document.forms[0].limitExpiryDate);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></a></td>                        
                        </tr>

                        <tr><td><hr></td></tr>
                        <tr><td><h3>Collateral Information :</h3></td></tr>
                        <tr>
                            <td><lable>Collateral Type :</lable></td>
                        <td>
                            <select id="collateralType" name="collateralType">
                                <option value="" disabled selected style="display:none;">--Select--</option>
                                <option value="L">Land</option>
                                <option value="O">Others</option>
                            </select>
                        </td>
                        </tr>
                        <tr>
                            <td><lable>Land in Acres :</lable></td>
                        <td><input type="text" id="landinAcres" name="landinAcres"></td>
                        </tr>
                        <tr>
                            <td><lable>Description :</lable></td>
                        <td><textarea id="description" name="description" style="width : 150px"></textarea></td>                        
                        </tr>
                        <tr>
                            <td><lable>Current Valuation (in Rs.):</lable></td>
                        <td><input type="text" id="currentValuation" name="currentValuation"/></td>                        
                        </tr>
                        <tr>
                            <td><lable>Safe Lending Margin :</lable></td>
                        <td><input type="text" id="safeLendingMargin" name="safeLendingMargin"/></td>
                        <td><lable>%</lable></td>                        
                        </tr>

                        <tr><td><hr></td></tr>
                        <tr><td><h3>Additional Information :</h3></td></tr>

                        <tr>
                            <td><lable>Activity Code :</lable></td>
                        <td>
                            <select id="activityCode" name="activityCode" disabled="true">
                                <option value="" disabled selected style="display:none;">--Select--</option>
                                <option value="1" <%if (oAccountRenewalBean.getActivityCode().equals("1")) {%> selected <%}%>>Direct Agriculture</option>
                                <option value="2" <%if (oAccountRenewalBean.getActivityCode().equals("2")) {%> selected <%}%>>Indirect Agriculture</option>
                                <option value="3"<%if (oAccountRenewalBean.getActivityCode().equals("3")) {%> selected <%}%>>Agricultural Service Units</option>
                                <option value="4"<%if (oAccountRenewalBean.getActivityCode().equals("4")) {%> selected <%}%>>Farm Irrigation</option>
                                <option value="5"<%if (oAccountRenewalBean.getActivityCode().equals("5")) {%> selected <%}%>>Fruits & Vegetables</option>
                            </select>
                        </td>
                        </tr>                
                        <tr>
                            <td><lable>Customer Type :</lable></td>
                        <td>
                            <select id="customerType" name="customerType" disabled="true">
                                <option value="" disabled selected style="display:none;">--Select--</option>
                                <option value="I"<%if (oAccountRenewalBean.getCustomerType().equals("I")) {%> selected <%}%>>Individual</option>
                                <option value="C"<%if (oAccountRenewalBean.getCustomerType().equals("C")) {%> selected <%}%>>Corporate</option>
                            </select>
                        </td>
                        </tr>
                    </table>
                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(accRenewalForm)">
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                    </center>
                    <tr><td><br></td></tr>
                    <tr><td><br></td></tr>
                    <label style=" font-family: Berlin Sans FB; font-weight:normal; ">All fields are mandatory</label>
                </div>
                <% }%>
                <input type="hidden" name="handle_id" value="" />
                <input type="hidden" name="productCode" value="<%=blankNull(oAccountRenewalBean.getProductCode())%>" />
                <input type="hidden" name="inttCategory" value="<%=blankNull(oAccountRenewalBean.getInttCategory())%>" />
            </form>
        </fieldset>
    </body>
</html>