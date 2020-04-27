<%-- 
    Document   : assetrelocation
    Created on : Jun 24, 2016, 3:21:04 PM
    Author     : Tcs Helpdesk10
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

            function popup_asset_id(width, height, asset_id) {
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
                var screenName = "assetDisposal.jsp";
                var lovKey = "assetDisposalDetails"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_ASSET_LOV.jsp?asset_id=' + asset_id + '&screenName=' + screenName + '&lovKey=' + lovKey, 'assetDisposalDetails', attr);
                popWin.focus();

            }
            function checkSubmit(assetdisposalform)
            {
                if (assetdisposalform.asset_id.value == "")
                {
                    alert("!! All fields must be filled !!");
                    assetdisposalform.asset_id.focus();
                    return false;
                }
                if (assetdisposalform.disposeflag.value == "")
                {
                    alert("!! All fields must be filled !!");
                    assetdisposalform.disposeflag.focus();
                    return false;
                }
                document.forms[0].action = '/PacsApplication/AssetDisposalServlet';
                document.forms[0].submit();
            }
        </script>
    </head>
    <body onload="noBack()">
        <jsp:include page="MenuHead_ASSET.jsp" flush="true" />
        <br>

        <%
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>

        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                ASSET DISPOSAL
            </legend>
            <form method="post" name="assetdisposalform">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>

                <center>
                    <table>
                        <tbody>
                            <tr>
                                <td>Asset ID:</td>
                                <td> <input type="text" id="asset_id" name="asset_id">&nbsp;&nbsp;&nbsp;<input type="button" name="assetidSearch" id="assetidSearch" value="Search" onclick="javascript:popup_asset_id(220, 180, document.forms[0].asset_id.value)"/></td>
                            </tr>
                            <tr></tr>
                            <tr></tr>
                            <tr>
                                <td>Dispose Asset :</td>
                                <td><select style="width: 173px;" id="disposeflag" name="disposeflag">
                                        <option disabled selected>-------Please select-------</option><option value="I">Yes</option><option value="A">No</option>
                                    </select></td>
                            </tr>
                        <input type="hidden" id="regid" name="regid">


                        </tbody>
                    </table>
                    <br><br>
                </center>
                <center>
                    <input type="button" value="Submit" onclick="javascript:checkSubmit(assetdisposalform)">
                    <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                </center>
                <script>
                    function ShowParent()
                    {
                        document.forms[0].action = "${pageContext.request.contextPath}/Asset_JSP/assetDisposal.jsp";
                        document.forms[0].submit();
                    }
                </script>
            </form>
        </fieldset>
    </body>
</html>
