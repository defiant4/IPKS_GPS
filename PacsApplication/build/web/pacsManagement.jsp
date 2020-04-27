
<%-- 
    Document   : PACS
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>

<%@page import="DataEntryBean.PacsManagementBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>

        <title>PACS Management</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }
            
            function submitform(pacsForm)
            {
                if (checkCreateDiv(pacsForm))
                {
                    document.forms[0].handle_id.value = "Create";
                    pacsForm.submit();
                }
            }
            
            function updateform(pacsForm)
            { 
                if (checkUpdateDiv(pacsForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    pacsForm.submit();

                }
            }
            
            
            function checkCreateDiv(pacsForm)
            {
                if (pacsForm.pacsName.value == "")
                {
                    alert("!! Value must be selected !!");
                    pacsForm.pacsName.focus();
                    return false;
                }
                if (pacsForm.pacsCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.pacsCode.focus();
                    return false;
                }
                if (pacsForm.dccb.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.dccb.focus();
                    return false;
                }
                if (pacsForm.cbsBranchCode.value == "")
                {
                    alert("!! Value must be selected !!");
                    pacsForm.cbsBranchCode.focus();
                    return false;
                }
                if (pacsForm.addressLine1.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.addressLine1.focus();
                    return false;
                }
                if (pacsForm.addressLine2.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.addressLine2.focus();
                    return false;
                }
                if (pacsForm.addressLine3.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.addressLine3.focus();
                    return false;
                }
                if (pacsForm.districtCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.districtCode.focus();
                    return false;
                }
                if (pacsForm.liveFlag.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.liveFlag.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.pacsCode.value))
                {
                    alert("!! PacsCode could only contain numbers !!");
                    pacsForm.pacsCode.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.cbsBranchCode.value))
                {
                    alert("!! CBSBranchCode Category could only contain numbers !!");
                    pacsForm.cbsBranchCode.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.cmnPrkBglNo.value))
                {
                    alert("!! Common Parking BGL No. could only contain numbers !!");
                    pacsForm.cmnPrkBglNo.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.pacsConsAccNo.value))
                {
                    alert("!! PACS Consolidated Account No. could only contain numbers !!");
                    pacsForm.pacsConsAccNo.focus();
                    return false;
                }
                return true;
            }
            function checkUpdateDiv(pacsForm)
            {
                if (pacsForm.pacsNameAmend.value == "")
                {
                    alert("!! Value must be selected !!");
                    pacsForm.pacsNameAmend.focus();
                    return false;
                }
                if (pacsForm.dccbAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.dccbAmend.focus();
                    return false;
                }
                if (pacsForm.cbsBranchCodeAmend.value == "")
                {
                    alert("!! Value must be selected !!");
                    pacsForm.cbsBranchCodeAmend.focus();
                    return false;
                }
                if (pacsForm.addressLine1Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.addressLine1Amend.focus();
                    return false;
                }
                if (pacsForm.addressLine2Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.addressLine2Amend.focus();
                    return false;
                }
                if (pacsForm.addressLine3Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.addressLine3Amend.focus();
                    return false;
                }
                if (pacsForm.districtCodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.districtCodeAmend.focus();
                    return false;
                }
                if (pacsForm.liveFlagAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsForm.liveFlagAmend.focus();
                    return false;
                }
                
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.pacsCodeAmend.value))
                {
                    alert("!! PacsCode could only contain numbers !!");
                    pacsForm.pacsCodeAmend.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.cbsBranchCodeAmend.value))
                {
                    alert("!! CBS BranchCode Category could only contain numbers !!");
                    pacsForm.cbsBranchCodeAmend.focus();
                    return false;
                }
                
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.cmnPrkBglNoAmend.value))
                {
                    alert("!! Common Parking BGL No. could only contain numbers !!");
                    pacsForm.cmnPrkBglNoAmend.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(pacsForm.pacsConsAccNoAmend.value))
                {
                    alert("!! PACS Consolidated Account No. could only contain numbers !!");
                    pacsForm.pacsConsAccNoAmend.focus();
                    return false;
                }
                return true;
            }
            function checkop()
            {
                if (document.getElementById("checkOption").value == "create")
                {
                    document.getElementById('create').style.display = 'block';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';

                }
                if (document.getElementById("checkOption").value == "amend")
                {
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'block';
                    document.getElementById('amend2').style.display = 'none';
                }


            }
            function searchPacs() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/PacsManagementServlet';
                document.forms[0].submit();

            }

        </script>

        <%
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>

        <%  String displayFlag = "";
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
            Object oPacsManagementBeanObj = request.getAttribute("oPacsManagementBeanObj");
            PacsManagementBean oPacsManagementBean = new PacsManagementBean();
            if (oPacsManagementBeanObj != null) {
                oPacsManagementBean = (PacsManagementBean) request.getAttribute("oPacsManagementBeanObj");

            }
        %>

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">PACS MANAGEMENT</legend>
            <form name="pacsForm" method="post" action="PacsManagementServlet"> 

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>
                <br>   
                <center>
                    <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</lable>
                    <select id="checkOption" onchange="checkop()" name="checkOption">
                        <option value="" disabled selected style="display:none;">--select--</option>
                        <option value="create">Create</option>
                        <option value="amend">Amend</option>
                    </select>
                </center>

                <div id="create" style="display:none;" > 
                    <table>
                        <tbody>
                            <tr>
                                <td>Pacs Name:</td>
                                <td><input type="text" name="pacsName" size="20" value="" /></td>
                            </tr>
                            <tr>
                                <td>Pacs Code:</td>
                                <td><input type="text" name="pacsCode" size="20" value="" /></td>
                            </tr>
                            <tr>
                                <td>DCCB: </td>
                                <td>
                                    <select id="dccb" name="dccb">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="1">Birbhum District Central Co-operative Bank</option>
                                        <option value="2">Bankura District Central Co-operative Bank</option>
                                        <option value="3">Balageria Central Co-operative Bank</option>
                                        <option value="4">Dhakshin Dinajpur District Central Co-operative Bank</option>
                                        <option value="5">Darjeeling District Central Co-operative Bank</option>
                                        <option value="6">Hooghly District Central Co-operative Bank</option>
                                        <option value="7">Howrah District Central Co-operative Bank</option>
                                        <option value="8">Jalpaiguri District Central Co-operative Bank</option>
                                        <option value="9">Murshidabad District Central Co-operative Bank</option>
                                        <option value="10">Malda District Central Co-operative Bank</option>
                                        <option value="11">Mugberia District Central Co-operative Bank</option>
                                        <option value="12">Nadia District Central Co-operative Bank</option>
                                        <option value="13">Purulia Central Co-operative Bank</option>
                                        <option value="14">Raiganj District Central Co-operative Bank</option>
                                        <option value="15">Tamluk-Ghatal Central Co-operative Bank</option>
                                        <option value="16">The West Bengal State Co-operative Bank</option>
                                        <option value="17">Vidyasagar Central Co-operative Bank</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>CBS Branch Code:</td>
                                <td><input type="text"  name="cbsBranchCode" size="20" value="" /></td>
                            </tr>
                            <tr>
                                <td>Common Parking BGL No.:</td>
                                 <td><input type="text"  name="cmnPrkBglNo" size="20" value="" /></td>
                            </tr>
                             <tr>
                                <td>PACS Consolidated Account No.:</td>
                                 <td><input type="text"  name="pacsConsAccNo" size="20" value="" /></td>
                            </tr>
                            <tr>
                                <td>Address line 1:</td>
                                <td><textarea rows="4" cols="50"  name="addressLine1" style="width: 150px"></textarea></td>
                            </tr>

                            <tr>
                                <td>Address line 2:</td>
                                <td><textarea rows="4" cols="50"  name="addressLine2" style="width: 150px"></textarea></td>
                            </tr>
                            <tr>
                                <td>Address line 3:</td>
                                <td><textarea rows="4" cols="50"  name="addressLine3" style="width: 150px"></textarea></td>
                            </tr>

                            <tr>
                                <td>District Code: </td>
                                <td>
                                    <select id="districtCode" name="districtCode">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="1">Birbhum</option>
                                        <option value="2">Bankura</option>
                                        <option value="3">Balageria</option>
                                        <option value="4">Dhakshin Dinajpur</option>
                                        <option value="5">Darjeeling </option>
                                        <option value="6">Hooghly</option>
                                        <option value="7">Howrah</option>
                                        <option value="8">Jalpaiguri</option>
                                        <option value="9">Murshidabad</option>
                                        <option value="10">Malda</option>
                                        <option value="11">Mugberia</option>
                                        <option value="12">Nadia</option>
                                        <option value="13">Purulia</option>
                                        <option value="14">Raiganj</option>
                                        <option value="15">Tamluk-Ghatal</option>
                                        <option value="16">Kolkata/24 Parganas</option>
                                        <option value="17">Vidyasagar</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Live Flag:</td>
                                <td><select id="liveFlag" name="liveFlag">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                </td>
                            </tr>
                        </tbody>
                    </table><br><br>

                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(pacsForm)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                </div>
                <br>
                <div id="amend" style="display: none;">
                    <center>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Enter PACS Code: </lable>
                        <input type="text" name="pacsCodeSearch"/>
                        <input type="button"  value="Search" onclick="javascript:searchPacs()" />
                    </center><br><br>
                </div>
                <%if (displayFlag.equalsIgnoreCase("Y")) {%>

                <div id="amend2" >
                    <table>
                        <tbody>
                            <tr>
                                <td>Pacs Name:</td>
                                <td><input type="text" name="pacsNameAmend" value="<%=blankNull(oPacsManagementBean.getPacsName())%>" /></td>
                            </tr>
                            <tr>
                                <td>Pacs Code:</td>
                                <td><input readonly type="text" name="pacsCodeAmend" style="width: 200px" value="<%=blankNull(oPacsManagementBean.getPacsCode())%>" /></td>
                            </tr>
                            <tr>
                                <td>DCCB: </td>
                                <td>
                                    <select id="dccbAmend" name="dccbAmend" >                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="1" <%if (oPacsManagementBean.getDccb().equals("1")) {%> selected <%}%>>Birbhum District Central Co-operative Bank</option>
                                        <option value="2" <%if (oPacsManagementBean.getDccb().equals("2")) {%> selected <%}%>>Bankura District Central Co-operative Bank</option>
                                        <option value="3" <%if (oPacsManagementBean.getDccb().equals("3")) {%> selected <%}%>>Balageria Central Co-operative Bank</option>
                                        <option value="4" <%if (oPacsManagementBean.getDccb().equals("4")) {%> selected <%}%>>Dhakshin Dinajpur District Central Co-operative Bank</option>
                                        <option value="5" <%if (oPacsManagementBean.getDccb().equals("5")) {%> selected <%}%>>Darjeeling District Central Co-operative Bank</option>
                                        <option value="6" <%if (oPacsManagementBean.getDccb().equals("6")) {%> selected <%}%>>Hooghly District Central Co-operative Bank</option>
                                        <option value="7" <%if (oPacsManagementBean.getDccb().equals("7")) {%> selected <%}%>>Howrah District Central Co-operative Bank</option>
                                        <option value="8" <%if (oPacsManagementBean.getDccb().equals("8")) {%> selected <%}%>>Jalpaiguri District Central Co-operative Bank</option>
                                        <option value="9" <%if (oPacsManagementBean.getDccb().equals("9")) {%> selected <%}%>>Murshidabad District Central Co-operative Bank</option>
                                        <option value="10" <%if (oPacsManagementBean.getDccb().equals("10")) {%> selected <%}%>>Malda District Central Co-operative Bank</option>
                                        <option value="11" <%if (oPacsManagementBean.getDccb().equals("11")) {%> selected <%}%>>Mugberia District Central Co-operative Bank</option>
                                        <option value="12" <%if (oPacsManagementBean.getDccb().equals("12")) {%> selected <%}%>>Nadia District Central Co-operative Bank</option>
                                        <option value="13" <%if (oPacsManagementBean.getDccb().equals("13")) {%> selected <%}%>>Purulia Central Co-operative Bank</option>
                                        <option value="14" <%if (oPacsManagementBean.getDccb().equals("14")) {%> selected <%}%>>Raiganj District Central Co-operative Bank</option>
                                        <option value="15" <%if (oPacsManagementBean.getDccb().equals("15")) {%> selected <%}%>>Tamluk-Ghatal Central Co-operative Bank</option>
                                        <option value="16" <%if (oPacsManagementBean.getDccb().equals("16")) {%> selected <%}%>>The West Bengal State Co-operative Bank</option>
                                        <option value="17" <%if (oPacsManagementBean.getDccb().equals("17")) {%> selected <%}%>>Vidyasagar Central Co-operative Bank</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>CBS Branch Code:</td>
                                <td><input readonly type="text"  name="cbsBranchCodeAmend" style="width: 150px" value="<%=blankNull(oPacsManagementBean.getCbsBranchCode())%>" /></td>
                            </tr>
                            <tr>
                                <td>Common Parking BGL No.:</td>
                                 <td><input type="text"  name="cmnPrkBglNoAmend" size="20" value="<%=blankNull(oPacsManagementBean.getCmnPrkBglNo())%>" /></td>
                            </tr>
                             <tr>
                                <td>PACS Consolidated Account No.:</td>
                                 <td><input type="text"  name="pacsConsAccNoAmend" size="20" value="<%=blankNull(oPacsManagementBean.getPacsConsAccNo())%>" /></td>
                            </tr>
                            <tr>
                                <td>Address line 1:</td>
                                <td><textarea rows="4" cols="50"  name="addressLine1Amend" style="width: 150px" ><%=blankNull(oPacsManagementBean.getAddressLine1())%></textarea></td>
                            </tr>

                            <tr>
                                <td>Address line 2:</td>
                                <td><textarea rows="4" cols="50"  name="addressLine2Amend" style="width: 150px"><%=blankNull(oPacsManagementBean.getAddressLine2())%></textarea></td>
                            </tr>
                            <tr>
                                <td>Address line 3:</td>
                                <td><textarea rows="4" cols="50"  name="addressLine3Amend" style="width: 150px" ><%=blankNull(oPacsManagementBean.getAddressLine3())%></textarea></td>
                            </tr>

                            <tr>
                                <td>District Code: </td>
                                <td>
                                    <select id="districtCodeAmend" name="districtCodeAmend" >                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="1" <%if (oPacsManagementBean.getDistrictCode().equals("1")) {%> selected <%}%>>Birbhum</option>
                                        <option value="2" <%if (oPacsManagementBean.getDistrictCode().equals("2")) {%> selected <%}%>>Bankura</option>
                                        <option value="3" <%if (oPacsManagementBean.getDistrictCode().equals("3")) {%> selected <%}%>>Balageria</option>
                                        <option value="4" <%if (oPacsManagementBean.getDistrictCode().equals("4")) {%> selected <%}%>>Dhakshin Dinajpur</option>
                                        <option value="5" <%if (oPacsManagementBean.getDistrictCode().equals("5")) {%> selected <%}%>>Darjeeling </option>
                                        <option value="6" <%if (oPacsManagementBean.getDistrictCode().equals("6")) {%> selected <%}%>>Hooghly</option>
                                        <option value="7" <%if (oPacsManagementBean.getDistrictCode().equals("7")) {%> selected <%}%>>Howrah</option>
                                        <option value="8" <%if (oPacsManagementBean.getDistrictCode().equals("8")) {%> selected <%}%>>Jalpaiguri</option>
                                        <option value="9" <%if (oPacsManagementBean.getDistrictCode().equals("9")) {%> selected <%}%>>Murshidabad</option>
                                        <option value="10" <%if (oPacsManagementBean.getDistrictCode().equals("10")) {%> selected <%}%>>Malda</option>
                                        <option value="11" <%if (oPacsManagementBean.getDistrictCode().equals("11")) {%> selected <%}%>>Mugberia</option>
                                        <option value="12" <%if (oPacsManagementBean.getDistrictCode().equals("12")) {%> selected <%}%>>Nadia</option>
                                        <option value="13" <%if (oPacsManagementBean.getDistrictCode().equals("13")) {%> selected <%}%>>Purulia</option>
                                        <option value="14" <%if (oPacsManagementBean.getDistrictCode().equals("14")) {%> selected <%}%>>Raiganj</option>
                                        <option value="15" <%if (oPacsManagementBean.getDistrictCode().equals("15")) {%> selected <%}%>>Tamluk-Ghatal</option>
                                        <option value="16" <%if (oPacsManagementBean.getDistrictCode().equals("16")) {%> selected <%}%>>Kolkata/24 Parganas</option>
                                        <option value="17" <%if (oPacsManagementBean.getDistrictCode().equals("17")) {%> selected <%}%>>Vidyasagar</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Live Flag:</td>
                                <td><select id="liveFlagAmend" name="liveFlagAmend">                
                                        <option value="" disabled selected style="display:none;" >--Select--</option>
                                        <option value="Y" <%if (oPacsManagementBean.getLiveFlag().equals("Y")) {%> selected <%}%>>Yes</option>
                                        <option value="N" <%if (oPacsManagementBean.getLiveFlag().equals("N")) {%> selected <%}%>>No</option>
                                </td>
                            </tr>
                        </tbody>
                    </table><br><br>

                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(pacsForm)">
                    </center>

                </div>
                <%}%>                         

                <input type="hidden" name="handle_id" value="" />
            </form>
        </fieldset>
    </body>
</html>


