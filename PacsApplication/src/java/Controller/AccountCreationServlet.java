/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.AccountCreationBean;
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
 * @author Tcs Helpdesk10
 */
public class AccountCreationServlet extends HttpServlet {

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

        HttpSession session = request.getSession(false);
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");

        //String ServletName = request.getParameter("handle_id");
        AccountCreationBean oAccountCreationBean = new AccountCreationBean();
        try {
            BeanUtils.populate(oAccountCreationBean, request.getParameterMap());
        } catch (IllegalAccessException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            con = DbHandler.getDBConnection();
            try {
                proc = con.prepareCall("{ call operations.create_dep_account(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
            } catch (SQLException ex) {
                Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            proc.setString(1, pacsId);
            proc.setString(2, oAccountCreationBean.getProductCode());
            proc.setString(3, oAccountCreationBean.getInttCategory());
            proc.setString(4, oAccountCreationBean.getCifNumber());
            proc.setString(5, oAccountCreationBean.getCustomerType());
            proc.setString(6, oAccountCreationBean.getLimit());
            proc.setString(7, oAccountCreationBean.getLimitExpiryDate());
            proc.setString(8, oAccountCreationBean.getCollateralType());
            proc.setString(9, oAccountCreationBean.getLandinAcres());
            proc.setString(10, oAccountCreationBean.getDescription());
            proc.setString(11, oAccountCreationBean.getCurrentValuation());
            proc.setString(12, oAccountCreationBean.getSafeLendingMargin());
            proc.setString(13, user);
            proc.setString(14, oAccountCreationBean.getSegmentCode());
            proc.setString(15, oAccountCreationBean.getCbsSavingsAccount());
            proc.setString(15, oAccountCreationBean.getCbsSavingsAccount());
            proc.setString(16, oAccountCreationBean.getActivityCode());
            proc.registerOutParameter(17, java.sql.Types.VARCHAR);
            proc.registerOutParameter(18, java.sql.Types.VARCHAR);

            proc.execute();

            message = proc.getString(18);

        } catch (SQLException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.toString());
        } finally {
            try {
                proc.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex.toString());
            }

            request.setAttribute("message", message);
            request.getRequestDispatcher("/accountCreation.jsp").forward(request, response);

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
