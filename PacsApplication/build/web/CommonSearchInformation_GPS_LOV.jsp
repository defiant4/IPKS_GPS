<%-- 
    Document   : CommonSearchInformation_GPS_LOV
    Created on : Jul 14, 2016, 11:36:14 AM
    Author     : Tcs Help desk122
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

            if (screenName.equalsIgnoreCase("MasterRollEnrollment.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {

                searchString1 = request.getParameter("memberId");
                searchString2 = request.getParameter("memberName");
                if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select ID,Name from master_roll_enrollment where  upper(name) like upper('%" + searchString2.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select ID,Name from master_roll_enrollment where id like '%" + searchString1.replace(' ', '%') + "%' and pacs_id='" + pacsId + "'";
                } else if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select ID,Name from master_roll_enrollment where pacs_id='" + pacsId + "'";
                } else {
                    headerQry = "select ID,Name from master_roll_enrollment where id like '%" + searchString1.replace(' ', '%') + "%' and upper(name) like upper('%" + searchString2.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                }
            }

            if (screenName.equalsIgnoreCase("CommodityMaster.jsp") && (lovKey.equalsIgnoreCase("CommodityMasterDetails"))) {

                headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where pacs_id='" + pacsId + "' ";
            } else if (screenName.equalsIgnoreCase("GovtOrderCreation.jsp") && (lovKey.equalsIgnoreCase("GovtOrderDetails"))) {

                textIndex = request.getParameter("textIndex");
                headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc,unit from gps_commodity_master where pacs_id='" + pacsId + "' ";
            } else if (screenName.equalsIgnoreCase("ItemProcurement.jsp") && (lovKey.equalsIgnoreCase("ItemProcurementDetails"))) {

                textIndex = request.getParameter("textIndex");
                searchString1 = request.getParameter("orderId");

                headerQry = "select c.id,c.item_type,c.item_subtype,c.type_desc,c.subtype_desc,c.unit,p.quantity_available,p.rate_unit from gps_commodity_master c ,gps_govt_proc_detail p where c.id=p.commodity_id and p.order_id='" + searchString1 + "' and pacs_id='" + pacsId + "' ";
            } else if (screenName.equalsIgnoreCase("sellregister.jsp") && (lovKey.equalsIgnoreCase("itemdetails"))) {

                searchString1 = request.getParameter("itemType");
                searchString2 = request.getParameter("itemSubType");
                if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where upper(subtype_desc) like upper('%" + searchString2.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where upper(type_desc) like upper('%" + searchString1.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                } else if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where pacs_id='" + pacsId + "'";
                } else {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where upper(type_desc) like upper('%" + searchString1.replace(' ', '%') + "%') and upper(subtype_desc) like upper('%" + searchString2.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                }
            } else if (screenName.equalsIgnoreCase("ProcurementRegister.jsp") && (lovKey.equalsIgnoreCase("procuredetails"))) {

                searchString1 = request.getParameter("itemType");
                searchString2 = request.getParameter("itemSubType");
                if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where upper(subtype_desc) like upper('%" + searchString2.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where upper(type_desc) like upper('%" + searchString1.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                } else if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where pacs_id='" + pacsId + "'";
                } else {
                    headerQry = "select id,item_type,type_desc,item_subtype,subtype_desc from gps_commodity_master where upper(type_desc) like upper('%" + searchString1.replace(' ', '%') + "%') and upper(subtype_desc) like upper('%" + searchString2.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                }
            } else if (screenName.equalsIgnoreCase("ItemProcurement.jsp") && (lovKey.equalsIgnoreCase("masterdetails"))) {

                searchString1 = request.getParameter("masterId");
                searchString2 = request.getParameter("masterName");
                if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,name from master_roll_enrollment where upper(name) like upper('%" + searchString2.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,name from master_roll_enrollment where id like upper('%" + searchString1.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                } else if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select id,name from master_roll_enrollment where pacs_id='" + pacsId + "'";
                } else {
                    headerQry = "select id,name from master_roll_enrollment where upper(name) like upper('%" + searchString2.replace(' ', '%') + "%') and id like upper('%" + searchString1.replace(' ', '%') + "%') and pacs_id='" + pacsId + "'";
                }
            } else if (screenName.equalsIgnoreCase("GovtOrderCreation.jsp") && (lovKey.equalsIgnoreCase("Orderdetails"))) {

                headerQry = "select id,order_code from gps_govt_proc_header where pacs_id='" + pacsId + "'";

            } else if (screenName.equalsIgnoreCase("SellProcureItem.jsp") && (lovKey.equalsIgnoreCase("SellProcureDetails"))) {

                textIndex = request.getParameter("textIndex");
                searchString1 = request.getParameter("govtProcId");

                headerQry = "select c.id,c.item_type,c.type_desc,c.item_subtype,c.subtype_desc,g.procurement_id,c.unit,p.rate_unit,g.available_quantity from gps_commodity_master c ,gps_govt_proc_detail p,GPS_ITEM_PROCUREMENT g where c.id=p.commodity_id and c.id=g.COMMODITY_ID and p.order_id='" + searchString1 + "' and g.pacs_id='" + pacsId + "' ";

            } else if (screenName.equalsIgnoreCase("SellProcureItem.jsp") && (lovKey.equalsIgnoreCase("govtprocuredetails"))) {

                headerQry = "select id,order_code from gps_govt_proc_header where pacs_id='" + pacsId + "'";

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

            <%if (screenName.equalsIgnoreCase("MasterRollEnrollment.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>ID</b></th><th style="background-color: #99FF99;"><b>Member Name</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('nameAmend').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('IdAmend').value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('nameAmend').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('IdAmend').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>

                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("CommodityMaster.jsp") && (lovKey.equalsIgnoreCase("CommodityMasterDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Commodity ID</b></th><th style="background-color: #99FF99;"><b>Item Type</b></th><th style="background-color: #99FF99;"><b>Type Desc</b></th><th style="background-color: #99FF99;"><b>Item SubType</b></th><th style="background-color: #99FF99;"><b>Subtype Desc</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('itemTypeAmend').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('itemDescAmend').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('CommodityIdAmend').value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('itemTypeAmend').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemDescAmend').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('CommodityIdAmend').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('itemTypeAmend').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemDescAmend').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('CommodityIdAmend').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('itemTypeAmend').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemDescAmend').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('CommodityIdAmend').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('itemTypeAmend').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemDescAmend').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('CommodityIdAmend').value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>


                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("GovtOrderCreation.jsp") && (lovKey.equalsIgnoreCase("GovtOrderDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Commodity ID</b></th><th style="background-color: #99FF99;"><b>Item Type</b></th><th style="background-color: #99FF99;"><b>Type Desc</b></th><th style="background-color: #99FF99;"><b>Item SubType</b></th><th style="background-color: #99FF99;"><b>Subtype Desc</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td style="display:none" bgcolor='<%=bgColor%>' id='c<%=i%>'  style="cursor:pointer;"><%=resultSet.getString(6)%></td>

                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("ItemProcurement.jsp") && (lovKey.equalsIgnoreCase("ItemProcurementDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Commodity ID</b></th><th style="background-color: #99FF99;"><b>Item Type</b></th><th style="background-color: #99FF99;"><b>Item SubType</b></th><th style="background-color: #99FF99;"><b>Unit</b></th><th style="background-color: #99FF99;"><b>Available Quantity</b></th><th style="background-color: #99FF99;"><b>Rate/Unit</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('qty_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('rate_per_unit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('qty_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('rate_per_unit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                            opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('qty_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('rate_per_unit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                            opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td bgcolor='<%=bgColor%>' id='c<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('qty_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('rate_per_unit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                            opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(6)%></td>
                    <td bgcolor='<%=bgColor%>' id='d<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('qty_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('rate_per_unit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                            opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(7)%></td>
                    <td bgcolor='<%=bgColor%>' id='e<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('b<%=i%>').innerHTML;
                            opener.document.getElementById('qty_unit<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            opener.document.getElementById('rate_per_unit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                            opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(8)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>'  style="display:none;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>'  style="display:none;"><%=resultSet.getString(3)%></td>

                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("sellregister.jsp") && (lovKey.equalsIgnoreCase("itemdetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Commodity ID</b></th><th style="background-color: #99FF99;"><b>Item Type</b></th><th style="background-color: #99FF99;"><b>Type Desc</b></th><th style="background-color: #99FF99;"><b>Subtype Item</b></th><th style="background-color: #99FF99;"><b>Subtype Desc</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('itemtypeDesc').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('itemsubtypeDesc').value = document.getElementById('b<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtypeDesc').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtypeDesc').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtypeDesc').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtypeDesc').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtypeDesc').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtypeDesc').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtypeDesc').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtypeDesc').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>


                </tr>
                <%}%>
            </table>

            <%} else if (screenName.equalsIgnoreCase("ProcurementRegister.jsp") && (lovKey.equalsIgnoreCase("procuredetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Commodity ID</b></th><th style="background-color: #99FF99;"><b>Item Type</b></th><th style="background-color: #99FF99;"><b>Type Desc</b></th><th style="background-color: #99FF99;"><b>Subtype Item</b></th><th style="background-color: #99FF99;"><b>Subtype Desc</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('itemtype').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('itemsubtype').value = document.getElementById('b<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtype').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtype').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtype').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtype').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtype').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtype').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('commodityId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('itemTypeId').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('itemtype').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('itemSubTypeId').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('itemsubtype').value = document.getElementById('b<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>


                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("ItemProcurement.jsp") && (lovKey.equalsIgnoreCase("masterdetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Master ID</b></th><th style="background-color: #99FF99;"><b>Master Name</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('musterRollId').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('name').value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('musterRollId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('name').value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>


                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("GovtOrderCreation.jsp") && (lovKey.equalsIgnoreCase("Orderdetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Order ID</b></th><th style="background-color: #99FF99;"><b>Order Code</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('govtOrderId').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('govtOrderCode').value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('govtOrderId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('govtOrderCode').value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>


                </tr>
                <%}%>
            </table>

            <%} else if (screenName.equalsIgnoreCase("SellProcureItem.jsp") && (lovKey.equalsIgnoreCase("SellProcureDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Commodity ID</b></th><th style="background-color: #99FF99;"><b>Item Type</b><th style="background-color: #99FF99;"><b>Type Description</b></th></th><th style="background-color: #99FF99;"><b>Item SubType</b></th><th style="background-color: #99FF99;"><b>SubType Description</b></th><th style="background-color: #99FF99;"><b>Procurement ID</b></th><th style="background-color: #99FF99;"><b>Unit</b></th><th style="background-color: #99FF99;"><b>Rate/Unit</b></th><th style="background-color: #99FF99;"><b>Quantity</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                     <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                   
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    
                    <td bgcolor='<%=bgColor%>' id='c<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(6)%></td>
                    <td bgcolor='<%=bgColor%>' id='d<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(7)%></td>
                    <td bgcolor='<%=bgColor%>' id='e<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(8)%></td>
                    <td bgcolor='<%=bgColor%>' id='f<%=i%>' onclick="opener.document.getElementById('commodityId<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('item_desc<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('subtype_desc<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                        opener.document.getElementById('procId<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        opener.document.getElementById('item_unit<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('item_rateperunit<%=textIndex%>').value = document.getElementById('e<%=i%>').innerHTML;
                        opener.document.getElementById('qty<%=textIndex%>').value = document.getElementById('f<%=i%>').innerHTML;
                        opener.document.getElementById('item_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('item_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(9)%></td>

                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("SellProcureItem.jsp") && (lovKey.equalsIgnoreCase("govtprocuredetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Procurement ID</b></th><th style="background-color: #99FF99;"><b>Procurement Code</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('govtProcId').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('govProcCode').value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('govtProcId').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('govProcCode').value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>


                </tr>
                <%}%>
            </table>
            <%}%>
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
