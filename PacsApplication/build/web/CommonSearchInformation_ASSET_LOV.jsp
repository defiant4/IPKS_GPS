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

            if (screenName.equalsIgnoreCase("assetEntry.jsp") && (lovKey.equalsIgnoreCase("AssetCodeSearch"))) {

                    textIndex = request.getParameter("textIndex");

                    headerQry = "select ID,ASSET_TYPE,TYPE_DESC,ASSET_SUBTYPE,SUBTYPE_DESC from ASSET_MASTER";
                } else if (screenName.equalsIgnoreCase("assetRegister.jsp") && (lovKey.equalsIgnoreCase("assetDetails"))) {

                    searchString1 = request.getParameter("asset_type");
                    searchString2 = request.getParameter("asset_subtype");

                    if (searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                        headerQry = "select id,asset_type,type_desc,asset_subtype,subtype_desc from asset_master";
                    } else if (searchString1.equalsIgnoreCase("") && !searchString2.equalsIgnoreCase("")) {
                        headerQry = "select id,asset_type,type_desc,asset_subtype,subtype_desc from asset_master where asset_type like '%" + searchString2.replace(' ', '%') + "%'";
                    } else if (!searchString1.equalsIgnoreCase("") && searchString2.equalsIgnoreCase("")) {
                        headerQry = "select id,asset_type,type_desc,asset_subtype,subtype_desc from asset_master where asset_type like '%" + searchString1.replace(' ', '%') + "%'";
                    } else {
                        headerQry = "select id,asset_type,type_desc,asset_subtype,subtype_desc from asset_master where asset_type like '%" + searchString1.replace(' ', '%') + "%' and asset_subtype like '%" + searchString2.replace(' ', '%') + "%'";
                    }

                } else if ((screenName.equalsIgnoreCase("assetDisposal.jsp")) && (lovKey.equalsIgnoreCase("assetDisposalDetails"))) {

                    searchString1 = request.getParameter("asset_id");

                    if (searchString1.equalsIgnoreCase("")) {
                        headerQry = "select id,asset_id,description from asset_register";
                    } else if (!searchString1.equalsIgnoreCase("")) {
                        headerQry = "select id,asset_id,description from asset_register where upper(asset_id) like upper('%" + searchString1.replace(' ', '%') + "%') ";
                    }
                } else if ((screenName.equalsIgnoreCase("assetRelocation.jsp")) && (lovKey.equalsIgnoreCase("assetRelocationDetails"))) {

                    searchString1 = request.getParameter("asset_id");

                    if (searchString1.equalsIgnoreCase("")) {
                        headerQry = "select id,asset_id,description from asset_register";
                    } else if (!searchString1.equalsIgnoreCase("")) {
                        headerQry = "select id,asset_id,description from asset_register where upper(asset_id) like upper('%" + searchString1.replace(' ', '%') + "%') ";
                    }
                } else if ((screenName.equalsIgnoreCase("assetRelocation.jsp")) && (lovKey.equalsIgnoreCase("assetRelocationDetails2"))) {

                    searchString1 = request.getParameter("pacsName");

                    if (searchString1.equalsIgnoreCase("")) {
                        headerQry = "select PACS_ID,PACS_NAME from pacs_master where pacs_id not in '"+pacsId+"' ";
                    } else if (!searchString1.equalsIgnoreCase("")) {
                        headerQry = "select PACS_ID,PACS_NAME from pacs_master where upper(PACS_NAME) like upper('%" + searchString1.replace(' ', '%') + "%') and  pacs_id not in '"+pacsId+"' ";
                    }
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

            <%if (screenName.equalsIgnoreCase("assetEntry.jsp") && (lovKey.equalsIgnoreCase("AssetCodeSearch"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>ID</b></th><th style="background-color: #99FF99;"><b>Asset Type</b></th><th style="background-color: #99FF99;"><b>Asset Type Desc</b></th><th style="background-color: #99FF99;"><b>Asset SubType</b></th><th style="background-color: #99FF99;"><b>Asset SubType Desc</b></th></tr>
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
                         <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.getElementById('asset_mst_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                    opener.document.getElementById('asset_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                    opener.document.getElementById('asset_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.getElementById('asset_mst_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                    opener.document.getElementById('asset_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                    opener.document.getElementById('asset_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.getElementById('asset_mst_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                    opener.document.getElementById('asset_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                    opener.document.getElementById('asset_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.getElementById('asset_mst_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                    opener.document.getElementById('asset_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':'+document.getElementById('z<%=i%>').innerHTML;
                    opener.document.getElementById('asset_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.getElementById('asset_mst_id<%=textIndex%>').value = document.getElementById('x<%=i%>').innerHTML;
                    opener.document.getElementById('asset_type<%=textIndex%>').value = document.getElementById('y<%=i%>').innerHTML + ':' + document.getElementById('z<%=i%>').innerHTML;
                    opener.document.getElementById('asset_subtype<%=textIndex%>').value = document.getElementById('a<%=i%>').innerHTML + ':' + document.getElementById('b<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                </tr>
                <%}%>
            </table>
            <%}else if (screenName.equalsIgnoreCase("assetRegister.jsp") && (lovKey.equalsIgnoreCase("assetDetails"))) {%>
            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>Asset_MST_ID</b></th><th style="background-color: #99FF99;"><b>Asset Type</b></th><th style="background-color: #99FF99;"><b>Type Desc</b></th><th style="background-color: #99FF99;"><b>Asset SubType</b></th><th style="background-color: #99FF99;"><b>SubType Desc</b></th></tr>
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
                <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.assetregister.asset_type.value = document.getElementById('y<%=i%>').innerHTML;
                    opener.document.assetregister.asset_subtype.value = document.getElementById('a<%=i%>').innerHTML;
                    opener.document.assetregister.asset_mst_id.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                    <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.assetregister.asset_type.value = document.getElementById('y<%=i%>').innerHTML;
                    opener.document.assetregister.asset_subtype.value = document.getElementById('a<%=i%>').innerHTML;
                    opener.document.assetregister.asset_mst_id.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                    <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.assetregister.asset_type.value = document.getElementById('y<%=i%>').innerHTML;
                    opener.document.assetregister.asset_subtype.value = document.getElementById('a<%=i%>').innerHTML;
                    opener.document.assetregister.asset_mst_id.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                    <td bgcolor='<%=bgColor%>' id='a<%=i%>' onclick="opener.document.assetregister.asset_type.value = document.getElementById('y<%=i%>').innerHTML;
                    opener.document.assetregister.asset_subtype.value = document.getElementById('a<%=i%>').innerHTML;
                    opener.document.assetregister.asset_mst_id.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(4)%></td>
                    <td bgcolor='<%=bgColor%>' id='b<%=i%>' onclick="opener.document.assetregister.asset_type.value = document.getElementById('y<%=i%>').innerHTML;
                    opener.document.assetregister.asset_subtype.value = document.getElementById('a<%=i%>').innerHTML;
                    opener.document.assetregister.asset_mst_id.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(5)%></td>
                </tr>
                <%}%>
            </table>
           <%}else if ((screenName.equalsIgnoreCase("assetDisposal.jsp")) && (lovKey.equalsIgnoreCase("assetDisposalDetails"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>ID</b></th><th style="background-color: #99FF99;"><b>ASSET_ID</b></th><th style="background-color: #99FF99;"><b>Description</b></th></tr>
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
                        <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.assetdisposalform.asset_id.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetdisposalform.regid.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                        <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.assetdisposalform.asset_id.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetdisposalform.regid.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                        <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.assetdisposalform.asset_id.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetdisposalform.regid.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                       



                </tr>
                <%}%>
            </table>
            <%}else if ((screenName.equalsIgnoreCase("assetRelocation.jsp")) && (lovKey.equalsIgnoreCase("assetRelocationDetails"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>ID</b></th><th style="background-color: #99FF99;"><b>ASSET_ID</b></th><th style="background-color: #99FF99;"><b>Description</b></th></tr>
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
                        <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.assetrelocationform.asset_id.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetrelocationform.regid.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                        <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.assetrelocationform.asset_id.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetrelocationform.regid.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td>
                        <td bgcolor='<%=bgColor%>' id='z<%=i%>' onclick="opener.document.assetrelocationform.asset_id.value = document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetrelocationform.regid.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(3)%></td>
                 
                </tr>
                <%}%>
            </table>
            <%}else if ((screenName.equalsIgnoreCase("assetRelocation.jsp")) && (lovKey.equalsIgnoreCase("assetRelocationDetails2"))) {%>

            <table border="2">
                <tr><th style="background-color: #99FF99;"><b>PACS ID</b></th><th style="background-color: #99FF99;"><b>PACS NAME</b></th></tr>
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
                        <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.assetrelocationform.pacsName.value = document.getElementById('x<%=i%>').innerHTML +':'+document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetrelocationform.pacs_mst_id.value = document.getElementById('x<%=i%>').innerHTML;
                    self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td>
                        <td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.assetrelocationform.pacsName.value = document.getElementById('x<%=i%>').innerHTML+':'+document.getElementById('y<%=i%>').innerHTML;
                            opener.document.assetrelocationform.pacs_mst_id.value = document.getElementById('x<%=i%>').innerHTML;
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
