<%-- 
    Document   : accountCreation
    Created on : Mar 8, 2016, 1:20:58 PM
    Author     : Tcs Helpdesk10
--%>

<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.AccountCreationBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <title>Account Creation</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }
            function submitform(accCreatForm)
            {
                if (checkDiv(accCreatForm))
                {
                    accCreatForm.submit();
                }
            }
            function checkDiv(accCreatForm)
            {

                if (accCreatForm.productCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.productCode.focus();
                    return false;
                }
                if (accCreatForm.inttCategory.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.inttCategory.focus();
                    return false;
                }
                if (accCreatForm.segmentCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.segmentCode.focus();
                    return false;
                }
                if (accCreatForm.cifNumber.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.cifNumber.focus();
                    return false;
                }
                if (accCreatForm.cbsSavingsAccount.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.cbsSavingsAccount.focus();
                    return false;
                }
                if (accCreatForm.limit.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.limit.focus();
                    return false;
                }
                if (accCreatForm.limitExpiryDate.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.limitExpiryDate.focus();
                    return false;
                }
                if (accCreatForm.collateralType.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.collateralType.focus();
                    return false;
                }
                if (accCreatForm.landinAcres.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.landinAcres.focus();
                    return false;
                }
                if (accCreatForm.description.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.description.focus();
                    return false;
                }
                if (accCreatForm.currentValuation.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.currentValuation.focus();
                    return false;
                }
                if (accCreatForm.safeLendingMargin.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.safeLendingMargin.focus();
                    return false;
                }
                if (accCreatForm.activityCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.activityCode.focus();
                    return false;
                }
                if (accCreatForm.customerType.value == "")
                {
                    alert("!! All fields must be filled !!");
                    accCreatForm.customerType.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(accCreatForm.cifNumber.value))
                {
                    alert("!! CIF number could only contain numbers !!");
                    accCreatForm.cifNumber.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(accCreatForm.cbsSavingsAccount.value))
                {
                    alert("!! CBS savings account could only contain numbers !!");
                    accCreatForm.cbsSavingsAccount.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(accCreatForm.limit.value))
                {
                    alert("!! Limit could only contain numbers !!");
                    accCreatForm.limit.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(accCreatForm.currentValuation.value))
                {
                    alert("!! CurrentValuation could only contain numbers !!");
                    accCreatForm.currentValuation.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(accCreatForm.safeLendingMargin.value))
                {
                    alert("!! SafeLendingMargin could only contain numbers !!");
                    accCreatForm.safeLendingMargin.focus();
                    return false;
                }
                return true;
            }

            function sendInfo() {

                document.forms[0].handle_id.value = document.accCreatForm.productCode.value;
                document.forms[0].action = "DynamicInttCategory.jsp";
                document.forms[0].submit();

            }

            function ShowParent()
            {
                document.forms[0].action = "accountCreation.jsp";
                document.forms[0].submit();
            }


            function popup_CIF(width, height, cifNumber) {
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
                var screenName = "accountCreation.jsp";
                var  lovKey="CifDetails"
                popWin = open('CommonSearchInformationLOV.jsp?cifNumber=' + cifNumber + '&screenName=' + screenName+'&lovKey='+lovKey, 'CifDetails', attr);
                popWin.focus();

            }
           function popup_productCode(width, height, productCodeDetails) {
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
                var screenName = "accountCreation.jsp";
                var  lovKey="productCodeSearch"
                popWin = open('CommonSearchInformationLOV.jsp?productCodeDetails=' + productCodeDetails + '&screenName=' + screenName+'&lovKey='+lovKey, 'productCodeSearch', attr);
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

        <jsp:include page="MenuHead.jsp" flush="true" />    
        <br>

        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>
        
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">ACCOUNT CREATION</legend>
        
        <form name="accCreatForm" method="post" onsubmit="return checkDiv(this)" action="AccountCreationServlet">

            <%if (!error_msg.equalsIgnoreCase("")) {%>
            <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>          
            <% }%>
            <br>

            <div id="create" align="left">

                <table>
                    <tr><td><hr></td></tr>
                    <tr><td><h3>Account Information :</h3></td></tr>
                    <tr>
                        <td><lable>Product Code :</lable></td>
                <td><input type="text" id="productCodeDetails" name="productCodeDetails" readonly></td>
                    <td><input type="button" name="productCodeSearch" id="productCodeSearch" value="Search" onclick="javascript:popup_productCode(220, 180, document.accCreatForm.productCodeDetails.value);"/></td> 

                    </tr>
                    <tr>
                        <td><lable>Intt Category :</lable></td>
                    <td><input type="text" id="inttCatDetails" name="inttCatDetails" readonly="true"></td>   
                    </tr> 

                    <tr>
                        <td><lable>Segment Code :</lable></td>
                    <td>
                        <select id="segmentCode" name="segmentCode">
                            <option value="" disabled selected style="display:none;">--Select--</option>
                            <option value="0706">0706:INDIVIDUAL</option>
                            <option value="0306">0306:STAFF</option>
                            <option value="5003">5003:SENIOR CITIZEN</option>
                            <option value="5010">5010:SHG</option>
                            <option value="5000">5000:BANKS</option>
                            <option value="5009">5009:INSTITUTIONS</option>
                            <option value="5050">5050:OTHERS</option>
                            <option value="5007">5007:SOCIETY</option>
                            <option value="5011">5011:GOV/SEMI GOV</option>
                            <option value="5012">5012:PACS</option>
                            <option value="5013">5013:UCB</option>
                            <option value="5014">5014:SCB</option>
                            <option value="5015">5015:CCB</option>
                        </select>
                    </td>
                    </tr>
                    <tr>
                        <td><lable>CIF Number :</lable></td>
                    <td><input type="text" id="cifNumber" name="cifNumber"></td>
                    <td><input type="button" name="cifNumberSearch" id="cifNumberSearch" value="Search" onclick="javascript:popup_CIF(220, 180, document.accCreatForm.cifNumber.value);"/></td>
                    </tr>
                    <tr>
                        <td><lable>Linked CBS Savings Account :</lable></td>
            <td><input type="text" id="cbsSavingsAccount" name="cbsSavingsAccount" readonly="true"></td>                        
                    </tr>

                    <tr><td><hr></td></tr>
                    <tr><td><h3>Limit Information</h3></td></tr>

                    <tr>
                        <td><lable>Limit :</lable></td>
                    <td><input type="text" id="limit" name="limit"></td>                        
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
                        <select id="activityCode" name="activityCode">
                            <option value="" disabled selected style="display:none;">--Select--</option>
                            <option value="1">Direct Agriculture</option>
                            <option value="2">Indirect Agriculture</option>
                            <option value="3">Agricultural Service Units</option>
                            <option value="4">Farm Irrigation</option>
                            <option value="5">Fruits & Vegetables</option>
                        </select>
                    </td>
                    </tr>                
                    <tr>
                        <td><lable>Customer Type :</lable></td>
                    <td>
                        <select id="customerType" name="customerType">
                            <option value="" disabled selected style="display:none;">--Select--</option>
                            <option value="I">Individual</option>
                            <option value="C">Corporate</option>
                        </select>
                    </td>
                    </tr>

                </table>
                <center>
                    <input type="button" value="Submit" onclick="javascript:submitform(accCreatForm)">
                    <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                </center>
                <tr><td><br></td></tr>
                <tr><td><br></td></tr>
                <label style=" font-family: Berlin Sans FB; font-weight:normal; ">All fields are mandatory</label>
            </div>
            <input type="hidden" name="handle_id" value="" />
            <input type="hidden" name="productCode" value="" />
            <input type="hidden" name="inttCategory" value="" />
        </form>
            </fieldset>
    </body>
</html>
