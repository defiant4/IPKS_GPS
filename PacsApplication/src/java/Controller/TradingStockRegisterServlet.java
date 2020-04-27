/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

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
public class TradingStockRegisterServlet extends HttpServlet {

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
        TrandinStockRegisterBean oTrandinStockRegisterBean = null;
        ResultSet rs = null;
        ArrayList<TrandinStockRegisterBean> alTrandinStockRegisterBean = new ArrayList<TrandinStockRegisterBean>();

        if (handle_id.equalsIgnoreCase("Create")) {

            int counter = Integer.parseInt(request.getParameter("rowCounter"));

            for (int i = 1; i <= counter; i++) {
                try {

                    String productId = request.getParameter("product_id" + i);
                    String productName = request.getParameter("product" + i);
                    String price = request.getParameter("price" + i);
                    String quantity = request.getParameter("quantity" + i);
                    String linetotal = request.getParameter("total" + i);
                    String expiaryDate = request.getParameter("stkexpirayDate" + i);
                    String perishableFlag = request.getParameter("selectperish" + i);
                    String purchaseRefNo = request.getParameter("Prefno" + i);

                    if (productId != null) {
                        oTrandinStockRegisterBean = new TrandinStockRegisterBean();
                        oTrandinStockRegisterBean.setProductId(productId);
                        oTrandinStockRegisterBean.setProductName(productName);
                        oTrandinStockRegisterBean.setPrice(price);
                        oTrandinStockRegisterBean.setQuantity(quantity);
                        oTrandinStockRegisterBean.setTotal(linetotal);
                        oTrandinStockRegisterBean.setStockExpDate(expiaryDate);
                        oTrandinStockRegisterBean.setPerishableFlag(perishableFlag);
                        oTrandinStockRegisterBean.setPurchaseOrderRef(purchaseRefNo);

                        alTrandinStockRegisterBean.add(oTrandinStockRegisterBean);
                    }
                } catch (Exception e) {
                }
            }
            if (alTrandinStockRegisterBean.size() > 0) {

                for (int j = 0; j < alTrandinStockRegisterBean.size(); j++) {

                    oTrandinStockRegisterBean = alTrandinStockRegisterBean.get(j);
                    try {
                        con = DbHandler.getDBConnection();
                        try {
                            proc = con.prepareCall("{ call Trading_Operation.trading_Stock_register(?,?,?,?,?,?,?,?,?,?) }");
                        } catch (SQLException ex) {
                            Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        proc.setString(1, oTrandinStockRegisterBean.getProductId());
                        proc.setString(2, oTrandinStockRegisterBean.getStockExpDate());
                        proc.setString(3, oTrandinStockRegisterBean.getPerishableFlag());
                        proc.setString(4, oTrandinStockRegisterBean.getPurchaseOrderRef());
                        proc.setString(5, pacsId);
                        proc.setString(6, handle_id);
                        proc.setString(7, oTrandinStockRegisterBean.getPrice());
                        proc.setString(8, oTrandinStockRegisterBean.getQuantity());
                        proc.setString(9, oTrandinStockRegisterBean.getTotal());

                        proc.registerOutParameter(10, java.sql.Types.VARCHAR);

                        
                        proc.execute();

                        message = proc.getString(10);

                    } catch (SQLException ex) {
                        Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                            Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                            System.out.println(ex.toString());
                        }
                    }
                }
            }
            request.setAttribute("message", message);
            request.getRequestDispatcher("/Trading_JSP/TradingStockRegister.jsp").forward(request, response);

        } else if (handle_id.equalsIgnoreCase("checkStock")) {

            String toDate = request.getParameter("toDate");
            String fromDate = request.getParameter("fromDate");
            String productName = request.getParameter("productName");
            oTrandinStockRegisterBean = new TrandinStockRegisterBean();
            oTrandinStockRegisterBean.setToDate(toDate);
            oTrandinStockRegisterBean.setFromDate(fromDate);
            oTrandinStockRegisterBean.setProductId(productName);
            int searchFound = 0;
            try {
                con = DbHandler.getDBConnection();
                proc = con.prepareCall("{ call Trading_Operation.trading_View_Stock_register(?,?,?,?,?,?) }");
                proc.setString(1, oTrandinStockRegisterBean.getProductId());
                proc.setString(2, oTrandinStockRegisterBean.getToDate());
                proc.setString(3, oTrandinStockRegisterBean.getFromDate());
                proc.setString(4, pacsId);
                proc.registerOutParameter(5, OracleTypes.CURSOR);
                proc.registerOutParameter(6, java.sql.Types.VARCHAR);
                proc.execute();
                message = proc.getString(6);
                rs = (ResultSet) proc.getObject(5);

                while (rs.next()) {
                    searchFound = 1;
                    oTrandinStockRegisterBean = new TrandinStockRegisterBean();
                    oTrandinStockRegisterBean.setProductName(rs.getString(1));
                    oTrandinStockRegisterBean.setProductId(rs.getString(2));
                    oTrandinStockRegisterBean.setUnit(rs.getString(3));
                    oTrandinStockRegisterBean.setPurchaseOrderRef(rs.getString(4));
                    oTrandinStockRegisterBean.setStockCreateDate(rs.getString(5));
                    oTrandinStockRegisterBean.setPrice(rs.getString(6));
                    oTrandinStockRegisterBean.setQuantity(rs.getString(7));
                    oTrandinStockRegisterBean.setQuantityAbled(rs.getString(8));
                    oTrandinStockRegisterBean.setQuantityAvailable(rs.getString(9));
                    oTrandinStockRegisterBean.setStockId(rs.getString(10));

                    alTrandinStockRegisterBean.add(oTrandinStockRegisterBean);
                    request.setAttribute("displayFlag", "Y");
                }

                if (searchFound == 0) {

                    message = "No Stock Exists for the selected criteria";
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

                request.setAttribute("alTrandinStockRegisterBeanApend", alTrandinStockRegisterBean);
            request.getRequestDispatcher("/Trading_JSP/TradingStockRegister.jsp").forward(request, response);

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
