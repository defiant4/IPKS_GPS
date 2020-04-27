<%-- 
    Document   : CommodityMaster
    Created on : Jul 13, 2016, 1:31:58 PM
    Author     : Tcs Helpdesk10
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DataEntryBean.CommodityMasterBean"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/Calendar.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />


        <title>Commodity Master</title>

    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function submitform(commodityMasterForm)
            {

                if (checkCreateDiv(commodityMasterForm))
                {

                    document.forms[0].handle_id.value = "Create";
                    document.forms[0].action = '/PacsApplication/CommodityMasterServlet';
                    document.forms[0].submit();
                }

            }
            function checkCreateDiv(commodityMasterForm)
            {

                if (commodityMasterForm.itemType.value === "")
                {
                    alert("!! Item Type must be filled !!");
                    commodityMasterForm.itemType.focus();
                    return false;
                }
                if (commodityMasterForm.itemDesc.value === "")
                {
                    alert("!! Item Type Description must be filled !!");
                    commodityMasterForm.itemDesc.focus();
                    return false;
                }
                if (commodityMasterForm.subType.value === "")
                {
                    alert("!! Sub Type must be filled !!");
                    commodityMasterForm.subType.focus();
                    return false;
                }

                if (commodityMasterForm.subtypeDesc.value === "")
                {
                    alert("!! Sub Type Description must be filled !!");
                    commodityMasterForm.subtypeDesc.focus();
                    return false;
                }

                if (commodityMasterForm.qtyUnit.value === "")
                {
                    alert("!! Quantity Unit must be filled !!");
                    commodityMasterForm.qtyUnit.focus();
                    return false;
                }



                return true;
            }
            function updateform(commodityMasterForm)
            {


                if (checkUpdateDiv(commodityMasterForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    document.forms[0].action = '/PacsApplication/CommodityMasterServlet';
                    commodityMasterForm.submit();
                }
            }


            function checkUpdateDiv(commodityMasterForm)
            {

                if (commodityMasterForm.itemType_Amend.value === "")
                {

                    alert(commodityMasterForm.itemType_Amend.value);
                    alert("!! Item Type must be filled !!");
                    commodityMasterForm.itemType_Amend.focus();
                    return false;
                }

                if (commodityMasterForm.itemDesc_Amend.value === "")
                {
                    alert("!! Item Type Description must be filled !!");
                    commodityMasterForm.itemDesc_Amend.focus();
                    return false;
                }
                if (commodityMasterForm.subtypeAmend.value === "")
                {
                    alert(commodityMasterForm.subtypeAmend.value);
                    alert("!! Sub Type must be filled !!");
                    commodityMasterForm.subtypeAmend.focus();
                    return false;
                }


                //re = /^\d+$/; //this checks whether field contains digits
                if (commodityMasterForm.subtypeDescAmend.value === "")
                {
                    alert("!! Sub Type Description must be filled !!");
                    commodityMasterForm.subtypeDescAmend.focus();
                    return false;
                }

                if (commodityMasterForm.qtyUnitAmend.value === "")
                {
                    alert("!! Quantity Unit must be filled !!");
                    commodityMasterForm.qtyUnitAmend.focus();
                    return false;
                }

                return true;

            }
            //LOV
            function popup_Item(width, height) {
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
                var screenName = "CommodityMaster.jsp";
                var lovKey = "CommodityMasterDetails"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_GPS_LOV.jsp?screenName=' + screenName + '&lovKey=' + lovKey, 'CommodityMasterDetails', attr);
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
                document.forms[0].action = '/PacsApplication/CommodityMasterServlet';
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
            String pacsid = "";
            String commodityID = "";
            Object obj = session.getAttribute("pacsId");
            pacsid = obj.toString();
            Object commodityObj = request.getAttribute("commodityID");
            if (commodityObj != null) {
                commodityID = commodityObj.toString();
            }
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
            Object CommodityMasterBeanObj = request.getAttribute("oCommodityMasterBean");
            CommodityMasterBean OCommodityMasterBean = new CommodityMasterBean();
            if (CommodityMasterBeanObj != null) {
                OCommodityMasterBean = (CommodityMasterBean) request.getAttribute("oCommodityMasterBean");

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
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">Commodity Master</legend>
            <form name="commodityMasterForm" method="post" action="CommodityMasterServlet" >

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
                            <td>Item Type: </td>
                            <td><input type="text" name="itemType" id="itemType" onkeypress="return isNumber();"/></td>
                         </tr>
                         <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            
                            <td>Item Description: </td>
                            <td> <input type="text" name="itemDesc" id="itemDesc"/></td>
                         </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>

                        <tr>
                            
                            <td>Sub Type:</td>
                            <td><input type="text" name="subType" id="subType" value="" onkeypress="return isNumber();" /></td>
                         </tr>
<tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Sub Type Description:</td>
                            <td><input type="text" name="subtypeDesc" id="subtypeDesc"  value="" /></td>
                        </tr>
<tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Quantity Unit:</label></td>
                            <td><select id="qtyUnit" onchange="checkop()" name="qtyUnit" >
                                    <option value="" disabled selected style="display:none;" >--select--</option>
                                    <option value="kg" >kg</option>
                                    <option value="ltr" >litre</option>
                                    <option value="pack" >packet</option>
                                    <option value="quin" >quintal</option></td>
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
                        <input type="button" value="Submit" onclick="javascript:submitform(commodityMasterForm)">
                        <input type="reset" value="Reset" name="reset" />
                        <input type="hidden"  name="pacsid" id="pacsid" value="<%=pacsid%>" />
                    </center>
                </div>


                <div id="amend" style="display: none;">
                    <center>
                        <table>
                            <tr>
                                <td>Item Type: </td>
                                <td> <input type="text" name="itemTypeAmend" id="itemTypeAmend" value="<%=blankNull(OCommodityMasterBean.getItemType())%>"/></td>
                                <td><input type="button"  value="Search" onclick="javascript:popup_Item(350, 180)" /></td>
                            </tr>
                            <tr>
                                <td>Item Description: </td>
                                <td><input type="text" name="itemDescAmend" id="itemDescAmend" value="<%=blankNull(OCommodityMasterBean.getItemDesc())%>"/></td>

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
                            <td>Item Type: </td>
                            <td><input type="text" name="itemType_Amend" id="itemType_Amend" onkeypress="return isNumber();"   value="<%=blankNull(OCommodityMasterBean.getItemType())%>"/></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>
                        <tr>
                            <td>Item Description: </td>
                            <td> <input type="text" name="itemDesc_Amend" id="itemDesc_Amend"   value="<%=blankNull(OCommodityMasterBean.getItemDesc())%>"/></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>

                        <tr>
                            <td>Sub Type:</td>
                            <td><input type="text" name="subtypeAmend" id="subtypeAmend" onkeypress="return isNumber();"   value="<%=blankNull(OCommodityMasterBean.getSubType())%>" /></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>

                        <tr>
                            <td>Sub Type Description:</td>
                            <td><input type="text" name="subtypeDescAmend" id="subtypeDescAmend"  value="<%=blankNull(OCommodityMasterBean.getSubtypeDesc())%>" /></td>
                        </tr>
                        <tr><td></td></tr>
                        <tr><td></td></tr>

                        <tr>
                            <td><label style=" font-family: Berlin Sans FB; font-weight:  normal;">Quantity Unit:</label></td>
                            <td><select id="qtyUnitAmend" onchange="checkop()" name="qtyUnitAmend">
                                    <option><%=(OCommodityMasterBean.getQtyUnit())%></option>

                                    <option value="kg" >kg</option>
                                    <option value="ltr" >litre</option>
                                    <option value="pack" >packet</option>
                                    <option value="quin" >quintal</option> </select></td>
                        </tr>

                    </table>
                    <br>
                    <table>
                        <tr><td><label>All Fields are mandatory</label></td></tr>
                        </tbody>
                    </table>

                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(commodityMasterForm)">
                        <input type="reset" value="Reset" name="reset" />
                        <input type="hidden"  name="pacsid" id="pacsid" value="<%=pacsid%>" />

                    </center>

                </div>
                <%}%>

                <input type="hidden" name="CommodityIdAmend" id="CommodityIdAmend" value="<%=commodityID%>" />
                <input type="hidden" name="handle_id" value="" />
            </form>
        </fieldset>
    </body>
</html>
