<%-- 
    Document   : pds_stock_register
    Created on : May 5, 2016, 12:31:09 PM
    Author     : 590685
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.AssetRegisterBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="LoginDb.DbHandler"%>


<html>

    <head>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
        <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
        <script>

            function noBack()
            {
                window.history.forward();
            }

            function popup_asset(width, height, asset_type, asset_subtype) {
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
                var screenName = "assetRegister.jsp";
                var lovKey = "assetDetails"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_ASSET_LOV.jsp?asset_type=' + asset_type + '&asset_subtype=' + asset_subtype + '&screenName=' + screenName + '&lovKey=' + lovKey, 'assetDetails', attr);
                popWin.focus();

            }
            function submitform(assetregister)
            {

                if (assetregister.asset_type.value == "" || assetregister.asset_subtype.value == "")
                {
                    alert("!! All the Search Fields are Empty !!");
                    return false;
                }

                document.forms[0].action = '/PacsApplication/AssetRegisterServlet';
                document.assetregister.submit();
            }

        </script>
    </head>
    <body onload="noBack()">

        <%
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object alpdsStockRegisterBeanApendObj = request.getAttribute("alAssetRegisterBean");
            Object oAssetRegisterBeanObj = request.getAttribute("oAssetRegisterBean");

            AssetRegisterBean oAssetRegisterBeanApend = new AssetRegisterBean();
            if (oAssetRegisterBeanObj != null) {
                oAssetRegisterBeanApend = (AssetRegisterBean) request.getAttribute("oAssetRegisterBean");
            }

            ArrayList<AssetRegisterBean> alAssetRegisterBeanApend = new ArrayList<AssetRegisterBean>();
            if (alpdsStockRegisterBeanApendObj != null) {
                alAssetRegisterBeanApend = (ArrayList<AssetRegisterBean>) request.getAttribute("alAssetRegisterBean");
            }
        %>

        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>

        <jsp:include page="MenuHead_ASSET.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                ASSET REGISTER
            </legend>

            <form id="assetregister" name="assetregister" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                            <% }%>
                
                <center>
                    <table>
                        <tbody>
                            <tr>
                                <td>Asset Type: </td>
                                <td><input type="text" name="asset_type" id="asset_type" value="<%=blankNull(oAssetRegisterBeanApend.getAsset_type())%>"/><input type="button"  value="Search" onclick="javascript:popup_asset(220, 180, document.assetregister.asset_type.value, document.assetregister.asset_subtype.value);" /></td>
                            </tr>
                            <tr>
                                <td>Asset SubType: </td>
                                <td> <input type="text" name="asset_subtype" id="asset_subtype" value="<%=blankNull(oAssetRegisterBeanApend.getAsset_subtypoe())%>"/><input type="button"  value="Search" onclick="javascript:popup_asset(220, 180, document.assetregister.asset_type.value, document.assetregister.asset_subtype.value)" /></td>
                            </tr>

                        </tbody>
                    </table>
                            <br><br>
                    <input type="hidden" name="asset_mst_id" id="asset_mst_id" value="<%=blankNull(oAssetRegisterBeanApend.getAsset_mst_id())%>"/>
                     <input type="button" value="Submit" id="Submit" onclick="javascript:submitform(assetregister)"/>
                    <input type="button" value="Reset" id="Reset" onclick="ShowParent();" />
                </center>
                <br>

                <br>

                <%if (displayFlag.equalsIgnoreCase("Y")) {%>
                <center>
                    <div id="displayDiv">

                        <table border="2" width="auto" cellspacing="1" cellpadding="1" style="text-align: center ;overflow-y: scroll; font-size: 15px" >
                            <thead  class="CSSTableGenerator" >
                                <tr> <td > <b>Asset ID</b>  </td>
                                    <td ><b>Description</b></td>
                                    <td ><b>Initial Value</b></td>
                                    <td ><b>Current Value</b></td>
                                    <td ><b>Mode of Aquirement</b></td>
                                    <td ><b>Entry Date</b></td>
                                    <td><b>Asset Status</b></td>
                                </tr>
                            </thead>
                            <tbody style="background-color: white; font-size: 15px">
                                <%
                                    oAssetRegisterBeanApend = null;

                                    int i;
                                    for (i = 0; i < alAssetRegisterBeanApend.size(); i++) {
                                        oAssetRegisterBeanApend = alAssetRegisterBeanApend.get(i);
                                %>
                                <tr>


                                    <td ><input readonly="true"  type="text" name="asset_id<%=i%>" id="asset_id<%=i%>" value="<%=blankNull(oAssetRegisterBeanApend.getAsset_id())%>" /></td>
                                    <td ><input readonly="true"  type="text" name="description<%=i%>" id="description<%=i%>" value="<%=blankNull(oAssetRegisterBeanApend.getDescription())%>" /></td>
                                    <td><input readonly="true"  type="text" name="int_value<%=i%>" id="int_value<%=i%>" value="<%=blankNull(oAssetRegisterBeanApend.getInt_value())%>" /></td>
                                    <td><input readonly="true"  type="text" name="pres_val<%=i%>" id="pres_val<%=i%>" value="<%=blankNull(oAssetRegisterBeanApend.getPres_val())%>" /></td>
                                    <td><input readonly="true"  type="text" name="mode_of_aqr<%=i%>" id="mode_of_aqr<%=i%>" value="<%=blankNull(oAssetRegisterBeanApend.getMode_of_aqr())%>" /></td>
                                    <td><input readonly="true"  type="text" name="entry_date<%=i%>" id="entry_date<%=i%>" value="<%=blankNull(oAssetRegisterBeanApend.getEntry_date())%>" /></td>
                                    <td><select disabled="true" name="status<%=i%>" id="status<%=i%>" >
                                            <option value="" disabled selected style="display:none;">--Select--</option>
                                            <option value="A" <%if (oAssetRegisterBeanApend.getStatus().equals("A")) {%> selected <%}%>>Active</option>
                                            <option value="I" <%if (oAssetRegisterBeanApend.getStatus().equals("I")) {%> selected <%}%>>Inactive</option>
                                        </select>
                                    </td>

                                    <input type="hidden" name="detail_id<%=i%>" id="detail_id<%=i%>" value="<%=blankNull(oAssetRegisterBeanApend.getAsset_id())%>" />


                                </tr>
                                <%}%>
                            </tbody>
                        </table>

                    </div>
                </center>
                <%}%>
                
               
            </form>
            <script>
                function ShowParent()
                {
                    document.forms[0].action = "${pageContext.request.contextPath}/Asset_JSP/assetRegister.jsp";
                    document.forms[0].submit();
                }
            </script>
        </fieldset>
    </body>
</html>
