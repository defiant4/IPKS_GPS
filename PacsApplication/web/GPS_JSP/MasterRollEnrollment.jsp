<%-- 
    Document   : MasterRollEnrollment
    Created on : Jul 13, 2016, 2:35:09 PM
    Author     : Tcs Help desk122
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DataEntryBean.masterRollEnrollmentBean;"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />


        <title>Muster Roll Enrollment</title>

    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function submitform(musterEnrollForm)
            {

                if (checkCreateDiv(musterEnrollForm))
                {

                    document.forms[0].handle_id.value = "Create";
                    document.forms[0].action = '/PacsApplication/MasterEnrollmentServlet';
                    document.forms[0].submit();
                }

            }
            function checkCreateDiv(musterEnrollForm)
            {

                if (musterEnrollForm.name.value === "")
                {
                    alert("!! Customer Name field must be filled !!");
                    musterEnrollForm.name.focus();
                    return false;
                }
                if (musterEnrollForm.address.value === "")
                {
                    alert("!!Address field must be filled !!");
                    musterEnrollForm.address.focus();
                    return false;
                }
                if (musterEnrollForm.contactNo.value === "")
                {
                    alert("!! Contact No is Mandatory !!");
                    musterEnrollForm.contactNo.focus();
                    return false;
                }

                if (musterEnrollForm.voter.value === "")
                {
                    alert("!! Voter Card is Mandatory !!");
                    musterEnrollForm.voter.focus();
                    return false;
                }

                if (musterEnrollForm.adhaar.value === "")
                {
                    alert("!! Adhaar Card is Mandatory !!");
                    musterEnrollForm.adhaar.focus();
                    return false;
                }

                if (musterEnrollForm.produce.value === "")
                {
                    alert("!! Details of produce must be filled !!");
                    musterEnrollForm.produce.focus();
                    return false;
                }

                return true;
            }
            function updateform(musterEnrollForm)
            {
                if (checkUpdateDiv(musterEnrollForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    document.forms[0].action = '/PacsApplication/MasterEnrollmentServlet';
                    musterEnrollForm.submit();

                }
            }


            function checkUpdateDiv(musterEnrollForm)
            {


                if (musterEnrollForm.name_Amend.value === "")
                {
                    alert("!! Customer Name field must be filled !!");
                    musterEnrollForm.name_Amend.focus();
                    return false;
                }
                if (musterEnrollForm.addrAmend.value === "")
                {
                    alert("!!Address field must be filled !!");
                    musterEnrollForm.addrAmend.focus();
                    return false;
                }
                if (musterEnrollForm.contactnoAmend.value === "")
                {
                    alert("!! Contact No is Mandatory !!");
                    musterEnrollForm.contactnoAmend.focus();
                    return false;
                }

                if (musterEnrollForm.voterAmend.value === "")
                {
                    alert("!! Voter Card is Mandatory !!");
                    musterEnrollForm.voterAmend.focus();
                    return false;
                }

                if (musterEnrollForm.adhaarAmend.value === "")
                {
                    alert("!! Adhaar Card is Mandatory !!");
                    musterEnrollForm.adhaarAmend.focus();
                    return false;
                }

                if (musterEnrollForm.produceAmend.value === "")
                {
                    alert("!! Details of produce must be filled !!");
                    musterEnrollForm.produceAmend.focus();
                    return false;
                }

                return true;

            }
            //LOV
            function popup_CIF(width, height, id, name) {
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
                var screenName = "MasterRollEnrollment.jsp";
                var lovKey = "memberDetails"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_GPS_LOV.jsp?memberId=' + id + '&memberName=' + name + '&screenName=' + screenName + '&lovKey=' + lovKey, 'memberDetails', attr);
                popWin.focus();

            }
            function checkop()
            {
                if (document.getElementById("checkOption").value === "create")
                {
                    document.getElementById('create').style.display = 'block';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';


                }
                if (document.getElementById("checkOption").value === "amend")
                {
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'block';
                    document.getElementById('active').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';


                }


            }


            function searchMember() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/MasterEnrollmentServlet';
                document.forms[0].submit();

            }
            
            function isNumber(evt){
                evt = (evt)? evt : window.event;
                var charCode = (evt.which) ? evt.which:evt.keyCode;
                if(charCode > 31 && (charCode<48 || charCode>57)){
                    return false;
                }
                return true;
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
            Object masterRollEnrollmentBeanObj = request.getAttribute("masterRollEnrollmentBeanObj");
            masterRollEnrollmentBean OmasterRollEnrollmentBean = new masterRollEnrollmentBean();
            if (masterRollEnrollmentBeanObj != null) {
                OmasterRollEnrollmentBean = (masterRollEnrollmentBean) request.getAttribute("masterRollEnrollmentBeanObj");

            }
        %>


        <jsp:include page="MenuHead_GPS.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>



        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg');  border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">Muster Roll Enrollment</legend>
            <form name="musterEnrollForm" method="post" action="MemberEnrollmentServlet" >

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
                            <td>Name: </td>
                            <td><input type="text" name="name" id="name"/></td>
                            <td></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Address:</td>
                            <td><textarea type="text"  name="address" id="address"  value="" ></textarea></td>
                            <td></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Contact No: </td>
                            <td> <input type="text" name="contactNo" id="contactNo" onkeypress="return isNumber();"/></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Voter Card No:</td>
                            <td><input type="text" name="voter" id="voter" value="" /></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Adhaar Card No:</td>
                            <td><input type="text" name="adhaar" id="adhaar"  value=""  onkeypress="return isNumber();"/></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Details Of Produce:</td>
                            <td><textarea type="text"  name="produce" id="produce"  value="" ></textarea></td>
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
                        <input type="button" value="Submit" onclick="javascript:submitform(musterEnrollForm)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                </div>


                <div id="amend" style="display: none;">
                    <center>
                        <table>

                            <tr>
                                <td>Member ID: </td>
                                <td><input type="text" name="IdAmend" id="IdAmend" value="<%=blankNull(OmasterRollEnrollmentBean.getMemberId())%>"/></td>
                                <td><input type="button"  value="Search" onclick="javascript:popup_CIF(220, 180, document.musterEnrollForm.IdAmend.value, document.musterEnrollForm.nameAmend.value)" /></td>
                            </tr>
                            <tr>
                                <td>Name: </td>
                                <td> <input type="text" name="nameAmend" id="nameAmend" value="<%=blankNull(OmasterRollEnrollmentBean.getName())%>"/></td>

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
                            <td>Name: </td>
                            <td><input type="text" name="name_Amend" id="name_Amend" value="<%=blankNull(OmasterRollEnrollmentBean.getName())%>"/></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Address:</td>
                            <td><textarea type="text"  name="addrAmend" id="addrAmend" ><%=blankNull(OmasterRollEnrollmentBean.getAddress())%></textarea></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Contact No: </td>
                            <td> <input type="text" name="contactnoAmend" id="contactnoAmend" onkeypress="return isNumber();" value="<%=blankNull(OmasterRollEnrollmentBean.getContactNo())%>"/></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Voter Card No:</td>
                            <td><input type="text" name="voterAmend" id="voterAmend" value="<%=blankNull(OmasterRollEnrollmentBean.getVoter())%>" /></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Adhaar Card No:</td>
                            <td><input type="text" name="adhaarAmend" id="adhaarAmend" onkeypress="return isNumber();"  value="<%=blankNull(OmasterRollEnrollmentBean.getAdhaar())%>" /></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Details Of Produce:</td>
                            <td><textarea type="text"  name="produceAmend" id="produceAmend"><%=blankNull(OmasterRollEnrollmentBean.getProduce())%></textarea></td>
                        </tr>
                        <tr>
                            <td><input type ="hidden" name="memberId" id="memberId" value="<%=blankNull(OmasterRollEnrollmentBean.getMemberId())%>"></td>
                        </tr>

                    </table>
                    <br>
                    <table>
                        <tr><td><label>All Fields are mandatory</label></td></tr>
                        </tbody>
                    </table>

                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(musterEnrollForm)">
                        <input type="reset" value="Reset" name="reset" />

                    </center>

                </div>
                <%}%>

                <input type="hidden" name="handle_id" value="" />
            </form>
        </fieldset>
    </body>
</html>
