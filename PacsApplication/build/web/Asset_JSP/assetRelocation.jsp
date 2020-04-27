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

            function submitform(assetrelocationform)
            {

                if (assetrelocationform.asset_id.value == "")
                {
                    alert("!! All fields must be filled !!");
                    assetrelocationform.asset_id.focus();
                    return false;
                }
                if (assetrelocationform.pacsName.value == "")
                {
                    alert("!! All fields must be filled !!");
                    assetrelocationform.pacsName.focus();
                    return false;
                }
                document.forms[0].action = '/PacsApplication/AssetRelocationServlet';
                document.forms[0].submit();
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
                var screenName = "assetRelocation.jsp";
                var lovKey = "assetRelocationDetails"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_ASSET_LOV.jsp?asset_id=' + asset_id + '&screenName=' + screenName + '&lovKey=' + lovKey, 'assetRelocationDetails', attr);
                popWin.focus();

            }
            function popup_pacs_id(width, height, pacsName) {
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
                var screenName = "assetRelocation.jsp";
                var lovKey = "assetRelocationDetails2"
                popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_ASSET_LOV.jsp?pacsName=' + pacsName + '&screenName=' + screenName + '&lovKey=' + lovKey, 'assetRelocationDetails2', attr);
                popWin.focus();

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
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white"> ASSET RELOCATION</legend>
            <form method="post" name="assetrelocationform">

                <%if (!error_msg.equalsIgnoreCase("")) {%>

                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                
                <center>
                <table>
                    <tbody>
                        <tr>
                            <td>Asset ID:</td>
                            <td> <input type="text" id="asset_id" name="asset_id">&nbsp;&nbsp;&nbsp;<input type="button" name="assetidSearch" id="assetidSearch" value="Search" onclick="javascript:popup_asset_id(220, 180, document.getElementById('asset_id').value);"/></td>
                        </tr>
                        <tr></tr>
                         <tr></tr>
                        <tr>
                            <td>Transfer To:</td>
                            <td> <input type="text" id="pacsName" name="pacsName">&nbsp;&nbsp;&nbsp;<input type="button" name="pacsIdSearch" id="pacsIdSearch" value="Search" onclick="javascript:popup_pacs_id(220, 180, document.getElementById('pacsName').value);"/></td>
                        </tr>
                    <input type="hidden" name="regid">
                    <input type="hidden" name="pacs_mst_id">
                    </tbody>
                </table>
                </center>
                <br><br>
                <center>
                    <input type="button" value="Submit" onclick="javascript:submitform(assetrelocationform)">
                    <input type="button" value="Reset" name="reset" onclick="ShowParent();" />
                </center>
                <script>
                    function ShowParent()
                    {
                        document.forms[0].action = "${pageContext.request.contextPath}/Asset_JSP/assetRelocation.jsp";
                        document.forms[0].submit();
                    }
                </script>
            </form>
        </fieldset>
    </body>
</html>
