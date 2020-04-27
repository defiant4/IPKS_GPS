<%--
    Document   : tradingProductCreation
    Created on : Apr 20, 2016, 3:16:34 PM
    Author     : 590685
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DataEntryBean.pdsProductCreationBean"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PDS Product</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }

            function submitform(pdsProductForm)
            {
                if (checkCreateDiv(pdsProductForm))
                {
                    document.forms[0].handle_id.value = "Create";
                    pdsProductForm.submit();
                }

            }
            function checkCreateDiv(pdsProductForm)
            {
                if (pdsProductForm.status.value == "")
                {
                    alert("!! status field must be filled !!");
                    pdsProductForm.status.focus();
                    return false;
                }
                if (pdsProductForm.productName.value == "")
                {
                    alert("!! Product Name field must be filled !!");
                    pdsProductForm.productName.focus();
                    return false;
                }
                if (pdsProductForm.productCode.value == "")
                {
                    alert("!! Product Code field must be filled !!");
                    pdsProductForm.productCode.focus();
                    return false;
                }
                if (pdsProductForm.unit.value == "")
                {
                    alert("!! Quantity Unit field must be filled !!");
                    pdsProductForm.unit.focus();
                    return false;
                }


                if (pdsProductForm.profitFactor.value == "")
                {
                    alert("!! Profit Factor field must be filled !!");
                    pdsProductForm.profitFactor.focus();
                    return false;
                }


                return true;
            }

            function updateform(pdsProductForm)
            {
                if (checkUpdateDiv(pdsProductForm))
                {
                    document.forms[0].handle_id.value = "Update";
                    pdsProductForm.submit();

                }
            }
            function checkUpdateDiv(pdsProductForm)
            {

                if (pdsProductForm.statusAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pdsProductForm.statusAmend.focus();
                    return false;
                }
                if (pdsProductForm.productNameAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pdsProductForm.productNameAmend.focus();
                    return false;
                }
                if (pdsProductForm.productCodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pdsProductForm.productCodeAmend.focus();
                    return false;
                }
                if (pdsProductForm.unitAmend.value == "")
                {
                    alert("!! Quantity Unit field must be filled !!");
                    pdsProductForm.unitAmend.focus();
                    return false;
                }

                if (pdsProductForm.profitFactorAmend.value == "")
                {
                    alert("!! Profit Factor field must be filled !!");
                    pdsProductForm.profitFactorAmend.focus();
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

            function searchProduct() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/PdsProductOperationServlet';
                document.forms[0].submit();

            }

            function ActvDeactv() {

                document.forms[0].handle_id.value = "StatusSearch";
                document.forms[0].action = '/PacsApplication/PdsProductOperationServlet';
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
        <jsp:include page="MenuHead_PDS.jsp" flush="true" />
        <br>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object pdsProductCreationBeanObj = request.getAttribute("pdsProductCreationBeanObj");
            pdsProductCreationBean opdsProductCreationBean = new pdsProductCreationBean();
            if (pdsProductCreationBeanObj != null) {
                opdsProductCreationBean = (pdsProductCreationBean) request.getAttribute("pdsProductCreationBeanObj");

            }
        %>

        <form name="pdsProductForm" method="post" action="PdsProductOperationServlet">
            <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

                <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">INVENTORY OPERATIONS</legend>
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
                        <input type="button" value="Submit" onclick="javascript:submitform(pdsProductForm)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                </div>
                <br><br>

                <div id="amend" style="display: none;">
                    <center>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;" >Enter Product Code: </lable>
                        <input type="text" name="inventorySearch"/>
                        <input type="button"  value="Search" onclick="javascript:searchProduct()" />
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
                                        <option value="A" <%if (opdsProductCreationBean.getStatus().equals("A")) {%> selected <%}%>>Active</option>
                                        <option value="I" <%if (opdsProductCreationBean.getStatus().equals("I")) {%> selected <%}%>>Inactive</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Product Name:</td>
                                <td><input type="text" name="productNameAmend" id="productNameAmend" value="<%=blankNull(opdsProductCreationBean.getProductName())%>" /></td>
                            </tr>
                            <tr>
                                <td>Product Code:</td>
                                <td><input type="text" name="productCodeAmend"  id="productCodeAmend" value="<%=blankNull(opdsProductCreationBean.getProductCode())%>" /></td>
                            </tr>
                            <tr>
                                <td>Quantity Unit:</td>
                                <td><select id="unitAmend" name="unitAmend">
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="kg" <%if (opdsProductCreationBean.getUnit().equals("kg")) {%> selected <%}%>>K.g.</option>
                                        <option value="ltr" <%if (opdsProductCreationBean.getUnit().equals("ltr")) {%> selected <%}%>>Lt.</option>
                                        <option value="packet" <%if (opdsProductCreationBean.getUnit().equals("packet")) {%> selected <%}%>>Packets</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Profit Factor (%):</td>
                                <td><input type="text" name="profitFactorAmend"  id="profitFactor" value="<%=blankNull(opdsProductCreationBean.getProfitFactor())%>" /></td>
                            </tr>

                            <tr><td><br></td></tr>
                            <tr><td><br></td></tr>
                            <tr><td><label>All fields are mandatory</label></td></tr>
                        </tbody>
                    </table><br><br>

                    <br><br>
                    <input type="hidden" name="product_id" value="<%=blankNull(opdsProductCreationBean.getProduct_id())%>"/>
                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(pdsProductForm)">
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

            </fieldset>
        </form>
    </body>
</html>
