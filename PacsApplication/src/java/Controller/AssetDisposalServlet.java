/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tcs Helpdesk10
 */
public class AssetDisposalServlet extends HttpServlet {

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
       HttpSession session = request.getSession(false);
        String pacsId = (String) session.getAttribute("pacsId");
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        String asset_id = request.getParameter("asset_id");
        String disposeflag = request.getParameter("disposeflag");
        String regid = request.getParameter("regid");

        try {
            con = DbHandler.getDBConnection();
            try {
                proc = con.prepareCall("{ call ASSET_OPERATION.asset_disposal(?,?,?,?,?) }");
            } catch (SQLException ex) {
                Logger.getLogger(AssetDisposalServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            proc.setString(1, asset_id);
            proc.setString(2, disposeflag);
            proc.setString(3, regid);
            proc.setString(4,pacsId);
            
            proc.registerOutParameter(5, java.sql.Types.VARCHAR);

            proc.execute();

            message = proc.getString(5);

        } catch (SQLException ex) {
            Logger.getLogger(AssetDisposalServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                proc.close();
            } catch (SQLException e) {
            }
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(AssetDisposalServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.setAttribute("message", message);
            request.getRequestDispatcher("/Asset_JSP/assetDisposal.jsp").forward(request, response);

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
