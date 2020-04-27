/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.UserMaintainanceBean;
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
 * @author SUBHAM
 */
public class UserMaintenanceServlet extends HttpServlet {

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

        Connection con = null;
        CallableStatement proc = null;
        String message = "";

        String ServletName = request.getParameter("handle_id");

        UserMaintainanceBean oUserMaintainanceBean = new UserMaintainanceBean();

        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oUserMaintainanceBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call user_maintenance.Upsert_user_details(?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oUserMaintainanceBean.getTellerId());
                proc.setString(2, oUserMaintainanceBean.getTellerName());
                proc.setString(3, oUserMaintainanceBean.getPacsId());
                proc.setString(4, oUserMaintainanceBean.getUserType());
                proc.setString(5, oUserMaintainanceBean.getUserStatus());
                proc.setString(6, oUserMaintainanceBean.getMobileNumber());
                proc.setString(7, ServletName);
                proc.registerOutParameter(8, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(8);

            } catch (SQLException ex) {
                Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/userMaintenance.jsp").forward(request, response);

            }

        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oUserMaintainanceBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select t.login_id,t.login_name,t.pacs_id,m.pacs_id||':'||m.pacs_name pacsDetails,t.user_status,r.role_code,t.mobile_no,m.dccb_code from login_details t,sys_roles r,pacs_master m where t.pacs_id=m.pacs_id and r.id=t.user_role_id and t.login_id= '" + oUserMaintainanceBean.getTellerIdSearch() + "'");

                while (rs.next()) {

                    oUserMaintainanceBean.setTellerName(rs.getString("login_name"));
                    oUserMaintainanceBean.setPacsId(rs.getString("pacs_id"));
                    oUserMaintainanceBean.setPacsDetails(rs.getString("pacsDetails"));
                    oUserMaintainanceBean.setUserStatus(rs.getString("user_status"));
                    oUserMaintainanceBean.setUserType(rs.getString("role_code"));
                    oUserMaintainanceBean.setMobileNumber(rs.getString("mobile_no"));
                    oUserMaintainanceBean.setDccbCode(rs.getString("dccb_code"));
                    oUserMaintainanceBean.setTellerId(rs.getString("login_id"));
                    oUserMaintainanceBean.setCheckOption("update");

                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");

                }

                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Teller ID not exists in the system";
                request.setAttribute("message", message);
            }
            request.setAttribute("oUserMaintainanceBeanObj", oUserMaintainanceBean);

            request.getRequestDispatcher("/userMaintenance.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oUserMaintainanceBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call user_maintenance.Upsert_user_details(?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oUserMaintainanceBean.getTellerIdAmend());
                proc.setString(2, oUserMaintainanceBean.getTellerNameAmend());
                proc.setString(3, request.getParameter("pacsIdUpdated"));
                proc.setString(4, oUserMaintainanceBean.getUserTypeAmend());
                proc.setString(5, oUserMaintainanceBean.getUserStatusAmend());
                proc.setString(6, oUserMaintainanceBean.getMobileNumberAmend());
                proc.setString(7, ServletName);
                proc.registerOutParameter(8, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(8);

            } catch (SQLException ex) {
                Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/userMaintenance.jsp").forward(request, response);

            }

        } else if ("ResetPassword".equalsIgnoreCase(ServletName)) {
            try {
                BeanUtils.populate(oUserMaintainanceBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call user_maintenance.password_reset(?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oUserMaintainanceBean.getTellerIdReset());
                proc.registerOutParameter(2, java.sql.Types.VARCHAR);
                proc.execute();
               
                message =  proc.getString(2);

            } catch (SQLException ex) {
                Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserMaintenanceServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/userMaintenance.jsp").forward(request, response);

            }
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
            throws ServletException, IOException {
        processRequest(request, response);
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
