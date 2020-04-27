<%-- 
    Document   : tradingProductCreation
    Created on : Apr 20, 2016, 3:16:34 PM
    Author     : 590685
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DataEntryBean.tradingProductCreationBean"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trading Product</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function submitform(tradingProductForm)
            {
                if (checkCreateDiv(tradingProductForm))
                {
                    document.forms[0].handle_id.value = "Create";
                    tradingProductForm.submit();
                }

            }
            function checkCreateDiv(tradingProductForm)
            {
                if (tradingProductForm.status.value == "")
                {
                    alert("!! status field must be filled !!");
                    tradingProductForm.status.focus();
                    return false;
                }
                if (tradingProductForm.productName.value == "")
                {
                    alert("!! Product Name field must be filled !!");
                    tradingProductForm.productName.focus();
                    return false;
                }
                if (tradingProductForm.productCode.value == "")
                {
                    alert("!! Product Code field must be filled !!");
                    tradingProductForm.productCode.focus();
                    return false;
                }
                if (tradingProductForm.unit.value == "")
                {
                    alert("!! Quantity Unit field must be filled !!");
                    tradingProductForm.unit.focus();
                    return false;
                }


                if (tradingProductForm.profitFactor.value == "")
                {
                    alert("!! Profit Factor field must be filled !!");
                    tradingProductForm.profitFactor.focus();
                    return false;
                }
                return true;
            }

            function updateform(tradingProductForm)
            {
                if (checkUpdateDiv(tradingProductForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    tradingProductForm.submit();

                }
            }
            function checkUpdateDiv(tradingProductForm)
            {

                if (tradingProductForm.statusAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    tradingProductForm.statusAmend.focus();
                    return false;
                }
                if (tradingProductForm.productNameAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    tradingProductForm.productNameAmend.focus();
                    return false;
                }
                if (tradingProductForm.productCodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    tradingProductForm.productCodeAmend.focus();
                    return false;
                }
                if (tradingProductForm.unitAmend.value == "")
                {
                    alert("!! Quantity Unit field must be filled !!");
                    tradingProductForm.unitAmend.focus();
                    return false;
                }

                if (tradingProductForm.profitFactorAmend.value == "")
                {
                    alert("!! Profit Factor field must be filled !!");
                    tradingProductForm.profitFactorAmend.focus();
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

            function searchProduct(width, height, inventorySearch) {

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
                var screenName = "tradingProductCreation.jsp";
                var lovKey = "prodDetails"
                popWin = open('/PacsApplication/CommonSearchInformationTradingLOV.jsp?inventorySearch=' + inventorySearch + '&screenName=' + screenName + '&lovKey=' + lovKey, 'prodDetails', attr);
                popWin.focus();

            }
            
            function getDetails() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/TradingProductOperationServlet';
                document.forms[0].submit();

            }

            function ActvDeactv() {

                document.forms[0].handle_id.value = "StatusSearch";
                document.forms[0].action = '/PacsApplication/TradingProductOperationServlet';
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
        <jsp:include page="MenuHead_TRADING.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object tradingProductCreationBeanObj = request.getAttribute("tradingProductCreationBeanObj");
            tradingProductCreationBean otradingProductCreationBean = new tradingProductCreationBean();
            if (tradingProductCreationBeanObj != null) {
                otradingProductCreationBean = (tradingProductCreationBean) request.getAttribute("tradingProductCreationBeanObj");

            }
        %>
        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">TRADING PRODUCT MASTER</legend>
            <form name="tradingProductForm" method="post" action="TradingProductOperationServlet">

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
                                <td>Product Name:</td>
                                <td><input type="text" name="productName" id="productName" value="" /></td>
                            </tr>
                            <tr>
                                <td>Product Code:</td>
                                <td><input type="text" name="productCode"  id="productCode" value="" /></td>
                            </tr>
                            <tr>
                                <td>Quantity Unit:</td>
                                <td>
                                    <select id="unit" name="unit">
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="kg">K.g.</option>
                                        <option value="ltr">Lt.</option>
                                        <option value="packet">Packets</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Profit Factor (%):</td>
                                <td><input type="text" name="profitFactor"  id="profitFactor" value="" /></td>
                            </tr>

                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            <tr><td><label>All fields are mandatory</label></td></tr>
                        </tbody>
                    </table><br><br>

                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(tradingProductForm)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                </div>
                <br><br>

                <div id="amend" style="display: none;">
                    <center>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;" >Enter Product Code: </lable>
                        <input type="text" name="inventorySearch" id="inventorySearch"/>
                        <input type="button"  value="Search" onclick="javascript:searchProduct(220, 180, document.tradingProductForm.inventorySearch.value)" />
                        <input type="button"  value="Submit" onclick="javascript:getDetails()" />
                    </center>
                    <br><br>
                </div>

                <%if (displayFlag.equalsIgnoreCase("Y")) {%>
                <div id="amend2" >

                    <table>
                        <tbody>
                            <tr>
                                <td>Status:</td>
                                <td><select id="statusAmend" name="statusAmend">
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="A" <%if (otradingProductCreationBean.getStatus().equals("A")) {%> selected <%}%>>Active</option>
                                        <option value="I" <%if (otradingProductCreationBean.getStatus().equals("I")) {%> selected <%}%>>Inactive</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Product Name:</td>
                                <td><input type="text" name="productNameAmend" id="productNameAmend" value="<%=blankNull(otradingProductCreationBean.getProductName())%>" /></td>
                            </tr>
                            <tr>
                                <td>Product Code:</td>
                                <td><input type="text" name="productCodeAmend"  id="productCodeAmend" value="<%=blankNull(otradingProductCreationBean.getProductCode())%>" /></td>
                            </tr>
                            <tr>
                                <td>Quantity Unit:</td>
                                <td><select id="unitAmend" name="unitAmend">
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="kg" <%if (otradingProductCreationBean.getUnit().equals("kg")) {%> selected <%}%>>K.g.</option>
                                        <option value="ltr" <%if (otradingProductCreationBean.getUnit().equals("ltr")) {%> selected <%}%>>Lt.</option>
                                        <option value="packet" <%if (otradingProductCreationBean.getUnit().equals("packet")) {%> selected <%}%>>Packets</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Profit Factor (%):</td>
                                <td><input type="text" name="profitFactorAmend"  id="profitFactor" value="<%=blankNull(otradingProductCreationBean.getProfitFactor())%>" /></td>
                            </tr>

                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            <tr><td><label>All fields are mandatory</label></td></tr>
                        </tbody>
                    </table><br><br>

                    <br><br>
                    <input type="hidden" name="product_id" value="<%=blankNull(otradingProductCreationBean.getProduct_id())%>"/>
                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(tradingProductForm)">
                    </center>

                </div>
                <% }%>

                <div id="active" style="display: none;">
                    <center>
                        <label style=" font-family: Berlin Sans FB; font-weight:  normal;">Enter Product Code: </label>
                        <input type="text" name="productCodeActivation"/>

                        <label style=" font-family: Berlin Sans FB; font-weight:  normal;">Status:</label>
                        <select id="productStatusFlag" name="productStatusFlag">
                            <option value="" >--Select--</option>
                            <option value="A">Active</option>
                            <option value="I">Inactive</option>
                        </select>
                        <input type="button" value="Sumbit" onclick="javascript:ActvDeactv()">

                    </center>

                    <br><br>
                </div>

                <input type="hidden" name="handle_id" value="" />
            </form>

        </fieldset>

    </body>
</html>
