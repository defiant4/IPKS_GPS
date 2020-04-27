<%-- 
    Document   : CommonSearchInformationLOV
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

            if ((screenName.equalsIgnoreCase("accountCreation.jsp")) && (lovKey.equalsIgnoreCase("CifDetails"))) {

                searchString1 = request.getParameter("cifNumber");
                headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,linked_sb_accno,nvl(customer_type,' '),address_1,nvl(address_1,' '),nvl(address_2,' '), nvl(address_3,'') from kyc_details t,pacs_master m "
                        + "  where cif_no like '%" + searchString1.replace(' ', '%') + "%' and m.cbs_br_code=t.cbs_br_code and m.pacs_id= '" + pacsId + "' ";

            } else if (screenName.equalsIgnoreCase("customerEnquiry.jsp")) {

                searchString1 = request.getParameter("cifNumber");
                searchString2 = request.getParameter("cifName");

                if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,linked_sb_accno,customer_type,nvl(address_1,' '),nvl(address_2,' '), nvl(address_3,' ') from kyc_details t";
                } else if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,linked_sb_accno,customer_type,nvl(address_1,' '),nvl(address_2,' '), nvl(address_3,' ') from kyc_details t where trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,linked_sb_accno,customer_type,address_1,nvl(address_1,' '),nvl(address_2,' '), nvl(address_3,'') from kyc_details t  where cif_no like '%" + searchString1.replace(' ', '%') + "%'";
                } else {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,linked_sb_accno,customer_type,nvl(address_1,' '),nvl(address_2,' '), nvl(address_3,' ') from kyc_details t  where cif_no like '%" + searchString1.replace(' ', '%') + "%' and trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%'";
                }

            } else if ((screenName.equalsIgnoreCase("accountCreation.jsp")) && (lovKey.equalsIgnoreCase("productCodeSearch"))) {

                searchString1 = request.getParameter("productCodeDetails");

                headerQry = "select prod_code,prod_desc,int_cat,intt_cat_desc from dep_product ";

            } else if ((screenName.equalsIgnoreCase("AdhocReport.jsp")) && (lovKey.equalsIgnoreCase("reportSearch"))) {

                searchString1 = request.getParameter("reportId");

                headerQry = "select report_id,report_name from pacs_adhoc_report where report_id like '%" + searchString1.replace(' ', '%') + "%' ";

            } else if ((screenName.equalsIgnoreCase("transactionOperation.jsp")) && (lovKey.equalsIgnoreCase("depositAccount"))) {

                searchString1 = request.getParameter("accNo");

                headerQry = "select t.key_1,(k.first_name||nvl2(k.middle_name,' '||k.middle_name,'')||nvl2(k.last_name,' '||k.last_name,'')),t.customer_no,t.link_accno  "
                        + " from dep_account t,kyc_details k where k.cif_no=t.customer_no and t.link_accno=k.linked_sb_accno and t.key_1 like '%" + searchString1.replace(' ', '%') + "%' and t.pacs_id= '" + pacsId + "'   ";

            } else if ((screenName.equalsIgnoreCase("accountRenewal.jsp")) && (lovKey.equalsIgnoreCase("renewalAccNumberSearch"))) {

                searchString1 = request.getParameter("cifNumber");
                searchString2 = request.getParameter("ccAccountNo");

                if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select a.customer_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,a.key_1,a.link_accno "
                            + " from dep_account a,kyc_details t where a.customer_no=t.cif_no and a.curr_status!='O' and a.pacs_id= '" + pacsId + "' ";
                } else if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select a.customer_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,a.key_1,a.link_accno "
                            + " from dep_account a,kyc_details t where a.customer_no=t.cif_no and a.curr_status!='O' and a.pacs_id= '" + pacsId + "' and a.key_1 like '%" + searchString2.replace(' ', '%') + "%' ";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select a.customer_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,a.key_1,a.link_accno "
                            + " from dep_account a,kyc_details t where a.customer_no=t.cif_no and a.curr_status!='O'  and a.pacs_id= '" + pacsId + "' and a.key_1 like '%" + searchString1.replace(' ', '%') + "%' ";
                } else {
                    headerQry = "select a.customer_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name,a.key_1,a.link_accno "
                            + " from dep_account a,kyc_details t where a.customer_no=t.cif_no and a.curr_status!='O' and a.pacs_id= '" + pacsId + "' and  a.key_1 like '%" + searchString2.replace(' ', '%') + "%' and a.customer_no like '%" + searchString1.replace(' ', '%') + "%' ";
                }

            } else if ((screenName.equalsIgnoreCase("mark_unmark_NPA_Operations.jsp")) && (lovKey.equalsIgnoreCase("depositAccount"))) {

                searchString1 = request.getParameter("accNo");

                headerQry = "select t.key_1,(k.first_name||nvl2(k.middle_name,' '||k.middle_name,'')||nvl2(k.last_name,' '||k.last_name,'')),t.customer_no,t.link_accno  "
                        + " from dep_account t,kyc_details k where k.cif_no=t.customer_no and t.link_accno=k.linked_sb_accno and t.key_1 like '%" + searchString1.replace(' ', '%') + "%' and t.pacs_id= '" + pacsId + "'   ";

            } else if (screenName.equalsIgnoreCase("memberEnrollment.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {

                searchString1 = request.getParameter("cifNumber");
                searchString2 = request.getParameter("cifName");

                if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t";
                } else if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t where trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t  where cif_no like '%" + searchString1.replace(' ', '%') + "%'";
                } else {
                    headerQry = "select cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t  where cif_no like '%" + searchString1.replace(' ', '%') + "%' and trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%'";
                }

            } else if (screenName.equalsIgnoreCase("raiseRequisition.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {

                searchString1 = request.getParameter("cifNumber");
                searchString2 = request.getParameter("cifName");

                if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                } else if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%' and dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where cif_no like '%" + searchString1.replace(' ', '%') + "%' and dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                } else {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where cif_no like '%" + searchString1.replace(' ', '%') + "%' and trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%' and dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                }

            } else if (screenName.equalsIgnoreCase("purchasedetail.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {

                searchString1 = request.getParameter("cifNumber");
                searchString2 = request.getParameter("cifName");

                if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                } else if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%' and dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where cif_no like '%" + searchString1.replace(' ', '%') + "%' and dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                } else {
                    headerQry = "select t.cif_no,(t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) name from kyc_details t,dep_account dp where cif_no like '%" + searchString1.replace(' ', '%') + "%' and trim(first_name)||trim(middle_name)||trim(last_name) like '%" + searchString2.replace(' ', '%') + "%' and dp.customer_no = t.cif_no and dp.pacs_id = '" + pacsId + "'";
                }

            } else if (screenName.equalsIgnoreCase("raiseRequisition.jsp") && (lovKey.equalsIgnoreCase("PdsProductSearch"))) {

                textIndex = request.getParameter("textIndex");

                headerQry = "select to_char(st.STOCK_ENTRY_DATE,'DD/MM/YYYY'),pd.id as product_id,st.id as stock_id,pd.product_name,pd.product_code,st.QUANTITY_AVL, round((pd.profit_factor*st.price)/100 + st.price,2) "
                        + "from pds_product_mst pd,pds_stock_register st "
                        + "where pd.id=st.product_id and st.pacs_id = '" + pacsId + "' "
                        + "order by pd.product_code, st.STOCK_ENTRY_DATE";
            } else if (screenName.equalsIgnoreCase("pds_stock_register.jsp") && (lovKey.equalsIgnoreCase("PdsProductSearch"))) {

                textIndex = request.getParameter("textIndex");

                headerQry = "select id,product_name,product_code,unit from pds_product_mst";
            } else if (screenName.equalsIgnoreCase("tradingProductCreation.jsp") && (lovKey.equalsIgnoreCase("prodDetails"))) {

                searchString1 = request.getParameter("inventorySearch");
                if (searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst";
                } else if (!searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst where PRODUCT_CODE like '%" + searchString1.replace(' ', '%') + "%' ";
                } 

            }
            
            else if (screenName.equalsIgnoreCase("raisePurchaseOrder.jsp") && (lovKey.equalsIgnoreCase("prodDetails"))) {

                searchString1 = request.getParameter("trading_code");
                if (searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst";
                } else if (!searchString1.equalsIgnoreCase("")) {
                    headerQry = "select id,product_name,product_code from trading_product_mst where PRODUCT_CODE like '%" + searchString1.replace(' ', '%') + "%' ";
                } 

            }
            else if (screenName.equalsIgnoreCase("SalesRegister.jsp") && (lovKey.equalsIgnoreCase("TradingProductSearch"))) {

                searchString1 = request.getParameter("productId");
                headerQry = "select  s.id as sale_id,p.id,p.product_code,p.product_name from trading_product_mst where where s.product_id like '%" + searchString1.replace(' ', '%') + "%' ";
                
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

            <% if ((screenName.equalsIgnoreCase("accountCreation.jsp")) && (lovKey.equalsIgnoreCase("CifDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>CIF Number</b></th><th style="background-color: #99FF99;"><b>Name</b></th><th style="background-color: #99FF99;"><b>Linked CBS Account No.</b></th><th style="background-color: #99FF99;"><b>Customer Type</b></th><th style="background-color: #99FF99;"><b>Address1</b></th><th style="background-color: #99FF99;"><b>Address2</b></th><th style="background-color: #99FF99;"><b>Address3</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.accCreatForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();
                        opener.document.accCreatForm.cbsSavingsAccount.value = document.getElementById('z<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.accCreatForm.cbsSavingsAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.accCreatForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.cbsSavingsAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.accCreatForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.cbsSavingsAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.accCreatForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.cbsSavingsAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td bgcolor='<%=bgColor%>' id='c<%=i%>' onclick="opener.document.accCreatForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.cbsSavingsAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(6)%></td>
                    <td bgcolor='<%=bgColor%>' id='d<%=i%>' onclick="opener.document.accCreatForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.cbsSavingsAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(7)%></td>
                </tr>  
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("customerEnquiry.jsp")) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>CIF Number</b></th><th style="background-color: #99FF99;"><b>Name</b></th><th style="background-color: #99FF99;"><b>Linked CBS Account No.</b></th><th style="background-color: #99FF99;"><b>Customer Type</b></th><th style="background-color: #99FF99;"><b>Address1</b></th><th style="background-color: #99FF99;"><b>Address2</b></th><th style="background-color: #99FF99;"><b>Address3</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.customerEnquiry.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();
                        opener.document.customerEnquiry.cifName.value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td><td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.customerEnquiry.cifName.value = document.getElementById('y<%=i%>').innerHTML;
                                self.close();
                                opener.document.customerEnquiry.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                                self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.customerEnquiry.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.customerEnquiry.cifName.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.customerEnquiry.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.customerEnquiry.cifName.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.customerEnquiry.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.customerEnquiry.cifName.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td bgcolor='<%=bgColor%>' id='c<%=i%>' onclick="opener.document.customerEnquiry.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.customerEnquiry.cifName.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(6)%></td>
                    <td bgcolor='<%=bgColor%>' id='d<%=i%>' onclick="opener.document.customerEnquiry.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.customerEnquiry.cifName.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(7)%></td>
                </tr>
                <%}%>
            </table>

            <%} else if ((screenName.equalsIgnoreCase("accountCreation.jsp")) && (lovKey.equalsIgnoreCase("productCodeSearch"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product Code</b></th><th style="background-color: #99FF99;"><b>Description</b></th><th style="background-color: #99FF99;"><b>Interest Category</b></th><th style="background-color: #99FF99;"><b>Description</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.accCreatForm.productCodeDetails.value = document.getElementById('x<%=i%>').innerHTML + ':' + document.getElementById('y<%=i%>').innerHTML;
                        self.close();
                        opener.document.accCreatForm.inttCatDetails.value = document.getElementById('z<%=i%>').innerHTML + ':' + document.getElementById('a<%=i%>').innerHTML;
                        self.close();
                        opener.document.accCreatForm.productCode.value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();
                        opener.document.accCreatForm.inttCategory.value = document.getElementById('z<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.accCreatForm.productCodeDetails.value = document.getElementById('x<%=i%>').innerHTML + ':' + document.getElementById('y<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.inttCatDetails.value = document.getElementById('z<%=i%>').innerHTML + ':' + document.getElementById('a<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.productCode.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.inttCategory.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.accCreatForm.productCodeDetails.value = document.getElementById('x<%=i%>').innerHTML + ':' + document.getElementById('y<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.inttCatDetails.value = document.getElementById('z<%=i%>').innerHTML + ':' + document.getElementById('a<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.productCode.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.inttCategory.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.accCreatForm.productCodeDetails.value = document.getElementById('x<%=i%>').innerHTML + ':' + document.getElementById('y<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.inttCatDetails.value = document.getElementById('z<%=i%>').innerHTML + ':' + document.getElementById('a<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.productCode.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accCreatForm.inttCategory.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>


                </tr>
                <%}%>
            </table>

            <%} else if ((screenName.equalsIgnoreCase("AdhocReport.jsp")) && (lovKey.equalsIgnoreCase("reportSearch"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Report ID</b></th><th style="background-color: #99FF99;"><b>Report Name</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.Adhocreport.reportID.value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.Adhocreport.reportName.value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.Adhocreport.reportID.value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.Adhocreport.reportName.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>



                </tr>
                <%}%>
            </table>

            <%} else if ((screenName.equalsIgnoreCase("transactionOperation.jsp")) && (lovKey.equalsIgnoreCase("depositAccount"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Account No.</b></th><th style="background-color: #99FF99;"><b>Customer Name</b></th><th style="background-color: #99FF99;"><b>Customer No.</b></th><th style="background-color: #99FF99;"><b>Linked SB A/C No.</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.transactionForm.accNo.value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.transactionForm.accNo.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.transactionForm.accNo.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.transactionForm.accNo.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>



                </tr>
                <%}%>
            </table>

            <% } else if ((screenName.equalsIgnoreCase("accountRenewal.jsp")) && (lovKey.equalsIgnoreCase("renewalAccNumberSearch"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>CIF Number</b></th><th style="background-color: #99FF99;"><b>Name</b></th><th style="background-color: #99FF99;"><b>CC Account No</b></th><th style="background-color: #99FF99;"><b>Linked CBS Account No.</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.accRenewalForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();
                        opener.document.accRenewalForm.ccAccount.value = document.getElementById('z<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>

                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.accRenewalForm.ccAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();
                            opener.document.accRenewalForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.accRenewalForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accRenewalForm.ccAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.accRenewalForm.cifNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();
                            opener.document.accRenewalForm.ccAccount.value = document.getElementById('z<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>

                </tr> 
                <%}%>
            </table>

            <%} else if ((screenName.equalsIgnoreCase("mark_unmark_NPA_Operations.jsp")) && (lovKey.equalsIgnoreCase("depositAccount"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Account No.</b></th><th style="background-color: #99FF99;"><b>Customer Name</b></th><th style="background-color: #99FF99;"><b>Customer No.</b></th><th style="background-color: #99FF99;"><b>Linked SB A/C No.</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.npaOperation.accountNumber.value = document.getElementById('x<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.npaOperation.accountNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.npaOperation.accountNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.npaOperation.accountNumber.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>



                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("memberEnrollment.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {%>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.memberEnrollForm.memberId.value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.memberEnrollForm.custName.value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.memberEnrollForm.memberIdAmend.value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.memberEnrollForm.custNameAmend.value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.memberEnrollForm.memberId.value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.memberEnrollForm.custName.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.memberEnrollForm.memberIdAmend.value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.memberEnrollForm.custNameAmend.value = document.getElementById('y<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("raiseRequisition.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {%>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.validationform.custId.value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.validationform.custName.value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.validationform.custName.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.validationform.custId.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("purchasedetail.jsp") && (lovKey.equalsIgnoreCase("memberDetails"))) {%>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.purchasedetail.custId.value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.purchasedetail.custName.value = document.getElementById('y<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.purchasedetail.custName.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.purchasedetail.custId.value = document.getElementById('x<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("raiseRequisition.jsp") && (lovKey.equalsIgnoreCase("PdsproductSearch"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Purchase Date</b></th><th style="background-color: #99FF99;"><b>Product ID</b></th><th style="background-color: #99FF99;"><b>Stock ID</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th><th style="background-color: #99FF99;"><b>Product Quantity(KG)</b></th><th style="background-color: #99FF99;"><b>Product Price</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                        opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                        opener.document.getElementById('stock_id<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('stock_quantity<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            opener.document.getElementById('stock_id<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('stock_quantity<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            opener.document.getElementById('stock_id<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('stock_quantity<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>

                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            opener.document.getElementById('stock_id<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('stock_quantity<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            opener.document.getElementById('stock_id<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('stock_quantity<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                    <td bgcolor='<%=bgColor%>' id='c<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            opener.document.getElementById('stock_id<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('stock_quantity<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(6)%></td>
                    <td bgcolor='<%=bgColor%>' id='d<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            opener.document.getElementById('price<%=textIndex%>').value = document.getElementById('d<%=i%>').innerHTML;
                            opener.document.getElementById('stock_id<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('stock_quantity<%=textIndex%>').value = document.getElementById('c<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(7)%></td>
                </tr>
                <%}%>
            </table>
            <%} else if (screenName.equalsIgnoreCase("pds_stock_register.jsp") && (lovKey.equalsIgnoreCase("PdsproductSearch"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Product ID</b></th><th style="background-color: #99FF99;"><b>Product Name</b></th><th style="background-color: #99FF99;"><b>Product Code</b></th><th style="background-color: #99FF99;"><b>Quantity Unit</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                        opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.getElementById('unit<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('unit<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('unit<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('product_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                            opener.document.getElementById('product<%=textIndex%>').value = document.getElementById('z<%=i%>').innerHTML;
                            opener.document.getElementById('unit<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML;
                            self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                </tr>
                <%}%>
            </table>
            <%} else if ((screenName.equalsIgnoreCase("tradingProductCreation.jsp")) && (lovKey.equalsIgnoreCase("prodDetails"))) {%>

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
            </table>
            <%} else if ((screenName.equalsIgnoreCase("raisePurchaseOrder.jsp")) && (lovKey.equalsIgnoreCase("prodDetails"))) {%>

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
            </table>
            <%}else if ((screenName.equalsIgnoreCase("SalesRegister.jsp")) && (lovKey.equalsIgnoreCase("TradingProductSearch"))) {%>

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
                        self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.tradingsaleregister.itemCode.value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.tradingsaleregister.itemName.value = document.getElementById('a<%=i%>').innerHTML;
     opener.document.tradingsaleregister.productId.value = document.getElementById('y<%=i%>').innerHTML;                    
    self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.tradingsaleregister.itemCode.value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.tradingsaleregister.itemName.value = document.getElementById('a<%=i%>').innerHTML;
                         opener.document.tradingsaleregister.productId.value = document.getElementById('y<%=i%>').innerHTML;
    self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.tradingsaleregister.itemCode.value = document.getElementById('z<%=i%>').innerHTML;
                        opener.document.tradingsaleregister.itemName.value = document.getElementById('a<%=i%>').innerHTML;
     opener.document.tradingsaleregister.productId.value = document.getElementById('y<%=i%>').innerHTML;                    
    self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>



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
