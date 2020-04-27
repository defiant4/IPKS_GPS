<%-- 
    Document   : DynamicPacsDisplay
    Created on : Mar 9, 2016, 6:27:36 PM
    Author     : Tcs Helpdesk10
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DataEntryBean.UserMaintainanceBean"%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="controller.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dynamic Drop Down</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body>
        <%
            Connection connection = null;
            ResultSet rs = null;
            ResultSet rs_pname = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            String Option = request.getParameter("checkOption");
            int Search = 0;

            if (Option.equalsIgnoreCase("create")) {

                try {
                    UserMaintainanceBean oUserMaintainanceBean = new UserMaintainanceBean();
                    ArrayList<UserMaintainanceBean> alUserMaintainanceBean = new ArrayList<UserMaintainanceBean>();

                    String str = request.getParameter("dccbCode");
                    statement = connection.createStatement();
                    rs = statement.executeQuery("select t.pacs_id,t.pacs_id||':'||t.pacs_name from pacs_master t where t.dccb_code='" + str + "'");
                    while (rs.next()) {
                        oUserMaintainanceBean = new UserMaintainanceBean();

                        oUserMaintainanceBean.setPacsId(rs.getString(1));
                        oUserMaintainanceBean.setPacsDetails(rs.getString(2));

                        alUserMaintainanceBean.add(oUserMaintainanceBean);
                        Search = 1;
                        request.setAttribute("flag", "Y");
                        oUserMaintainanceBean.setDccbCode(str);
                    }

                    
                    oUserMaintainanceBean.setCheckOption("create");
                    if (Search == 0) {
                        request.setAttribute("flag", "N");
                    }
                    request.setAttribute("alUserMaintainanceBean", alUserMaintainanceBean);
                    request.setAttribute("oUserMaintainanceBeanObj", oUserMaintainanceBean);

                    request.getRequestDispatcher("/userMaintenance.jsp").forward(request, response);
                    statement.close();
                    connection.close();

                } catch (Exception e) {
                }
            }


        %>  
    </body>
</html>
