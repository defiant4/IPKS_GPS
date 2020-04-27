<%-- 
    Document   : gl
    Created on : Aug 3, 2015, 2:23:35 PM
    Author     : Administrator
--%>
<%@page import="DataEntryBean.GlProductOperationBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>

        <title>GL Product Operation</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function submitform(glForm)
            {
                if (checkCreateDiv(glForm))
                {
                    document.forms[0].handle_id.value = "Create";
                    glForm.submit();
                }

            }
            function checkCreateDiv(glForm)
            {
                if (glForm.status.value == "")
                {
                    alert("!! status field must be filled !!");
                    glForm.status.focus();
                    return false;
                }
                if (glForm.glName.value == "")
                {
                    alert("!! glName field must be filled !!");
                    glForm.glName.focus();
                    return false;
                }
                if (glForm.glCode.value == "")
                {
                    alert("!! glCode field must be filled !!");
                    glForm.glCode.focus();
                    return false;
                }
                if (glForm.glType.value == "")
                {
                    alert("!! glType field must be filled !!");
                    glForm.glType.focus();
                    return false;
                }
                if (glForm.productType.value == "")
                {
                    alert("!! productType field must be filled !!");
                    glForm.productType.focus();
                    return false;
                }
                if (glForm.inttCategory.value == "")
                {
                    alert("!! inttCategory field must be filled !!");
                    glForm.inttCategory.focus();
                    return false;
                }
                if (glForm.glDescription.value == "")
                {
                    alert("!! glDescription field must be filled !!");
                    glForm.glDescription.focus();
                    return false;
                }
                if (glForm.segmentCode.value == "")
                {
                    alert("!! segmentCode field must be filled !!");
                    glForm.segmentCode.focus();
                    return false;
                }
                if (glForm.component1.value == "")
                {
                    alert("!! component1 field must be filled !!");
                    glForm.component1.focus();
                    return false;
                }
                if (glForm.component2.value == "")
                {
                    alert("!! component2 field must be filled !!");
                    glForm.component2.focus();
                    return false;
                }
                if (glForm.applicableFor.value == "")
                {
                    alert("!! applicableFor field must be filled !!");
                    glForm.applicableFor.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(glForm.productType.value))
                {
                    alert("!! ProductType could only contain numbers !!");
                    glForm.productType.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(glForm.inttCategory.value))
                {
                    alert("!! INTT Category could only contain numbers !!");
                    glForm.inttCategory.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(glForm.segmentCode.value))
                {
                    alert("!! Segment Code could only contain numbers !!");
                    glForm.segmentCode.focus();
                    return false;
                }
                return true;
            }

            function updateform(glForm)
            {
                if (checkUpdateDiv(glForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    glForm.submit();

                }
            }
            function checkUpdateDiv(glForm)
            {

                if (glForm.statusAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.statusAmend.focus();
                    return false;
                }
                if (glForm.glNameAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.glNameAmend.focus();
                    return false;
                }
                if (glForm.glCodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.glCodeAmend.focus();
                    return false;
                }
                if (glForm.glTypeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.glTypeAmend.focus();
                    return false;
                }
                if (glForm.productTypeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.productTypeAmend.focus();
                    return false;
                }
                if (glForm.inttCategoryAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.inttCategoryAmend.focus();
                    return false;
                }
                if (glForm.glDescriptionAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.glDescriptionAmend.focus();
                    return false;
                }
                if (glForm.segmentCodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.segmentCodeAmend.focus();
                    return false;
                }
                if (glForm.component1Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.component1Amend.focus();
                    return false;
                }
                if (glForm.component2Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.component2Amend.focus();
                    return false;
                }
                if (glForm.applicableForAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    glForm.applicableForAmend.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(glForm.productTypeAmend.value))
                {
                    alert("!! ProductType could only contain numbers !!");
                    glForm.productTypeAmend.focus();
                    return false;
                }
                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(glForm.inttCategoryAmend.value))
                {
                    alert("!! INTT Category could only contain numbers !!");
                    glForm.inttCategoryAmend.focus();
                    return false;
                }

                re = /^\d+$/; //this checks whether field contains digits
                if (!re.test(glForm.segmentCodeAmend.value))
                {
                    alert("!! Segment Code could only contain numbers !!");
                    glForm.segmentCodeAmend.focus();
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
                    document.getElementById('active').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';


                }
                if (document.getElementById("checkOption").value == "amend")
                {
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'block';
                    document.getElementById('active').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';


                }
                if (document.getElementById("checkOption").value == "active")
                {
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('active').style.display = 'block';
                    document.getElementById('amend2').style.display = 'none';

                }
                if (document.getElementById("checkOption").value == "deactive")
                {
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('active').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';

                }

            }

            function searchGL() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/GlProductOperationServlet';
                document.forms[0].submit();

            }

            function ActvDeactv() {

                document.forms[0].handle_id.value = "StatusSearch";
                document.forms[0].action = '/PacsApplication/GlProductOperationServlet';
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


        <jsp:include page="MenuHead.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object oGlProductOperationBeanObj = request.getAttribute("oGlProductOperationBeanObj");
            GlProductOperationBean oGlProductOperationBean = new GlProductOperationBean();
            if (oGlProductOperationBeanObj != null) {
                oGlProductOperationBean = (GlProductOperationBean) request.getAttribute("oGlProductOperationBeanObj");
                session.setAttribute("oGlProductOperationBeanObj", oGlProductOperationBeanObj);
            }
        %>

<fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">GL PRODUCT OPERATION</legend>
        <form name="glForm" method="post" action="GlProductOperationServlet"> 
            
            <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                <% }%>
                <br>
            <br>

            <center><lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</lable>
                <select id="checkOption" onchange="checkop()" name="checkOption" >
                    <option value="" disabled selected style="display:none;" >--select--</option>
                    <option value="create" >Create</option>
                    <option value="amend" >Amend</option>
                    <option value="active" >Active/De-Active </option>
                </select>
            </center>
            <br>

            <div id="create" style="display:none;">
                <table>
                    <tbody>
                        <tr>
                            <td>Status:</td>
                            <td><select id="status" name="status">                
                                    <option value="" disabled selected style="display:none;">--Select--</option>
                                    <option value="A">Active</option>
                                    <option value="I">Inactive</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>GL Name:</td>
                            <td><input type="text" name="glName" value="" /></td>
                        </tr>
                        <tr>
                            <td>GL Code:</td>
                            <td><input type="text" name="glCode" size="15" value="" /></td>
                        </tr>
                        <tr>
                            <td>GL Type:</td>
                            <td><select id="glType" name="glType">                
                                    <option value="" disabled selected style="display:none;">--Select--</option>
                                    <option value="1">1:Asset</option>
                                    <option value="2">2:Liability</option>
                                    <option value="7">7:Income</option>
                                    <option value="8">8:Expense</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Product Type:</td>
                            <td><input type="text" maxlength="4" name="productType" value="" size="10" /></td>
                        </tr>
                        <tr>
                            <td>INTT Category:</td>
                            <td><input type="text" maxlength="4" name="inttCategory" value="" size="10" /></td>
                        </tr>
                        <tr>
                            <td>GL Description:</td>
                            <td><input type="text" name="glDescription" style="width: 260px" value="" /></td>
                        </tr>
                        <tr>
                            <td>Segment Code:</td>
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
                            <td>Component 1:</td>
                            <td><input type="text" name="component1" value="" size="10" /></td>
                        </tr>
                        <tr>
                            <td>Component 2:</td>
                            <td><input type="text" name="component2" value="" size="10" /></td>
                        </tr>
                        <tr>
                            <td>Applicable For: </td>
                            <td>
                                <select id="applicableFor" name="applicableFor">                
                                    <option value="" disabled selected style="display:none;">--Select--</option>
                                    <option value="G">Global</option>
                                    <option value="SB">Selected Branches</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td><br></td></tr>
                        <tr><td><br></td></tr>
                        <tr><td><label>All fields are mandatory</label></td></tr>
                    </tbody>
                </table><br><br>

                <center>
                    <input type="button" value="Submit" onclick="javascript:submitform(glForm)">
                    <input type="reset" value="Reset" name="reset" />
                </center>
            </div>

            <div id="amend" style="display: none;">
                <center>
                    <lable style=" font-family: Berlin Sans FB; font-weight:  normal;" >Enter GL Code: </lable>
                    <input type="text" name="bglCodeSearch"/>
                    <input type="button"  value="Search" onclick="javascript:searchGL()" />
                </center><br>
            </div>

            <%if (displayFlag.equalsIgnoreCase("Y")) {%>

            <div id="amend2" >

                <table>
                    <tbody>
                        <tr>
                            <td>Effective Date:</td>
                            <td><input readonly type="text" style="text-align:center;" name="effectDateAmend" maxlength="11" resize="yes" readonly="true" value="<%=blankNull(oGlProductOperationBean.getEffectDate())%>" ></td>
                        </tr>
                        <tr>
                            <td>Status:</td>
                            <td><select id="statusAmend" name="statusAmend"  readonly >                
                                    <option value="" disabled selected style="display:none;" <%if (oGlProductOperationBean.getStatus().equals("")) {%> selected <%}%>>--Select--</option>
                                    <option value="A" <%if (oGlProductOperationBean.getStatus().equals("A")) {%> selected <%}%>>Active</option>
                                    <option value="I" <%if (oGlProductOperationBean.getStatus().equals("I")) {%> selected <%}%>>Inactive</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td>GL Name:</td>
                            <td><input type="text" name="glNameAmend" value="<%=blankNull(oGlProductOperationBean.getGlName())%>"/></td>
                        </tr>
                        <tr>
                            <td>GL Code:</td>
                            <td><input readonly type="text" name="glCodeAmend" size="15" value="<%=blankNull(oGlProductOperationBean.getGlCode())%>" /></td>
                        </tr>
                        <tr>
                            <td>GL Type:</td>
                            <td><select id="glTypeAmend" name="glTypeAmend" readonly >                
                                    <option value="" disabled selected style="display:none;" <%if (oGlProductOperationBean.getGlType().equals("")) {%> selected <%}%>>--Select--</option>
                                    <option value="1" <%if (oGlProductOperationBean.getGlType().equals("1")) {%> selected <%}%>>1:Asset</option>
                                    <option value="2" <%if (oGlProductOperationBean.getGlType().equals("2")) {%> selected <%}%>>2:Liability</option>
                                    <option value="7" <%if (oGlProductOperationBean.getGlType().equals("7")) {%> selected <%}%>>7:Income</option>
                                    <option value="8" <%if (oGlProductOperationBean.getGlType().equals("8")) {%> selected <%}%>>8:Expense</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Product Type:</td>
                            <td><input type="text" maxlength="4" size="10" name="productTypeAmend" value="<%=blankNull(oGlProductOperationBean.getProductType())%>" /></td>
                        </tr>
                        <tr>
                            <td>INTT Category:</td>
                            <td><input type="text" maxlength="4" size="10" name="inttCategoryAmend" value="<%=blankNull(oGlProductOperationBean.getInttCategory())%>"/></td>
                        </tr>
                        <tr>
                            <td>GL Description:</td>
                            <td><input type="text" name="glDescriptionAmend" style="width: 260px" value="<%=blankNull(oGlProductOperationBean.getGlDescription())%>" /></td>
                        </tr>
                        <tr>
                            <td>Segment Code:</td>
                            <td><select id="segmentCodeAmend" name="segmentCodeAmend">                
                                    <option value="" disabled selected style="display:none;">--Select--</option>
                                    <option value="0706" <%if (oGlProductOperationBean.getSegmentCode().equals("0706")) {%> selected <%}%>>0706:INDIVIDUAL</option>
                                    <option value="0306" <%if (oGlProductOperationBean.getSegmentCode().equals("0306")) {%> selected <%}%>>0306:STAFF</option>
                                    <option value="5003" <%if (oGlProductOperationBean.getSegmentCode().equals("5003")) {%> selected <%}%>>5003:SENIOR CITIZEN</option>
                                    <option value="5010" <%if (oGlProductOperationBean.getSegmentCode().equals("5010")) {%> selected <%}%>>5010:SHG</option>
                                    <option value="5000" <%if (oGlProductOperationBean.getSegmentCode().equals("5000")) {%> selected <%}%>>5000:BANKS</option>
                                    <option value="5009" <%if (oGlProductOperationBean.getSegmentCode().equals("5009")) {%> selected <%}%>>5009:INSTITUTIONS</option>
                                    <option value="5050" <%if (oGlProductOperationBean.getSegmentCode().equals("5050")) {%> selected <%}%>>5050:OTHERS</option>
                                    <option value="5007" <%if (oGlProductOperationBean.getSegmentCode().equals("5007")) {%> selected <%}%>>5007:SOCIETY</option>
                                    <option value="5011" <%if (oGlProductOperationBean.getSegmentCode().equals("5011")) {%> selected <%}%>>5011:GOV/SEMI GOV</option>
                                    <option value="5012" <%if (oGlProductOperationBean.getSegmentCode().equals("5012")) {%> selected <%}%>>5012:PACS</option>
                                    <option value="5013" <%if (oGlProductOperationBean.getSegmentCode().equals("5013")) {%> selected <%}%>>5013:UCB</option>
                                    <option value="5014" <%if (oGlProductOperationBean.getSegmentCode().equals("5014")) {%> selected <%}%>>5014:SCB</option>
                                    <option value="5015" <%if (oGlProductOperationBean.getSegmentCode().equals("5015")) {%> selected <%}%>>5015:CCB</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td>Component 1:</td>
                            <td><input type="text" name="component1Amend" size="10" value="<%=blankNull(oGlProductOperationBean.getComponent1())%>" /></td>
                        </tr>
                        <tr>
                            <td>Component 2:</td>
                            <td><input type="text" name="component2Amend" size="10" value="<%=blankNull(oGlProductOperationBean.getComponent2())%>" /></td>
                        </tr>
                        <tr>
                            <td>Applicable For: </td>
                            <td>
                                <select id="applicableForAmend" name="applicableForAmend" >                
                                    <option value="" disabled selected style="display:none;" <%if (oGlProductOperationBean.getApplicableFor().equals("")) {%> selected <%}%>>--Select--</option>
                                    <option value="G" <%if (oGlProductOperationBean.getApplicableFor().equals("G")) {%> selected <%}%>>Global</option>
                                    <option value="SB" <%if (oGlProductOperationBean.getApplicableFor().equals("SB")) {%> selected <%}%>>Selected Branches</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td><br></td></tr>
                        <tr><td><br></td></tr>
                        <tr><td><label>All fields are mandatory</label></td></tr>
                    </tbody>

                </table>
                <br><br>
                <input type="hidden" name="gl_product_id" value="<%=blankNull(oGlProductOperationBean.getGl_product_id())%>"/>
                <center>
                    <input type="button" value="Update" onclick="javascript:updateform(glForm)">
                </center>

            </div>
            <%}%>                         

            <div id="active" style="display: none;">
                <center>
                    <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Enter BGL Code: </lable>
                    <input type="text" name="bglCodeActivation"/>

                    <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Status:</lable>
                    <select id="BglstatusFlag" name="BglstatusFlag">                
                        <option value="" >--Select--</option>
                        <option value="A">Active</option>
                        <option value="I">Inactive</option>
                    </select>
                    <input type="button" value="Sumbit" onclick="javascript:ActvDeactv()">

                </center> 
            </div>             

            <input type="hidden" name="handle_id" value="" />
        </form>
</fieldset>   
</body>
</html>





