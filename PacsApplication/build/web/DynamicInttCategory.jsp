<%-- 
    Document   : DynamicInttCategory
    Created on : Mar 9, 2016, 6:27:36 PM
    Author     : Tcs Helpdesk10
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DataEntryBean.AccountCreationBean"%>
<%@page import="DataEntryBean.GlProductOperationBean"%>
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
            try {
                AccountCreationBean oAccountCreationBean = new AccountCreationBean();
                ArrayList<AccountCreationBean> alAccountCreationBean = new ArrayList<AccountCreationBean>();
                String str = request.getParameter("handle_id");
                statement = connection.createStatement();
                rs = statement.executeQuery("select prod_code,prod_desc,int_cat,intt_cat_desc from dep_product where prod_code='" + str + "'");
                while(rs.next()){
                  
                oAccountCreationBean = new AccountCreationBean();
                oAccountCreationBean.setId(str);
                oAccountCreationBean.setProductCode(rs.getString("prod_code"));
                oAccountCreationBean.setProductName(rs.getString("prod_desc"));
                oAccountCreationBean.setInttCategory(rs.getString("int_cat"));
                oAccountCreationBean.setInttDescription(rs.getString("intt_cat_desc"));
                
                alAccountCreationBean.add(oAccountCreationBean);
                
                }
                
                request.setAttribute("oAccountCreationBeanObj", alAccountCreationBean);
                request.setAttribute("flag", 'Y');
                request.getRequestDispatcher("/accountCreation.jsp").forward(request, response);
                statement.close();
                connection.close();

            } catch (Exception e) {
            }

        %>  
    </body>
</html>
