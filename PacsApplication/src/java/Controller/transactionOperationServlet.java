/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.transactionOperationBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Shubhrangshu
 */
public class transactionOperationServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet transactionOperationServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet transactionOperationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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
        //processRequest(request, response);
        
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        HttpSession session = request.getSession();
        
        transactionOperationBean otransactionOperationBean = new transactionOperationBean();
        
        try {
                BeanUtils.populate(otransactionOperationBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(transactionOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(transactionOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    if(otransactionOperationBean.getTranType().equalsIgnoreCase("1")){
                        proc = con.prepareCall("{ call operations.post_kcc_rep_txn(?,?,?,?,?) }");
                    }
                    else
                    {
                        proc = con.prepareCall("{ call operations.post_kcc_disb_txn(?,?,?,?,?) }");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(transactionOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                String pacsId=session.getAttribute("pacsId").toString();
                proc.setString(1, pacsId);
                proc.setString(2, otransactionOperationBean.getAccNo());
                proc.setString(3, null);
                proc.setString(4, otransactionOperationBean.getTrAmount());
                proc.registerOutParameter(5, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(5);

            } catch (SQLException ex) {
                Logger.getLogger(transactionOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(transactionOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/transactionOperation.jsp").forward(request, response);

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
