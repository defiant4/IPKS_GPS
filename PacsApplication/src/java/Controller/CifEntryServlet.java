/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DataEntryBean.*;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.beanutils.*;
import org.apache.commons.logging.*;
import org.apache.commons.collections.*;
import java.sql.*;
import LoginDb.DbHandler;


/**
 *
 * @author SUBHAM
 */
public class CifEntryServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code.
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CifEntryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CifEntryServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");*/
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {

        //Taking the servlet name from JSP
        String ServletName=request.getParameter("action");

        CustomerInfBean oCustomerInfBean=new CustomerInfBean();

        if ("Search".equalsIgnoreCase(ServletName))

        {

            try {
                    BeanUtils.populate(oCustomerInfBean, request.getParameterMap());
                } catch (IllegalAccessException ex) {
                    Logger.getLogger(CifEntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                } catch (InvocationTargetException ex) {
                    Logger.getLogger(CifEntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }


                Connection connection = null;
                ResultSet resultset = null;
                Statement statement = null;
                connection =DbHandler.getDBConnection();
                try {
                    statement = connection.createStatement();
                } catch (SQLException ex) {
                    Logger.getLogger(CifEntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    //look at " for table name
                    ResultSet rs = statement.executeQuery("SELECT id,customer_type,title,first_name,middle_name,last_name,gurdian_name, mother_maiden_name, address_1, address_2, address_3, district, city_code, state_code, country, language_known, post_box_number, phone_no_home, phone_no_business, to_char(birth_date,'DD-MON-YYYY') as birth_date, gender, mobile_no, fax, nationality, domicile, occupancy, resident_status,marital_status FROM customer_information_details where id= '" + oCustomerInfBean.getCif() + "'");
                    while (rs.next())
            {

                        oCustomerInfBean.setCif(rs.getString("id"));
                        oCustomerInfBean.setCtype(rs.getString("customer_type"));
                        oCustomerInfBean.setTitle(rs.getString("title"));
                        oCustomerInfBean.setFname(rs.getString("first_name"));
                        oCustomerInfBean.setMname(rs.getString("middle_name"));
                        oCustomerInfBean.setCityname(rs.getString("city_code"));
                        oCustomerInfBean.setCountryname(rs.getString("country"));
                        oCustomerInfBean.setDistname(rs.getString("district"));
                        oCustomerInfBean.setDob(rs.getString("birth_date"));
                        oCustomerInfBean.setDomicile(rs.getString("domicile"));
                        oCustomerInfBean.setFax(rs.getString("fax"));
                        oCustomerInfBean.setFlatno(rs.getString("address_1"));
                        oCustomerInfBean.setFsname(rs.getString("gurdian_name"));
                        oCustomerInfBean.setGencode(rs.getString("gender"));
                        oCustomerInfBean.setLanguage(rs.getString("language_known"));
                        oCustomerInfBean.setLname(rs.getString("last_name"));
                        oCustomerInfBean.setLocalityname(rs.getString("address_3"));
                        oCustomerInfBean.setMob(rs.getString("mobile_no"));
                        oCustomerInfBean.setMstatus(rs.getString("marital_status"));
                        oCustomerInfBean.setMthname(rs.getString("mother_maiden_name"));
                        oCustomerInfBean.setNationality(rs.getString("nationality"));
                        oCustomerInfBean.setOccupation(rs.getString("occupancy"));
                        oCustomerInfBean.setPhbusiness(rs.getString("phone_no_business"));
                        oCustomerInfBean.setResstatus(rs.getString("resident_status"));
                        oCustomerInfBean.setPhhome(rs.getString("phone_no_home"));
                        oCustomerInfBean.setStatename(rs.getString("state_code"));
                        oCustomerInfBean.setStreetname(rs.getString("address_2"));
                        oCustomerInfBean.setTitle(rs.getString("title"));
                        oCustomerInfBean.setPostcode(rs.getString("post_box_number"));


            }
                statement.close();
                connection.close();

                } catch (SQLException ex) {
                    Logger.getLogger(CifEntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }


                
        }
           request.setAttribute("oCustomerInfBeanobj", oCustomerInfBean);
           (request.getRequestDispatcher("/ShowCifDetails.jsp")).forward(request, response);
    }

    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
