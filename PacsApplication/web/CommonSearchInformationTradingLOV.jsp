<%-- 
    Document   : CommonSearchInformationTradingLOV
    Created on : Mar 10, 2016, 2:30:36 AM
    Author     : SUBHAM
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Connection"%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Information Search</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />

        <%
            String searchString1 = "";
            String screenName = "";
            String searchString2 = "";
            String lovKey = "";
            String textIndex = "";

            screenName = request.getParameter("screenName");
            lovKey = request.getParameter("lovKey");
            String pacsId = session.getAttribute("pacsId").toString();
            String productId = request.getParameter("productId");

            String headerQry = null;

            if (screenName.equalsIgnoreCase("tradingProductCreation.jsp") && (lovKey.equalsIgnoreCase("prodDetails"))) {

                searchString1 = request.getParameter("inventorySearch");
                if (searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst";
                } else if (!searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst where PRODUCT_CODE like '%" + searchString1.replace(' ', '%') + "%' ";
                }

            } else if (screenName.equalsIgnoreCase("raisePurchaseOrder.jsp") && (lovKey.equalsIgnoreCase("prodDetails"))) {

                searchString1 = request.getParameter("trading_code");
                if (searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst";
                } else if (!searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst where PRODUCT_CODE like '%" + searchString1.replace(' ', '%') + "%' ";
                }

            } else if (screenName.equalsIgnoreCase("TradingStockRegister.jsp") && (lovKey.equalsIgnoreCase("TrandingProductSearch"))) {

                textIndex = request.getParameter("textIndex");

                headerQry = "select id,product_name,product_code from trading_product_mst";
            } else if (screenName.equalsIgnoreCase("TradingStockRegister.jsp") && (lovKey.equalsIgnoreCase("purchaseOrderSearch"))) {

                textIndex = request.getParameter("textIndex");
                searchString1 = request.getParameter("product_id");
                if (!searchString1.equalsIgnoreCase("")) {
                    headerQry = "select m.product_name, m.product_code, t.purchase_ref_no,t.price,t.quantity_base,t.total from trading_purchase_order t,trading_product_mst m "
                            + " where t.product_id=m.id and  t.product_id like '%" + searchString1.replace(' ', '%') + "%' and t.purchase_ref_no not in (select vpurchaseref from trading_stock_register) and  t.pacs_id='" + pacsId + "'";
                }

            } else if (screenName.equalsIgnoreCase("SellItem.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {

                searchString1 = request.getParameter("memberId");
                searchString2 = request.getParameter("memberName");

                if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t";
                } else if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t where trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t  where cif_no like '%" + searchString1.replace(' ', '%') + "%'";
                } else {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t  where cif_no like '%" + searchString1.replace(' ', '%') + "%' and trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%'";
                }

            } else if (screenName.equalsIgnoreCase("SellItem.jsp") && (lovKey.equalsIgnoreCase("TrandingProductSearch"))) {

                textIndex = request.getParameter("textIndex");

                headerQry = "select p.id,product_name,product_code,s.id as stock_id,round(((p.profit_factor*s.price)/100)+s.price,2) as price,s.quantity_available,s.id as Stock_ID "
                        + "  from trading_stock_register s,trading_product_mst p where s.product_id=p.id and s.pacs_id='" + pacsId + "' ";
            } else if (screenName.equalsIgnoreCase("SalesRegister.jsp") && (lovKey.equalsIgnoreCase("TradingProductSearch"))) {

                headerQry = "select distinct(s.id),p.id,p.product_code,p.product_name from trading_sale_details s,trading_product_mst p where s.product_id = p.id and s.pacs_id='" + pacsId + "' ";

            } else if (screenName.equalsIgnoreCase("TradingStockTransfer.jsp") && (lovKey.equalsIgnoreCase("pacsSearch"))) {

                textIndex = request.getParameter("textIndex");
                headerQry = "select p.pacs_id,p.pacs_name from pacs_master p where p.pacs_id not in '" + pacsId + "' ";

            } else if (screenName.equalsIgnoreCase("TradingStockTransfer.jsp") && (lovKey.equalsIgnoreCase("TrandingProductSearch"))) {

                textIndex = request.getParameter("textIndex");

                headerQry = "select p.id,p.product_name,p.product_code,s.quantity_available,s.price,s.id from trading_product_mst p,trading_stock_register s where p.id=s.product_id and s.pacs_id=" + pacsId;
            }

            Connection conn = DbHandler.getDBConnection();
            PreparedStatement pstmt = null;

            ResultSet resultSet = null;
            String bgColor = null;
            int flag = 1;

            try {
                pstmt = conn.prepareStatement(headerQry);
                resultSet = pstmt.executeQuery();

        %>
    </head>
    <body style="background-image: url('/PacsApplication/img/download.jpg');">
        <form name="commonSearch" action="">

            <% if ((screenName.equalsIgnoreCase("tradingProductCreation.jsp")) && (lovKey.equalsIgnoreCase("prodDetails"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product ID</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.tradingProductForm.inventorySearch.value = document.getElementById('z<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.tradingProductForm.inventorySearch.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.tradingProductForm.inventorySearch.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>



                </tr>
                <%}%>
            </table><%} else if ((screenName.equalsIgnoreCase("raisePurchaseOrder.jsp")) && (lovKey.equalsIgnoreCase("prodDetails"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product ID</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.tradingPurchaseOrder.trading_code.value = document.getElementById('z<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.tradingPurchaseOrder.trading_code.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.tradingPurchaseOrder.trading_code.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>



                </tr>
                <%}%>
            </table><%} else if (screenName.equalsIgnoreCase("TradingStockRegister.jsp") && (lovKey.equalsIgnoreCase("TrandingProductSearch"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product ID</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>


                </tr>
                <%}%>
            </table> <%} else if (screenName.equalsIgnoreCase("TradingStockRegister.jsp") && (lovKey.equalsIgnoreCase("purchaseOrderSearch"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th><th style="background-color: #99FF99;"><b>Purchase Ref No</b></th><th style="background-color: #99FF99;"><b>Price/Unit</b></th><th style="background-color: #99FF99;"><b>Quantity</b></th><th style="background-color: #99FF99;"><b>Total</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('Prefno<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('quantity<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('total<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('Prefno<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('quantity<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('total<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('Prefno<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('quantity<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('total<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('Prefno<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('quantity<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('total<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('Prefno<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('quantity<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('total<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td bgcolor='<%=bgColor%>' id='c<%=i%>' onclick="opener.document.getElementById('Prefno<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('quantity<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('total<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(6)%></td>

                </tr>
                <%}%>
            </table> <%} else if (screenName.equalsIgnoreCase("SellItem.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Member ID</b></th><th style="background-color: #99FF99;"><b>Member Name</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.tradingsaleitem.memberId.value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.tradingsaleitem.memberName.value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.tradingsaleitem.memberId.value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.tradingsaleitem.memberName.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("SellItem.jsp") && (lovKey.equalsIgnoreCase("TrandingProductSearch"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product ID</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th><th style="background-color: #99FF99;"><b>Stock ID</b></th><th style="background-color: #99FF99;"><b>Quantity Available</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td  bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('quantity_avl<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('p_order_id<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('quantity_avl<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('p_order_id<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('quantity_avl<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('p_order_id<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('quantity_avl<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('p_order_id<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='c<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('quantity_avl<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('p_order_id<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(6)%></td>
                    <td style="display:none" bgcolor='<%=bgColor%>' id='b<%=i%>'  style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td style="display:none" bgcolor='<%=bgColor%>' id='d<%=i%>'  style="cursor:pointer;"><%=resultSet.getString(7)%></td>

                </tr>
                <%}%>
            </table> <%} else if ((screenName.equalsIgnoreCase("SalesRegister.jsp")) && (lovKey.equalsIgnoreCase("TradingProductSearch"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>SALE ID</b></th><th style="background-color: #99FF99;"><b>ID</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.tradingsaleregister.itemCode.value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.tradingsaleregister.itemName.value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.tradingsaleregister.productId.value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.tradingsaleregister.sellId.value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.tradingsaleregister.itemCode.value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.itemName.value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.productId.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.sellId.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.tradingsaleregister.itemCode.value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.itemName.value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.productId.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.sellId.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.tradingsaleregister.itemCode.value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.itemName.value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.productId.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.tradingsaleregister.sellId.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>



                </tr>
                <%}%>
            </table>
            <%} else if ((screenName.equalsIgnoreCase("TradingStockTransfer.jsp")) && (lovKey.equalsIgnoreCase("pacsSearch"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>PACS ID</b></th><th style="background-color: #99FF99;"><b>PACS Name</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('toPacsName<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('toPacsId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('toPacsName<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('toPacsId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>

                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("TradingStockTransfer.jsp") && (lovKey.equalsIgnoreCase("TrandingProductSearch"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product ID</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th><th style="background-color: #99FF99;"><b>Stock Quantity</b></th><th style="background-color: #99FF99;"><b>Price/Unit</b></th></tr>
                        <%int i = 0;
                            while (resultSet.next()) {
                                i++;
                                if (flag == 1) {
                                    flag = 0;
                                    bgColor = "#AFC7C7";
                                } else {
                                    flag = 1;
                                    bgColor = "#95B9C7";
                                }%>
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('stockQuantity<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockQuantity<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockQuantity<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockQuantity<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('stockQuantity<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('stockId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td style="display:none" bgcolor='<%=bgColor%>' id='c<%=i%>'  style="cursor:pointer;"><%=resultSet.getString(6)%></td>


                </tr>
                <%}%>
            </table> <%}%>
        </form>
    </body>    
    <%
        } catch (Exception ex) {
            //System.out.println(ex);
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    %>

</html>
