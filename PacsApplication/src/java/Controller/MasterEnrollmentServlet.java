/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.masterRollEnrollmentBean;
//import LoginDb.DbHandler;
import LoginDb.DbHandler;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author 1249241
 */
public class MasterEnrollmentServlet extends HttpServlet {

    private Object session;

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

        Connection con = null;
        CallableStatement proc = null;
        String message = "";

        String ServletName = request.getParameter("handle_id");
        String pacsId = (String) request.getSession().getAttribute("pacsId");

        masterRollEnrollmentBean masterRollEnrollmentBeanObj = new masterRollEnrollmentBean();

        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(masterRollEnrollmentBeanObj, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                String memberId = "";
                try {
                    proc = con.prepareCall("{ call GPS_Operation.master_enroll_entry(?,?,?,?,?,?,?,?,?,?) }");//change as required
                } catch (SQLException ex) {
                    Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, masterRollEnrollmentBeanObj.getName());
                proc.setString(2, masterRollEnrollmentBeanObj.getAddress());
                proc.setString(3, masterRollEnrollmentBeanObj.getContactNo());
                proc.setString(4, masterRollEnrollmentBeanObj.getVoter());
                proc.setString(5, masterRollEnrollmentBeanObj.getAdhaar());
                proc.setString(6, masterRollEnrollmentBeanObj.getProduce());
                proc.setString(7, pacsId);
                proc.setString(8, ServletName);
                proc.setString(9, memberId);
                proc.registerOutParameter(10, java.sql.Types.VARCHAR);
                proc.execute();

                message = proc.getString(10);

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/GPS_JSP/MasterRollEnrollment.jsp").forward(request, response);

            }
        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(masterRollEnrollmentBeanObj, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            String memberId = request.getParameter("IdAmend");
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select ID,NAME,ADDRESS,CONTACT_NO,VOTER,ADHAAR,PRODUCE_DETAILS from master_roll_enrollment where id='" + memberId + "' and pacs_id= '" + pacsId + "'");

                while (rs.next()) {

                    masterRollEnrollmentBeanObj.setMemberId(rs.getString("ID"));
                    masterRollEnrollmentBeanObj.setName(rs.getString("NAME"));
                    masterRollEnrollmentBeanObj.setAddress(rs.getString("ADDRESS"));
                    masterRollEnrollmentBeanObj.setContactNo(rs.getString("CONTACT_NO"));
                    masterRollEnrollmentBeanObj.setVoter(rs.getString("VOTER"));
                    masterRollEnrollmentBeanObj.setAdhaar(rs.getString("ADHAAR"));
                    masterRollEnrollmentBeanObj.setProduce(rs.getString("PRODUCE_DETAILS"));
                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");

                }

                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Member does not exists in the system";
                request.setAttribute("message", message);
            }
            request.setAttribute("masterRollEnrollmentBeanObj", masterRollEnrollmentBeanObj);

            request.getRequestDispatcher("/GPS_JSP/MasterRollEnrollment.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(masterRollEnrollmentBeanObj, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call GPS_Operation.master_enroll_entry(?,?,?,?,?,?,?,?,?,?) }");// change as required
                } catch (SQLException ex) {
                    Logger.getLogger(MasterEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, masterRollEnrollmentBeanObj.getName_Amend());
                proc.setString(2, masterRollEnrollmentBeanObj.getAddrAmend());
                proc.setString(3, masterRollEnrollmentBeanObj.getContactnoAmend());
                proc.setString(4, masterRollEnrollmentBeanObj.getVoterAmend());
                proc.setString(5, masterRollEnrollmentBeanObj.getAdhaarAmend());
                proc.setString(6, masterRollEnrollmentBeanObj.getProduceAmend());
                proc.setString(7, pacsId);
                proc.setString(8, ServletName);
                proc.setString(9, masterRollEnrollmentBeanObj.getMemberId());

                proc.registerOutParameter(10, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(10);

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/GPS_JSP/MasterRollEnrollment.jsp").forward(request, response);

            }

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
