<%-- 
    Document   : userMaintainance
    Created on : Mar 14, 2016, 1:04:38 PM
    Author     : Kaushik
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DataEntryBean.UserMaintainanceBean"%>

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
            function submitform(userMaintainanceForm)
            {
                //if (checkCreateDiv(userMaintainanceForm))
                //{
                document.forms[0].handle_id.value = "Create";
                userMaintainanceForm.submit();
                //}

            }
            function checkop()
            {
                if (document.getElementById("checkOption").value == "create")
                {
                    document.getElementById('create').style.display = 'block';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('ResetPassword').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';
                }
                if (document.getElementById("checkOption").value == "update")
                {

                    document.getElementById('amend').style.display = 'block';
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('ResetPassword').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';
                }
                if (document.getElementById("checkOption").value == "ResetPassword")
                {
                    document.getElementById('ResetPassword').style.display = 'block';
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';
                }
            }
            function updateform(userMaintainanceForm)
            {
                //if (checkUpdateDiv(userMaintainanceForm))
                //{
                document.forms[0].handle_id.value = "Update";
                userMaintainanceForm.submit();

                //}
            }
            function resetpasswordform(userMaintainanceForm)
            {
                //if (checkResetPasswordDiv(userMaintainanceForm))
                //{
                
                if(document.forms[0].tellerIdReset.value=="")
                {
                    alert("Please Enter Teller Id")
                    userMaintainanceForm.tellerIdReset.focus();
                    return false;
                }
                
                document.forms[0].handle_id.value = "ResetPassword";
                userMaintainanceForm.submit();

                //}
            }


            function searchTeller() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/UserMaintenanceServlet';
                document.forms[0].submit();

            }

            function ShowParent()
            {
                document.forms[0].action = "userMaintenance.jsp";
                document.forms[0].submit();
            }

            function popup_pacs(width, height, DccbSearch, lovKey) {

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

                popWin = open('PacsInformationLOV.jsp?DccbCode=' + DccbSearch + '&lovKey=' + lovKey, 'PacsInformation', attr);
                popWin.focus();

            }


            function disabledccb()
            {
                var x = document.getElementById("userType").selectedIndex;
                var y = document.getElementById("userType").options;
                if ((y[x].index) == 3 || (y[x].index) == 1)
                {
                    document.getElementById("dccbCode").selectedIndex = "0";
                    document.getElementById("dccbCode").disabled = true;
                    document.getElementById("pacsName").value = "99999:GLOBAL";
                    document.getElementById("pacsName").disabled = true;
                }
                else
                {
                    document.getElementById("dccbCode").disabled = false;
                    document.getElementById("pacsName").disabled = false;
                    document.getElementById("pacsName").value = "";
                }
            }
            function disabledccbamend()
            {
                var x = document.getElementById("userTypeAmend").selectedIndex;
                var y = document.getElementById("userTypeAmend").options;
                if ((y[x].index) == 3 || (y[x].index) == 1)
                {
                    document.getElementById("dccbCodeAmend").selectedIndex = "0";
                    document.getElementById("dccbCodeAmend").disabled = true;
                    document.getElementById("pacsNameAmend").value = "99999:GLOBAL";
                    document.getElementById("pacsNameAmend").disabled = true;
                }
                else
                {
                    document.getElementById("dccbCodeAmend").disabled = false;
                    document.getElementById("pacsIdAmend").disabled = false;
                    document.getElementById("pacsIdAmend").value = "";
                }
            }

        </script>


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

        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>

        <%
            Object oUserMaintainanceBeanObj = request.getAttribute("oUserMaintainanceBeanObj");
            UserMaintainanceBean oUserMaintainanceBean = new UserMaintainanceBean();
            String PacsDetails = "";
            String checkOption = "";
            String dccbCode = "";
            if (oUserMaintainanceBeanObj != null) {
                oUserMaintainanceBean = (UserMaintainanceBean) request.getAttribute("oUserMaintainanceBeanObj");
                checkOption = oUserMaintainanceBean.getCheckOption();

            }
        %>


        <jsp:include page="MenuHead.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">USER MAINTENANCE</legend>
            <form name="userMaintainanceForm" method="post" action="UserMaintenanceServlet"> 

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>

                <center><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</label>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" <%if (checkOption.equalsIgnoreCase("")) {%> selected <%}%> >--select--</option>
                        <option value="create" <%if (checkOption.equalsIgnoreCase("create")) {%> selected <%}%> >Create</option>
                        <option value="update" <%if (checkOption.equalsIgnoreCase("update")) {%> selected <%}%>>Update</option>
                        <option value="ResetPassword" <%if (checkOption.equalsIgnoreCase("ResetPassword")) {%> selected <%}%> >Reset Password </option>
                    </select>
                </center>
                <br>

                <div id="create" style="display: none">
                    <table>
                        <tbody>


                            <tr>
                                <td>User Type:</td>
                                <td><select id="userType" name="userType" onchange="disabledccb()">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="AU">Admin</option>
                                        <option value="PU">PACS User</option>
                                        <option value="EODU">EOD User</option>
                                    </select>
                                </td>
                            </tr>



                            <tr>
                                <td>DCCB Code:</td>
                                <td> <select id="dccbCode" name="dccbCode" >                
                                        <option value="" disabled selected style="display:none;" >--Select--</option>
                                        <option value="1">1:Birbhum District Central Co-operative Bank</option>
                                        <option value="2">2:Bankura District Central Co-operative Bank</option>
                                        <option value="3">3:Balageria Central Co-operative Bank</option>
                                        <option value="4">4:Dhakshin Dinajpur District Central Co-operative Bank</option>
                                        <option value="5">5:Darjeeling District Central Co-operative Bank</option>
                                        <option value="6">6:Hooghly District Central Co-operative Bank</option>
                                        <option value="7">7:Howrah District Central Co-operative Bank</option>
                                        <option value="8">8:Jalpaiguri District Central Co-operative Bank</option>
                                        <option value="9">9:Murshidabad District Central Co-operative Bank</option>
                                        <option value="10">10:Malda District Central Co-operative Bank</option>
                                        <option value="11">11:Mugberia District Central Co-operative Bank</option>
                                        <option value="12">12:Nadia District Central Co-operative Bank</option>
                                        <option value="13">13:Purulia Central Co-operative Bank</option>
                                        <option value="14">14:Raiganj District Central Co-operative Bank</option>
                                        <option value="15">15:Tamluk-Ghatal Central Co-operative Bank</option>
                                        <option value="16">16:The West Bengal State Co-operative Bank</option>
                                        <option value="17">17:Vidyasagar Central Co-operative Bank</option>
                                    </select></td>
                            </tr>
                            <tr>
                                <td>PACS ID:</td>
                                <td> <input type="text" id="pacsName" name="pacsName">&nbsp;&nbsp;&nbsp;<input type="button" name="pacsIdSearch" id="pacsIdSearch" value="Search" onclick="javascript:popup_pacs(220, 180, document.getElementById('dccbCode').value, document.getElementById('checkOption').value);"/></td>
                            </tr>
                            <tr>
                                <td>Teller ID:</td>
                                <td><input type="text" name="tellerId" size="15" value="" /></td>
                            </tr>
                            <tr>
                                <td>Teller Name:</td>
                                <td><input type="text"  name="tellerName" value="" size="10" /></td>
                            </tr>

                            <tr>
                                <td>Mobile Number:</td>
                                <td><input type="text" name="mobileNumber" maxlength="10" minlength="10"  /></td>
                            </tr>
                            <tr>
                                <td>User Status:</td>
                                <td>
                                    <select id="userStatus" name="userStatus">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="A">Active</option>
                                        <option value="I">Inactive</option>
                                    </select>
                                </td>

                            </tr>
                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            <tr><td><label>All fields are mandatory</label></td></tr>
                        </tbody>
                    </table><br><br>

                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(userMaintainanceForm)">
                        <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                    </center>
                </div>


                <div id="amend" style="display: none;">
                    <center>
                        <label style=" font-family: Berlin Sans FB; font-weight:normal; ">Enter Teller Id: </label>
                        <input type="text" name="tellerIdSearch"/>
                        <input type="button"  value="Search" onclick="javascript:searchTeller()" />
                    </center><br>
                </div>
                <%if (displayFlag.equalsIgnoreCase("Y")) {%>
                <div id="amend2" >

                    <table>
                        <tbody>

                            <tr>
                                <td>User Type:</td>
                                <td><select id="userTypeAmend" name="userTypeAmend" onchange="disabledccbamend()">                
                                        <option value="" disabled selected style="display:none;" <%if (oUserMaintainanceBean.getUserType().equalsIgnoreCase("")) {%> selected <%}%>>--Select--</option>
                                        <option value="AU" <%if (oUserMaintainanceBean.getUserType().equalsIgnoreCase("AU")) {%> selected <%}%>>Admin</option>
                                        <option value="PU" <%if (oUserMaintainanceBean.getUserType().equalsIgnoreCase("PU")) {%> selected <%}%>>PACS User</option>
                                        <option value="EODU" <%if (oUserMaintainanceBean.getUserType().equalsIgnoreCase("EODU")) {%> selected <%}%>>EOD User</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td>DCCB Code:</td>
                                <td> <select id="dccbCodeAmend" name="dccbCodeAmend" <%if ((oUserMaintainanceBean.getUserType().equalsIgnoreCase("EODU")) || (oUserMaintainanceBean.getUserType().equalsIgnoreCase("AU"))) {%>disabled<%}%>>                  
                                        <option value="" disabled selected style="display:none;"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("")) {%> selected <%}%>>--Select--</option>
                                        <option value="1"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("1")) {%> selected <%}%>>Birbhum District Central Co-operative Bank</option>
                                        <option value="2"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("2")) {%> selected <%}%>>Bankura District Central Co-operative Bank</option>
                                        <option value="3"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("3")) {%> selected <%}%>>Balageria Central Co-operative Bank</option>
                                        <option value="4" <%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("4")) {%> selected <%}%>>Dhakshin Dinajpur District Central Co-operative Bank</option>
                                        <option value="5"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("5")) {%> selected <%}%>>Darjeeling District Central Co-operative Bank</option>
                                        <option value="6"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("6")) {%> selected <%}%>>Hooghly District Central Co-operative Bank</option>
                                        <option value="7"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("7")) {%> selected <%}%>>Howrah District Central Co-operative Bank</option>
                                        <option value="8"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("8")) {%> selected <%}%>>Jalpaiguri District Central Co-operative Bank</option>
                                        <option value="9"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("9")) {%> selected <%}%>>Murshidabad District Central Co-operative Bank</option>
                                        <option value="10"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("10")) {%> selected <%}%>>Malda District Central Co-operative Bank</option>
                                        <option value="11"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("11")) {%> selected <%}%>>Mugberia District Central Co-operative Bank</option>
                                        <option value="12"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("12")) {%> selected <%}%>>Nadia District Central Co-operative Bank</option>
                                        <option value="13"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("13")) {%> selected <%}%>>Purulia Central Co-operative Bank</option>
                                        <option value="14"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("14")) {%> selected <%}%>>Raiganj District Central Co-operative Bank</option>
                                        <option value="15"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("15")) {%> selected <%}%>>Tamluk-Ghatal Central Co-operative Bank</option>
                                        <option value="16"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("16")) {%> selected <%}%>>The West Bengal State Co-operative Bank</option>
                                        <option value="17"<%if (oUserMaintainanceBean.getDccbCode().equalsIgnoreCase("17")) {%> selected <%}%>>Vidyasagar Central Co-operative Bank</option>
                                    </select></td>
                            </tr>
                            <tr>
                                <td>PACS ID:</td>
                                <td><input tupe="text" id="pacsIdAmend" name="pacsIdAmend" readonly value="<%=blankNull(oUserMaintainanceBean.getPacsDetails())%>" />&nbsp;&nbsp;&nbsp;<input type="button" name="pacsIdAmendSearch" id="pacsIdAmendSearch" value="Search" onclick="javascript:popup_pacs(220, 180, document.getElementById('dccbCodeAmend').value, document.getElementById('checkOption').value);"/></td>

                            </tr>

                            <tr>
                                <td>Teller Name:</td>
                                <td><input  type="text"  name="tellerNameAmend"  resize="yes"  value="<%=blankNull(oUserMaintainanceBean.getTellerName())%>" ></td>
                            </tr>

                            <tr>
                                <td>Mobile Number:</td>
                                <td><input type="text" name="mobileNumberAmend" value="<%=blankNull(oUserMaintainanceBean.getMobileNumber())%>" maxlength="10" minlength="10" /></td>
                            </tr>
                            <tr>
                                <td>User Status:</td>
                                <td>
                                    <select id="userStatusAmend" name="userStatusAmend">                
                                        <option value="" disabled selected style="display:none;" <%if (blankNull(oUserMaintainanceBean.getUserStatus()).equalsIgnoreCase("")) {%> selected <%}%>>--Select--</option>
                                        <option value="A" <%if (blankNull(oUserMaintainanceBean.getUserStatus()).equalsIgnoreCase("A")) {%> selected <%}%>>Active</option>
                                        <option value="I" <%if (blankNull(oUserMaintainanceBean.getUserStatus()).equalsIgnoreCase("I")) {%> selected <%}%>>Inactive</option>
                                    </select>
                                </td>

                            </tr>
                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                        </tbody>

                    </table>
                    <br><br>
                    <input type="hidden" name="tellerIdAmend" value="<%=blankNull(oUserMaintainanceBean.getTellerId())%>"/>
                    <input type="hidden" name="pacsIdUpdated" value="<%=blankNull(oUserMaintainanceBean.getPacsId())%>"/>
                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(userMaintainanceForm)">
                    </center>

                </div>
                <%}%>
                <div id="ResetPassword" style="display:none;">
                    <center>
                        <table>
                            <tbody>

                                <tr>
                                    <td>Enter Teller ID:</td>
                                    <td><input type="text" name="tellerIdReset"/></td>

                                    <td> &nbsp;&nbsp; &nbsp; &nbsp; <input type="button" value="ResetPassword" onclick="javascript:resetpasswordform(userMaintainanceForm)"></td>
                                </tr>
                            </tbody>
                        </table>
                    </center>
                </div>

                <input type="hidden" name="handle_id" value="" />
                <input type="hidden" name="pacsId" value="" />
            </form>
        </fieldset>    
    </body>

</html>
