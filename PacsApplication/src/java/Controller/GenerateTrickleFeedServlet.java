/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import LoginDb.DbHandler;
import java.util.*;
import java.util.logging.Logger;
import java.util.logging.Level;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 590685
 */
public class GenerateTrickleFeedServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GenerateTrickleFeedServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GenerateTrickleFeedServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
        } finally {
            out.close();
        }
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

        HttpSession session = request.getSession(false);
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");

        try {
            con = DbHandler.getDBConnection();
            try {
                proc = con.prepareCall("{ call PACS_TRICKLE_FEED_GENERATION(?,?) }");
            } catch (SQLException ex) {
                Logger.getLogger(GenerateTrickleFeedServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            proc.setString(1, pacsId);
            proc.registerOutParameter(2, java.sql.Types.VARCHAR);

            proc.execute();

            //Outfile File Name

            String Outfile = proc.getString(2);

            TrickleFeedFileMover oTrickleFeedFileMover = new TrickleFeedFileMover();
            oTrickleFeedFileMover.TrickleFeedFileMover(Outfile, pacsId);

            message = "Trickle Feed File Generated Successfully";

        } catch (SQLException ex) {
            Logger.getLogger(GenerateTrickleFeedServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                proc.close();
            } catch (SQLException e) {

                message = "Error Occured in Trickle Feed File Generation";

            }
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(GenerateTrickleFeedServlet.class.getName()).log(Level.SEVERE, null, ex);

                message = "Error Occured in Trickle Feed File Generation";
            }

            request.setAttribute("message", message);
            request.getRequestDispatcher("/pacsFileUpload.jsp").forward(request, response);

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
