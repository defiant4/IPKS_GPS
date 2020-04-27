/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.tradingPurchaseOrderBean;
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
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author TCS
 */
public class tradingPurchaseOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet kycCreationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet kycCreationServlet at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession(false);
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");
        

        tradingPurchaseOrderBean tradingPurchaseOrderBeanObj = new tradingPurchaseOrderBean();
        try {
            BeanUtils.populate(tradingPurchaseOrderBeanObj, request.getParameterMap());
        } catch (IllegalAccessException ex) {
            Logger.getLogger(kycCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(kycCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            con = DbHandler.getDBConnection();
            try {
                proc = con.prepareCall("{ call Trading_Operation.trading_Purchase_order(?,?,?,?,?,?,?,?) }");
            } catch (SQLException ex) {
                Logger.getLogger(kycCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            proc.setString(1, tradingPurchaseOrderBeanObj.getTrading_ref_no());
            proc.setString(2, tradingPurchaseOrderBeanObj.getTrading_code());
            proc.setString(3, tradingPurchaseOrderBeanObj.getTrading_purchase_desc());
            proc.setString(4, tradingPurchaseOrderBeanObj.getUnit());
            proc.setString(5, tradingPurchaseOrderBeanObj.getUnit_price());
            proc.setString(6, tradingPurchaseOrderBeanObj.getTotal());
            proc.setString(7, pacsId);
            
            proc.registerOutParameter(8, java.sql.Types.VARCHAR);

            proc.execute();

            message = proc.getString(8);

        } catch (SQLException ex) {
            Logger.getLogger(kycCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(kycCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex.toString());
            }
        }
        
         request.setAttribute("message", message);
         request.getRequestDispatcher("/Trading_JSP/RaisePurchaseOrder.jsp").forward(request, response);

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
