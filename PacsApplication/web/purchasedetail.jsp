<%-- 
    Document   : purchasedetail
    Created on : Jun 24, 2016, 1:41:11 PM
    Author     : Tcs Help desk122
--%>

<%@page import="DataEntryBean.PurchaseDetailBean"%>
<%@page import="java.lang.String"%>
<%@page import="LoginDb.DbHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>


<head>
    <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
    <script>

        function noBack()
        {
            window.history.forward();
        }


    </script>


</head>
<body>

    <%          int count = 1;
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
        
        Object alPurchaseDetailBeanObj = request.getAttribute("alPurchaseDetailBean");
        ArrayList<PurchaseDetailBean> alPurchaseDetailBean = new ArrayList<PurchaseDetailBean>();
        if (alPurchaseDetailBeanObj != null) {
            alPurchaseDetailBean = (ArrayList<PurchaseDetailBean>) request.getAttribute("alPurchaseDetailBean");
        }
        PurchaseDetailBean purchaseDetailBeanObj = new PurchaseDetailBean();
    %>

    <jsp:include page="MenuHead_PDS.jsp" flush="true" />
    <br>
    <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

        <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
            Purchase Details
        </legend>

        <form id="purchasedetail" name="purchasedetail" method="post" action="">

            <%if (!error_msg.equalsIgnoreCase("")) {%>
            <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                        <% }%>
            <br>

            <div id="amend" style="display: block;">
                <center>
                    <table>
                        <tr>
                            <td>Name: </td>
                            <td> <input type="text" name="custName" id="custName" /></td>
                            <td><input type="button"  value="Search" onclick="javascript:popup_member(220, 180, document.purchasedetail.custId.value, document.purchasedetail.custName.value)" /></td>
                        </tr>
                        <tr>
                            <td>Member ID: </td>
                            <td><input type="text" name="custId" id="custId" /></td>

                            <td><input type="button"  value="Search" onclick="javascript:popup_member(220, 180, document.purchasedetail.custId.value, document.purchasedetail.custName.value);" /></td>
                        </tr>
                        <tr >
                            <td></td>
                            <td style="text-align:center;"><input type="button"  value="Submit" onclick="javascript:purchase_detail();" /></td>
                            <td style="text-align:left;"><input type="button" value="Reset" name="reset" onclick="ShowParent();" /> </td>
                        </tr>
                    </table>
            </div>


            <%
                if (displayFlag.equalsIgnoreCase("Y")) { 
                  
            %>


            <div id="create" style="display:block;">
                <hr>
                <center>
                    <table id="order-list" style="margin-left: 25px;">
                        <thead class="CSSTableGenerator" >
                            <tr>

                                <td>Member Id</td>
                                <td>Member Name</td>
                                <td>Product Name</td>
                                <td>Quantity</td>
                                <td>Price</td>
                                <td>Total</td>
                                <td>Purchase Date</td>

                            </tr>
                        </thead>

                        <tbody>
                            <% for (int i = 0; i < alPurchaseDetailBean.size(); i++) {
                                    purchaseDetailBeanObj = alPurchaseDetailBean.get(i);
                            %>
                            <tr>

                                <td style="text-align:center;"><input type="text" value="<%=purchaseDetailBeanObj.getMemberId()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=purchaseDetailBeanObj.getMemberName()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=purchaseDetailBeanObj.getProductName()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=purchaseDetailBeanObj.getQuantity()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=purchaseDetailBeanObj.getPrice()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=purchaseDetailBeanObj.getTotal()%>" readonly="true"></td>
                                <td style="text-align:center;"><input type="text" value="<%=purchaseDetailBeanObj.getPurchaseDate()%>" readonly="true"></td>

                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </center>
                <br/><br/>

            </div>


            <%  }%>




        </form>

        <script>


            function purchase_detail()
            {

                var name = document.getElementById("custName").value;
                var memberId = document.getElementById("custId").value;
                if (name == "" || memberId == "") {

                    alert("All Searc Fields are mandatory");
                    return false;
                }
                else {

                    document.forms[0].action = '/PacsApplication/purchaseDetailServlet';
                    document.forms[0].submit();
                }

            }
            
            function ShowParent()
            {
                document.forms[0].action = "purchasedetail.jsp";
                document.forms[0].submit();
            }

            function popup_member(width, height, cifNumber, cifName) {

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
                var screenName = "purchasedetail.jsp";
                var lovKey = "memberDetails"
                popWin = open('CommonSearchInformationLOV.jsp?cifNumber=' + cifNumber + '&cifName=' + cifName + '&screenName=' + screenName + '&lovKey=' + lovKey, 'memberDetails', attr);
                popWin.focus();

            }





        </script>
    </fieldset>
</body>


