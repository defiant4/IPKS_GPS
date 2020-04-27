/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.TradingSaleRegisterBean;
import DataEntryBean.TrandinStockRegisterBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Tcs Help desk122
 */
public class TradingSaleRegisterServlet extends HttpServlet {

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
        String handle_id = request.getParameter("handle_id");
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");
        TradingSaleRegisterBean tradingSaleRegisterBeanObj = null;
        ResultSet rs = null;
        ArrayList<TradingSaleRegisterBean> alTradingSaleRegisterBean = new ArrayList<TradingSaleRegisterBean>();

         if (handle_id.equalsIgnoreCase("checkStock")) {

            String productId = request.getParameter("productId");
            String sellId = request.getParameter("sellId");
            tradingSaleRegisterBeanObj = new TradingSaleRegisterBean();
            tradingSaleRegisterBeanObj.setProductId(productId);
            tradingSaleRegisterBeanObj.setSellId(sellId);
            int searchFound = 0;
            try {
                con = DbHandler.getDBConnection();
                proc = con.prepareCall("{ call Trading_Operation.trading_sale_register(?,?,?,?) }");
                proc.setString(1, tradingSaleRegisterBeanObj.getSellId());
                proc.setString(2, pacsId);
                proc.registerOutParameter(3, OracleTypes.CURSOR);
                proc.registerOutParameter(4, java.sql.Types.VARCHAR);
                proc.execute();
                message = proc.getString(4);
                rs = (ResultSet) proc.getObject(3);

                while (rs.next()) {
                    searchFound = 1;
                    tradingSaleRegisterBeanObj = new TradingSaleRegisterBean();
                    tradingSaleRegisterBeanObj.setMemberId(rs.getString(1));
                    tradingSaleRegisterBeanObj.setMemberName(rs.getString(2));
                    tradingSaleRegisterBeanObj.setStockId(rs.getString(3));
                    tradingSaleRegisterBeanObj.setQuantity(rs.getString(4));
                    tradingSaleRegisterBeanObj.setPrice(rs.getString(5));
                    tradingSaleRegisterBeanObj.setTotal(rs.getString(6));
                    tradingSaleRegisterBeanObj.setSaleDate(rs.getString(7));

                    alTradingSaleRegisterBean.add(tradingSaleRegisterBeanObj);
                    request.setAttribute("displayFlag", "Y");
                }

                if (searchFound == 0) {

                    message = "No Sale Exists for the selected criteria";
                    request.setAttribute("message", message);

                }

            } catch (SQLException ex) {
                Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex.toString());
            } finally {

                try {
                    proc.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
            }

                request.setAttribute("alTradingSaleRegisterBeanApend", alTradingSaleRegisterBean);
            request.getRequestDispatcher("/Trading_JSP/SalesRegister.jsp").forward(request, response);

        }

    }// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

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
    }
}
