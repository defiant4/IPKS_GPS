<%-- 
    Document   : memberEnrollment
    Created on : Apr 22, 2016, 8:00:44 PM
    Author     : 590685
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DataEntryBean.memberEnrollmentBean"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />


        <title>Member Details Enrollment</title>

    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function submitform(memberEnrollForm)
            {
                 
                if (checkCreateDiv(memberEnrollForm))
                {
                   
                    document.forms[0].handle_id.value = "Create";
                    document.forms[0].action='/PacsApplication/MemberEnrollmentServlet';
                    document.forms[0].submit();
                }

            }
            function checkCreateDiv(memberEnrollForm)
            {
                
                if (memberEnrollForm.custName.value == "")
                {
                    alert("!! Customer Name field must be filled !!");
                    memberEnrollForm.custName.focus();
                    return false;
                }
                if (memberEnrollForm.memberId.value == "")
                {
                    alert("!!CISF Number field must be filled !!");
                    memberEnrollForm.memberId.focus();
                    return false;
                }
                if (memberEnrollForm.district.value == "")
                {
                    alert("!! District field must be filled !!");
                    memberEnrollForm.district.focus();
                    return false;
                }

                if (memberEnrollForm.dateOfBirth.value == "")
                {
                    alert("!! District field must be filled !!");
                    memberEnrollForm.dateOfBirth.focus();
                    return false;
                }
                
                if (memberEnrollForm.guardianName.value == "")
                {
                    alert("!! Name field must be filled !!");
                    memberEnrollForm.guardianName.focus();
                    return false;
                }
                
                if (memberEnrollForm.addr.value == "")
                {
                    alert("!! Address field must be filled !!");
                    memberEnrollForm.addr.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(memberEnrollForm.folioNumber.value))
                {
                    alert("!! Folio Number could only contain numbers !!");
                    memberEnrollForm.folioNumber.focus();
                    return false;
                }

                return true;
            }
            function updateform(memberEnrollForm)
            {
                if (checkUpdateDiv(memberEnrollForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    document.forms[0].action='/PacsApplication/MemberEnrollmentServlet';
                    memberEnrollForm.submit();

                }
            }


            function checkUpdateDiv(memberEnrollForm)
            {

                                
                if (memberEnrollForm.districtAmend.value == "")
                {
                    alert("!! District field must be filled !!");
                    memberEnrollForm.districtAmend.focus();
                    return false;
                }
                
                if (memberEnrollForm.guardianNameAmend.value == "")
                {
                    alert("!! Guardian's Name must be filled !!");
                    memberEnrollForm.guardianNameAmend.focus();
                    return false;
                }
               
                if (memberEnrollForm.addrAmend.value == "")
                {
                    alert("!! Address fields must be filled !!");
                    memberEnrollForm.addrAmend.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(memberEnrollForm.folioNumberAmend.value))
                {
                    alert("!! Folio Number could only contain numbers !!");
                    memberEnrollForm.folioNumberAmend.focus();
                    return false;
                }

                return true;
                
            }
            //LOV
            function popup_CIF(width, height, cifNumber,cifName) {
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
                var screenName = "memberEnrollment.jsp";
                var  lovKey="memberDetails"
                popWin = open('CommonSearchInformationLOV.jsp?cifNumber=' + cifNumber + '&cifName=' + cifName +'&screenName=' + screenName+'&lovKey='+lovKey, 'memberDetails', attr);
                popWin.focus();

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
                    document.getElementById('active').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';


                }


            }

            
            function searchMember() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/MemberEnrollmentServlet';
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

        <%
                    String displayFlag = "";
                    Object display = request.getAttribute("displayFlag");
                    if (display != null) {
                        displayFlag = display.toString();
                    }
        %>

        <%
                    Object memberEnrollmentBeanObj = request.getAttribute("omemberEnrollmentBean");
                    memberEnrollmentBean OmemberEnrollmentBean = new memberEnrollmentBean();
                    if (memberEnrollmentBeanObj != null) {
                        OmemberEnrollmentBean = (memberEnrollmentBean) request.getAttribute("omemberEnrollmentBean");

                    }
        %>


        <jsp:include page="MenuHead_PDS.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>



        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg');  border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">MEMBER ENROLLMENT</legend>
            <form name="memberEnrollForm" method="post" action="MemberEnrollmentServlet" >

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                <% }%>
                <br>
                <br>

                <center><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</label>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" >--select--</option>
                        <option value="create" >Create</option>
                        <option value="amend" >Amend</option>

                    </select>
                </center>
                <br>
                <br>

                <div id="create" style="display: none;">


                    <table>

                        <tr>
                            <td>Member ID: </td>
                            <td><input type="text" name="memberId" id="memberId"/><input type="button"  value="Search" onclick="javascript:popup_CIF(220, 180, document.memberEnrollForm.memberId.value,document.memberEnrollForm.custName.value);" /></td>
                        </tr>
                        <tr>
                            <td>Card Holder Name: </td>
                            <td> <input type="text" name="custName" id="custName"/><input type="button"  value="Search" onclick="javascript:popup_CIF(220, 180, document.memberEnrollForm.memberId.value,document.memberEnrollForm.custName.value)" /></td>
                        </tr>

                        <tr>
                            <td>Folio Number:</td>
                            <td><input type="text" name="folioNumber" id="folioNumber" value="" /></td>
                        </tr>

                        <tr>
                            <td>Father's Name/Husband's Name:</td>
                            <td><input type="text" name="guardianName" id="guardianName"  value="" /></td>
                        </tr>
                        <tr>
                            <td>Date of Birth:</td>
                            <td><input type="text" name="dateOfBirth" id="dateOfBirth"  value=""><a href="#" onclick="return getCalendar(document.forms[0].dateOfBirth);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td><textarea type="text"  name="addr" id="addr"  value="" ></textarea></td>
                        </tr>

                        <tr>
                            <td>District:</td>
                            <td><input type="text" name="district" id="district"  value="" /></td>
                        </tr>
                    </table>
                    <br><br>
                    <table>
                        <tr><td><br></td></tr>
                        <tr><td><br></td></tr>
                        <label style=" font-family: Berlin Sans FB; font-weight:normal; ">All fields are mandatory</label>
                        </tbody>
                    </table>

                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(memberEnrollForm)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                </div>


                <div id="amend" style="display: none;">
                    <center>
                        <table>
                            <tr>
                                <td>Name: </td>
                                <td> <input type="text" name="custNameAmend" id="custNameAmend" value="<%=blankNull(OmemberEnrollmentBean.getCustName())%>"/></td>
                                <td><input type="button"  value="Search" onclick="javascript:popup_CIF(220, 180,document.memberEnrollForm.memberIdAmend.value, document.memberEnrollForm.custNameAmend.value)" /></td>
                            </tr>
                            <tr>
                                <td>Member ID: </td>
                                <td><input type="text" name="memberIdAmend" id="memberIdAmend" value="<%=blankNull(OmemberEnrollmentBean.getMemberId())%>"/></td>

                                <td><input type="button"  value="Search" onclick="javascript:popup_CIF(220, 180, document.memberEnrollForm.memberIdAmend.value, document.memberEnrollForm.custNameAmend.value);" /></td>
                            </tr>
                        </table>
                        <br>
                        <input type="button"  value="Submit" onclick="javascript:searchMember()" />
                    </center><br>
                </div>

                <%if (displayFlag.equalsIgnoreCase("Y")) {%>

                <div id="amend2" >

                    <table>
                        <tr>
                            <td>Member ID: </td>
                            <td><input type="text" name="memberIdAmend" id="memberIdAmend" value="<%=blankNull(OmemberEnrollmentBean.getMemberId())%>"/></td>


                        </tr>
                        <tr>
                            <td>Card Holder Name: </td>
                            <td> <input type="text" name="custNameAmend" id="custNameAmend" value="<%=blankNull(OmemberEnrollmentBean.getCustName())%>"/></td>

                        </tr>

                        <tr>
                            <td>Folio Number:</td>
                            <td><input type="text" name="folioNumberAmend" id="folioNumberAmend" value="<%=blankNull(OmemberEnrollmentBean.getFolioNumber())%>" /></td>
                        </tr>

                        <tr>
                            <td>Father's Name/Husband's Name:</td>
                            <td><input type="text" name="guardianNameAmend" id="guardianNameAmend"  value="<%=blankNull(OmemberEnrollmentBean.getGuardianName())%>" /></td>
                        </tr>

                        <tr>
                            <td>Date of Birth:</td>
                            <td><input type="text" name="dateOfBirthAmend" id="dateOfBirthAmend"  value="<%=blankNull(OmemberEnrollmentBean.getDateOfBirth())%>"><a href="#" onclick="return getCalendar(document.forms[0].dateOfBirthAmend);"><img src="img/calendar.gif" name="imgr" border="0" width="15" height="20" /></td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td><textarea type="text"  name="addrAmend" id="addrAmend" ><%=blankNull(OmemberEnrollmentBean.getAddr())%></textarea></td>
                        </tr>

                        <tr>
                            <td>District:</td>
                            <td><input type="text" name="districtAmend" id="districtAmend"  value="<%=blankNull(OmemberEnrollmentBean.getDistrict())%>" /></td>
                        </tr>

                    </table>
                        <br>
                    <table>
                        <tr><td><label>All Fields are mandatory</label></td></tr>
                        </tbody>
                    </table>

                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(memberEnrollForm)">
                        <input type="reset" value="Reset" name="reset" />

                    </center>

                </div>
                <%}%>

                <input type="hidden" name="handle_id" value="" />
            </form>
        </fieldset>
    </body>
</html>
