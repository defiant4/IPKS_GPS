/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.memberEnrollmentBean;
//import LoginDb.DbHandler;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
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
public class MemberEnrollmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
        int counter;

        String ServletName = request.getParameter("handle_id");

        memberEnrollmentBean omemberEnrollmentBean = new memberEnrollmentBean();
        
        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(omemberEnrollmentBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call RATION_ENROLL.Upsert_member_details(?,?,?,?,?,?,?,?,?) }");//change as required
                } catch (SQLException ex) {
                    Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }


                    proc.setString(1, omemberEnrollmentBean.getMemberId());
                    proc.setString(2, omemberEnrollmentBean.getCustName());
                    proc.setString(3, omemberEnrollmentBean.getFolioNumber());
                    proc.setString(4, omemberEnrollmentBean.getGuardianName());
                    proc.setString(5, omemberEnrollmentBean.getDistrict());
                    proc.setString(6, omemberEnrollmentBean.getDateOfBirth());
                    proc.setString(7, omemberEnrollmentBean.getAddr());
                    proc.setString(8, ServletName);

                    proc.registerOutParameter(9, java.sql.Types.VARCHAR);
                                proc.execute();

                message = proc.getString(9);

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
                request.getRequestDispatcher("/memberEnrollment.jsp").forward(request, response);

            }
        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(omemberEnrollmentBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select MEMBER_ID,NAME,FOLIO_NUMBER,DISTRICT,ADDRESS,to_char(DATE_OF_BIRTH,'dd/mm/yyyy') DATE_OF_BIRTH ,GUARDIAN_NAME from PDS_MEMBERS_DETAILS where MEMBER_ID= '" + omemberEnrollmentBean.getMemberIdAmend()+ "'");

                while (rs.next()) {


                    omemberEnrollmentBean.setMemberId(rs.getString("MEMBER_ID"));
                    omemberEnrollmentBean.setCustName(rs.getString("NAME"));
                    omemberEnrollmentBean.setFolioNumber(rs.getString("FOLIO_NUMBER"));
                    omemberEnrollmentBean.setGuardianName(rs.getString("GUARDIAN_NAME"));
                    omemberEnrollmentBean.setDistrict(rs.getString("DISTRICT"));
                    omemberEnrollmentBean.setDateOfBirth(rs.getString("DATE_OF_BIRTH"));
                    omemberEnrollmentBean.setAddr(rs.getString("ADDRESS"));

                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");

                }

                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Member does not exists in the system";
                request.setAttribute("message", message);
            }
            request.setAttribute("omemberEnrollmentBean", omemberEnrollmentBean);
            
            request.getRequestDispatcher("/memberEnrollment.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(omemberEnrollmentBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call RATION_ENROLL.Upsert_member_details(?,?,?,?,?,?,?,?,?) }");// change as required
                } catch (SQLException ex) {
                    Logger.getLogger(MemberEnrollmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, omemberEnrollmentBean.getMemberIdAmend());
                proc.setString(2, omemberEnrollmentBean.getCustNameAmend());
                proc.setString(3, omemberEnrollmentBean.getFolioNumberAmend());
                proc.setString(4, omemberEnrollmentBean.getGuardianNameAmend());
                proc.setString(5, omemberEnrollmentBean.getDistrictAmend());
                proc.setString(6, omemberEnrollmentBean.getDateOfBirthAmend());
                proc.setString(7, omemberEnrollmentBean.getAddrAmend());

                proc.setString(8, ServletName);

                proc.registerOutParameter(9, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(9);

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
                request.getRequestDispatcher("/memberEnrollment.jsp").forward(request, response);

            }


        }

    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
