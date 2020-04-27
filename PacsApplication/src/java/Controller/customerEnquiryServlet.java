/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.customerEnquiryBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author Kaushik
 */
public class customerEnquiryServlet extends HttpServlet {

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
            throws ServletException, IOException {
        //processRequest(request, response);
        String cifNumber = request.getParameter("cifNumber");
        String flag = "N";
        Connection connection = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        Statement statement = null;
        connection = DbHandler.getDBConnection();
        int SeachFound = 0;
        String message = "";

        customerEnquiryBean ocustomerEnquiryBean = new customerEnquiryBean();

        try {
            BeanUtils.populate(ocustomerEnquiryBean, request.getParameterMap());
        } catch (IllegalAccessException ex) {
            Logger.getLogger(customerEnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(customerEnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery("select cif_no,"
                    + "customer_type,"
                    + "linked_sb_accno,"
                    + "title,"
                    + "first_name,"
                    + "middle_name,"
                    + "last_name,"
                    + "guardian_name,"
                    + "address_1,"
                    + "address_2,"
                    + "address_3,"
                    + "district,"
                    + "city,"
                    + "state,"
                    + "birth_date,"
                    + "gender,"
                    + "mobile_no,"
                    + "id_type,"
                    + "id_no,"
                    + "to_char(id_issue_date,'DD-MON-YYYY') as id_issue_date,"
                    + "id_issued_at from kyc_details where cif_no='" + cifNumber + "'");

            while (rs.next()) {

                ocustomerEnquiryBean.setCif(rs.getString("cif_no"));
                ocustomerEnquiryBean.setcType(rs.getString("customer_type"));
                ocustomerEnquiryBean.setLinkedAccount(rs.getString("linked_sb_accno"));
                ocustomerEnquiryBean.setTittle(rs.getString("title"));
                ocustomerEnquiryBean.setfName(rs.getString("first_name"));
                ocustomerEnquiryBean.setmName(rs.getString("middle_name"));
                ocustomerEnquiryBean.setlName(rs.getString("last_name"));
                ocustomerEnquiryBean.setgName(rs.getString("guardian_name"));
                ocustomerEnquiryBean.setAdd1(rs.getString("address_1"));
                ocustomerEnquiryBean.setAdd2(rs.getString("address_2"));
                ocustomerEnquiryBean.setAdd3(rs.getString("address_3"));
                ocustomerEnquiryBean.setDistname(rs.getString("district"));
                ocustomerEnquiryBean.setCityname(rs.getString("city"));
                ocustomerEnquiryBean.setStatename(rs.getString("state"));
                ocustomerEnquiryBean.setDob(rs.getString("birth_date"));
                ocustomerEnquiryBean.setGender(rs.getString("gender"));
                ocustomerEnquiryBean.setmNumber(rs.getString("mobile_no"));
                ocustomerEnquiryBean.setIdType(rs.getString("id_type"));
                ocustomerEnquiryBean.setIdNumber(rs.getString("id_no"));
                ocustomerEnquiryBean.setIdIssueDate(rs.getString("id_issue_date"));
                ocustomerEnquiryBean.setIdIssueAt(rs.getString("id_issued_at"));

                SeachFound = 1;
                
                request.setAttribute("flag", "Y");

            }
            statement.close();
            connection.close();

            if (SeachFound == 0) {
                message = "CIF Details not exists in the system";
                request.setAttribute("message", message);
            }

            request.setAttribute("ocustomerEnquiryBeanObj", ocustomerEnquiryBean);
            
            request.getRequestDispatcher("/customerEnquiry.jsp").forward(request, response);

        } catch (Exception e) {

        }

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
