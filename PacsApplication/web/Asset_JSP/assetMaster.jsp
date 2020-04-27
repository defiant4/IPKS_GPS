<%-- 
    Document   : IdentificationDetails
    Created on : Aug 3, 2015, 2:25:40 PM
    Author     : Administrator
--%>
<%@page import="DataEntryBean.AssetMasterBean" %>
<%@page import="java.sql.SQLException"%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Identification Details</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />

    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }


            function checkCreateDiv(assetmaster)
            {
                re = /^\d+$/; //this checks whether field contains digits
                if (assetmaster.asset_type.value == "")
                {
                    alert("!! asset type field must be filled !!");
                    assetmaster.asset_code.focus();
                    return false;
                }
                if (!re.test(assetmaster.asset_type.value))
                {
                    alert("!! asset type could only contain numbers !!");
                    assetmaster.asset_type.focus();
                    return false;
                }
                
                if (assetmaster.asset_type_desc.value == "")
                {
                    alert("!! asset type desc field must be filled !!");
                    assetmaster.select_asset_type.focus();
                    return false;
                }

                if (assetmaster.asset_sub_type.value == "")
                {
                    alert("!! asset subtype field must be filled !!");
                    assetmaster.asset_sub_type.focus();
                    return false;
                }
                if (!re.test(assetmaster.asset_sub_type.value))
                {
                    alert("!! asset subtype could only contain numbers !!");
                    assetmaster.asset_sub_type.focus();
                    return false;
                }
                if (assetmaster.asset_subtype_desc.value == "")
                {
                    alert("!! asset subtype desc field must be filled !!");
                    assetmaster.asset_subtype_desc.focus();
                    return false;
                }
                if (assetmaster.long_desc.value == "")
                {
                    alert("!! long description field must be filled !!");
                    assetmaster.long_desc.focus();
                    return false;
                }

                
                if (!re.test(assetmaster.depr_rate.value))
                {
                    alert("!! depriciation rate could only contain numbers !!");
                    assetmaster.depr_rate.focus();
                    return false;
                }


                return true;
            }


            function checkUpdateDiv(assetmaster)
            {   
                if (assetmaster.asset_typeAmend.value == "")
                {
                    alert("!! asset type must be filled !!");
                    assetmaster.asset_typeAmend.focus();
                    return false;
                }
                if (assetmaster.asset_type_descAmend.value == "")
                {
                    alert("!! asset type desc must be filled !!");
                    assetmaster.asset_type_descAmend.focus();
                    return false;
                }
                if (assetmaster.asset_subtypeAmend.value == "")
                {
                    alert("!! asset subtype must be filled !!");
                    
                    assetmaster.asset_subtypeAmend.focus();
                    return false;
                }
                if (assetmaster.asset_subtype_descAmend.value == "")
                {
                    alert("!! asset subtype Desc must be filled !!");
                    assetmaster.asset_subtype_descAmend.focus();
                    return false;
                }
                if (assetmaster.long_descAmend.value == "")
                {
                    alert("!! Updated Description must be filled !!");
                    
                    assetmaster.long_descAmend.focus();
                    return false;
                }
                if (assetmaster.depr_rateAmend.value == "")
                {
                    alert("!! Updated Depriciation Rate must be filled !!");
                    
                    assetmaster.depr_rateAmend.focus();
                    return false;
                }
                

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(assetmaster.asset_typeAmend.value))
                {
                    alert("!! Asset Type could only contain numbers !!");
                    assetmaster.asset_typeAmend.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(assetmaster.asset_subtypeAmend.value))
                {
                    alert("!! Asset SubType could only contain numbers !!");
                    assetmaster.asset_subtypeAmend.focus();
                    return false;
                }
               
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(assetmaster.depr_rateAmend.value))
                {
                    alert("!! Updated Depriciation Rate could only contain numbers !!");
                    assetmaster.depr_rateAmend.focus();
                    return false;
                }
                return true;
            }

            function submitform(assetmaster)
            {
                
                if (checkCreateDiv(assetmaster))
                {
                    document.forms[0].handle_id.value = "Create";
                    document.forms[0].action = '/PacsApplication/AssetMasterServlet';
                    assetmaster.submit();
                }

            }

            function updateform(assetmaster)
            {

                if (checkUpdateDiv(assetmaster))
                {
                    document.forms[0].handle_id.value = "Update";
                    document.forms[0].action = '/PacsApplication/AssetMasterServlet';
                    assetmaster.submit();

                }

            }

            function searchAsset() {
                
                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/AssetMasterServlet';
                document.forms[0].submit();

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
                    document.getElementById('amend').style.display = 'block';
                    document.getElementById('create').style.display = 'none';
                    ocument.getElementById('amend2').style.display = 'none';



                }
                
                

            }
            



        </script>
        <jsp:include page="MenuHead_ASSET.jsp" flush="true" />
        <br>

        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object AssetMasterBeanBeanobj = request.getAttribute("oAssetMasterBeanObj");
            AssetMasterBean oAssetMasterBean = new AssetMasterBean();
            if (AssetMasterBeanBeanobj != null) {
                oAssetMasterBean = (AssetMasterBean) request.getAttribute("oAssetMasterBeanObj");

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

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">ASSET MASTER</legend>

            <form name="assetmaster" method="post" action="AssetMasterServlet">

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
                        
                    </select>
                </center>
                <br>

                <div id="create" style="display:none;">

                    <table>
                        <tbody>
                            <tr>
                                <td>Asset Type:</td>
                                <td><input type="text" name="asset_type" id="asset_type" size="10" value="" /></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>
                            <tr>
                                <td>Asset Type Description:</td>
                                <td><input type="text" name="asset_type_desc" id="asset_type_desc" size="10" value="" /></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>
                            <tr>
                                <td>Asset SubType</td>
                                <td><input type="text" name="asset_sub_type" id="asset_sub_type" size="10" value="" />
                                </td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>
                            <tr>
                                <td>Asset SubType Description:</td>
                                <td><input type="text" name="asset_subtype_desc" id="asset_subtype_desc"size="10" value="" />
                                </td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>

                            <tr>
                                <td>Description:</td>
                                <td><textarea rows="4" cols="50"  name="long_desc" id="long_desc" style="width: 180px;"></textarea></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>

                            <tr>
                                <td>Depriciation Rate: (%)</td>
                                <td><input type="textarea" name="depr_rate" id="depr_rate" value="" size="10" /></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>

                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            
                        </tbody>
                    </table><br><br>
                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(assetmaster)">
                         <input type="button" value="Reset" onclick="ShowParent();" />
                    </center>
                    <p style=" font-family: Berlin Sans FB; font-weight:  normal;">* All fields are mandatory </p>

                </div>

                <div id="amend" style="display: none;">
                    <center>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Asset Type: </lable>
                        <input type="text" name="asset_typeSearch"/>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Asset SubType : </lable>
                        <input type="text" name="asset_subtypeSearch"/>
                        <input type="button"  value="Search" onclick="javascript:searchAsset()" />
                    </center><br>
                </div>

                <%if (displayFlag.equalsIgnoreCase("Y")) {%>                

                <div id="amend2" >

                    <table>
                        <tbody>
                            <tr>
                                <td>Asset Type:</td>
                                <td><input type="text" name="asset_typeAmend" id="asset_typeAmend" readonly="true" value="<%=blankNull(oAssetMasterBean.getAsset_type())%>" size="10" value="" /></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>
                            <tr>
                                <td>Asset Type Description:</td>
                                <td><input type="text" name="asset_type_descAmend" id="asset_type_descAmend" size="10" value="<%=blankNull(oAssetMasterBean.getAsset_type_desc())%>" /></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>
                            <tr>
                                <td>Asset SubType</td>
                                <td><input type="text" name="asset_subtypeAmend" id="asset_subtypeAmend" readonly="true" size="10" value="<%=blankNull(oAssetMasterBean.getAsset_sub_type())%>" />
                                </td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>
                            <tr>
                                <td>Asset SubType Description:</td>
                                <td><input type="text" name="asset_subtype_descAmend" id="asset_subtype_descAmend" size="10" value="<%=blankNull(oAssetMasterBean.getAsset_subtype_desc())%>" />
                                </td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>

                            <tr>
                                <td>Description:</td>
                                <td><textarea rows="4" cols="50"  name="long_descAmend" id="long_descAmend" style="width: 180px;"/><%=blankNull(oAssetMasterBean.getLong_desc())%></textarea></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>

                            <tr>
                                <td>Depriciation Rate: (%)</td>
                                <td><input type="textarea" name="depr_rateAmend" id="depr_rateAmend" value="<%=blankNull(oAssetMasterBean.getDepr_rate())%>" size="10" /></td>
                            </tr>
                            <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>

                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            <tr><td><label>* All fields are mandatory</label></td></tr>
                        </tbody>
                    </table>
                    <br><br>
                    <input type="hidden" name="asset_id" value="<%=blankNull(oAssetMasterBean.getAsset_id())%>"/>
                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(assetmaster)">
                         <input type="button" value="Reset" onclick="ShowParent();" />
                    </center>

                </div>      
                <%}%> 

                          

                <input type="hidden" name="handle_id" value="" />
            </form>
                <script>
                     function ShowParent()
                {
                    document.forms[0].action="${pageContext.request.contextPath}/Asset_JSP/assetMaster.jsp";
                    document.forms[0].submit();
                }
                </script>
        </fieldset>
    </body>
</html>