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
import java.sql.Statement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
public class SodServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con = null;
        Statement st = null;
        CallableStatement proc = null;
        String message = "";
        try {
            con = DbHandler.getDBConnection();
            try {
                proc = con.prepareCall("{ call EODSOD.proc_sod(?) }");
            } catch (SQLException ex) {
                Logger.getLogger(SodServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            proc.registerOutParameter(1, java.sql.Types.VARCHAR);
            proc.executeUpdate();
            
            message = proc.getString(1);
        } catch (Exception e) {
        }

        request.setAttribute("message", message);
         request.getRequestDispatcher("/sod.jsp").forward(request, response);
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
