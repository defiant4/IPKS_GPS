/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import LoginDb.*;
import java.io.PrintWriter;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 590685
 */
public class LoginServlet extends HttpServlet {

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
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
        } finally {
            out.close();
        }
    }

    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
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

        // TODO Auto-generated method stub
        HttpSession session = request.getSession(false);

        String user = request.getParameter("UID");
        String pass = request.getParameter("PWD");
        String pacsId = request.getParameter("PACSID");
        String moduleName = request.getParameter("moduleName");

        session.setAttribute("user", user);
        session.setAttribute("pass", pass);
        session.setAttribute("pacsId", pacsId);
        session.setAttribute("moduleName", moduleName);

        String UserName = null;
        String pacsName = null;
        String Login_flag = null;
        String userRole = null;
        String RoleName = null;

        Connection connection = null;
        ResultSet resultset = null;
        Statement statement = null;
        connection = DbHandler.getDBConnection();
        try {
            statement = connection.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (user == null || user.length() == 0 || pass == null || pass.length() == 0) {

            request.setAttribute("error", "Username & Password must not be empty.");

        } else {
            try {
                //pass = LoginDb.passwordEncryption.Encr_pass(pass, "SECRETKEY");

                pass = LoginDb.SimpleCrypt.doEnrcypt(pass);

                String UsrPass = new DbConnection().validateUserLogin(request.getParameter("UID"), request.getParameter("PWD"), request.getParameter("PACSID"));

                if (UsrPass.equals(pass)) {

                    try {

                        ResultSet rs = statement.executeQuery("select l.user_role_id,s.role_name, l.login_name as login_name,p.pacs_name as pacs_name,l.first_login_flag from login_details l,pacs_master p,sys_roles s where l.password='" + pass + "' and l.login_id='" + user + "' and l.pacs_id='" + pacsId + "' and l.pacs_id=p.pacs_id and s.id=l.user_role_id ");
                        while (rs.next()) {

                            UserName = rs.getString("login_name");
                            pacsName = rs.getString("pacs_name");
                            Login_flag = rs.getString("first_login_flag");
                            userRole = rs.getString("user_role_id");
                            RoleName = rs.getString("role_name");

                        }
                        statement.close();
                        connection.close();

                    } catch (SQLException ex) {
                        Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    session.setAttribute("UserName", UserName);
                    session.setAttribute("pacsName", pacsName);
                    session.setAttribute("userRole", userRole);
                    session.setAttribute("RoleName", RoleName);

                    if (Login_flag.equalsIgnoreCase("F")) {

                        (request.getRequestDispatcher("/changePassword.jsp")).forward(request, response);

                    } else {

                        (request.getRequestDispatcher("/welcome.jsp")).forward(request, response);

                    }

                } else {

                    request.setAttribute("error", "Invalid Username/Password/PacsID");
                    (request.getRequestDispatcher("/Login.jsp")).forward(request, response);

                }

            } catch (SQLException e) {
                e.printStackTrace();
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
