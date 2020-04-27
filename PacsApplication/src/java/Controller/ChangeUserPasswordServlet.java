/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import LoginDb.DbHandler;
import LoginDb.SimpleCrypt;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author Shubhrangshu
 */
public class ChangeUserPasswordServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        //processRequest(request, response);
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

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        String newPass = SimpleCrypt.doEnrcypt(request.getParameter("newpass"));
        String login_id = (String) session.getAttribute("user");
        Connection con = null;
        Statement st = null;
        int changePasswordFlag = 0;
        try {
            con = DbHandler.getDBConnection();
            st = con.createStatement();
            ResultSet rs = st.executeQuery("update login_details set password='" + newPass + "',first_login_flag='T' where login_id='" + login_id + "'");
            con.commit();
            changePasswordFlag=1;
        } catch (Exception e) {
        }

        try {
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(ChangeUserPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(ChangeUserPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        session.removeAttribute("user");
        session.invalidate();
        
        
        request.setAttribute("changePasswordFlag", changePasswordFlag);
        request.getRequestDispatcher("./Login.jsp").forward(request, response);
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
