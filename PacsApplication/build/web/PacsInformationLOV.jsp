<%-- 
    Document   : PACSinformationLOV
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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PACS Information Search</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        
        <%
               
               String searchString = request.getParameter("DccbCode");
               String lovKey = request.getParameter("lovKey");   
               String headerQry        =   "select p.pacs_id,p.pacs_name from pacs_master p where p.dccb_code= '" + searchString + "'";
               //System.out.println(headerQry);
               Connection conn         =   DbHandler.getDBConnection();
               PreparedStatement pstmt =   null;

               ResultSet resultSet     =   null;
               String bgColor = null;
               int flag = 1;

               try {
                   pstmt       = conn.prepareStatement(headerQry);
                   resultSet   = pstmt.executeQuery();

            %>
   </head>
    <body style="background-image: url('/PacsApplication/img/download.jpg');">
       <form name="cifLOV" action="">
                  <table border="2">
                        <tr><th style="background-color: #99FF99;"><b>PACS ID</b></th><th style="background-color: #99FF99;"><b>PACS NAME</b></th></tr>
                        <%int i = 0;
                        while(resultSet.next())
                        {
                            i++;
                            if(flag==1)
                            {
                                flag=0;
                                bgColor="#AFC7C7";
                                } else {
                                flag=1;
                                bgColor="#95B9C7";
                             }%>
                         <% if (lovKey.equalsIgnoreCase("update")) {%>
                        <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.userMaintainanceForm.pacsIdAmend.value=document.getElementById('x<%=i%>').innerHTML+':'+document.getElementById('y<%=i%>').innerHTML; self.close();opener.document.userMaintainanceForm.pacsIdUpdated.value=document.getElementById('x<%=i%>').innerHTML; self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td><td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.userMaintainanceForm.pacsIdAmend.value=document.getElementById('x<%=i%>').innerHTML+':'+document.getElementById('y<%=i%>').innerHTML; self.close();opener.document.userMaintainanceForm.pacsIdUpdated.value=document.getElementById('x<%=i%>').innerHTML; self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td></tr>
                        
                        <%} else if (lovKey.equalsIgnoreCase("create")) {%>
                        
                         <tr><td bgcolor='<%=bgColor%>' id='x<%=i%>' onclick="opener.document.userMaintainanceForm.pacsName.value=document.getElementById('x<%=i%>').innerHTML+':'+document.getElementById('y<%=i%>').innerHTML; self.close();opener.document.userMaintainanceForm.pacsId.value=document.getElementById('x<%=i%>').innerHTML; self.close();" style="cursor:pointer;"><%=resultSet.getString(1)%></td><td bgcolor='<%=bgColor%>' id='y<%=i%>' onclick="opener.document.userMaintainanceForm.pacsName.value=document.getElementById('x<%=i%>').innerHTML+':'+document.getElementById('y<%=i%>').innerHTML; self.close();opener.document.userMaintainanceForm.pacsId.value=document.getElementById('x<%=i%>').innerHTML; self.close();" style="cursor:pointer;"><%=resultSet.getString(2)%></td></tr>
                        <%}%>
                        <%}%>
                  </table>
            </form>
    </body>
    <%
              } catch(Exception ex) {
                  //System.out.println(ex);
              } finally {
                  if(resultSet != null)
                      resultSet.close();
                  if(pstmt != null)
                      pstmt.close();
                  if(conn != null)
                      conn.close();
              }
      %>
</html>
