/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.TradingStockTransferBean;
import LoginDb.DbHandler;
import java.io.IOException;
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
public class TradingStockTransferServlet extends HttpServlet {

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
        long num = (long)Math.floor(Math.random()*9000000000L)+ 1000000000L;
        String challanId = String.valueOf(num);
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");
        TradingStockTransferBean tradingStockTransferBeanObj = null;
        ResultSet rs = null;
        ArrayList<TradingStockTransferBean> alTradingStockTransferBean = new ArrayList<TradingStockTransferBean>();

        if (handle_id.equalsIgnoreCase("Create")) {

            int counter = Integer.parseInt(request.getParameter("rowCounter"));

            for (int i = 1; i <= counter; i++) {
                try {

                    String toPacsId = request.getParameter("toPacsId" + i);
                    String productId = request.getParameter("product_id" + i);
                    String price = request.getParameter("salePrice" + i);
                    String quantity = request.getParameter("quantity" + i);
                    String total = request.getParameter("total" + i);
                    String transportOption = request.getParameter("transportOption" + i);
                    String transportCost = request.getParameter("transportCost" + i);
                    String stockId = request.getParameter("stockId" + i);

                    
                        tradingStockTransferBeanObj = new TradingStockTransferBean();
                        tradingStockTransferBeanObj.setToPacsId(toPacsId);
                        tradingStockTransferBeanObj.setProductId(productId);
                        tradingStockTransferBeanObj.setSellingRate(price);
                        tradingStockTransferBeanObj.setQuantity(quantity);
                        tradingStockTransferBeanObj.setTotal(total);
                        tradingStockTransferBeanObj.setTransportationType(transportOption);
                        tradingStockTransferBeanObj.setTransportationCost(transportCost);
                        tradingStockTransferBeanObj.setStockId(stockId);

                        alTradingStockTransferBean.add(tradingStockTransferBeanObj);
                    
                } catch (Exception e) {
                }
            }
            if (alTradingStockTransferBean.size() > 0) {

                for (int j = 0; j < alTradingStockTransferBean.size(); j++) {

                    tradingStockTransferBeanObj = alTradingStockTransferBean.get(j);
                    try {
                        con = DbHandler.getDBConnection();
                        try {
                            proc = con.prepareCall("{ call Trading_Operation.trading_Stock_transfer(?,?,?,?,?,?,?,?,?,?,?) }");
                        } catch (SQLException ex) {
                            Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        proc.setString(1, pacsId);
                        proc.setString(2, tradingStockTransferBeanObj.getToPacsId());
                        proc.setString(3, tradingStockTransferBeanObj.getProductId());
                        proc.setString(4, tradingStockTransferBeanObj.getSellingRate());
                        proc.setString(5, tradingStockTransferBeanObj.getQuantity());
                        proc.setString(6, tradingStockTransferBeanObj.getTotal());
                        proc.setString(7, tradingStockTransferBeanObj.getTransportationType());
                        proc.setString(8, tradingStockTransferBeanObj.getTransportationCost());
                        proc.setString(9, tradingStockTransferBeanObj.getStockId());
                        proc.setString(10,challanId);

                        proc.registerOutParameter(11, java.sql.Types.VARCHAR);

                        
                        proc.execute();

                        message = proc.getString(11);

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
            request.getRequestDispatcher("/Trading_JSP/TradingStockTransfer.jsp").forward(request, response);

        } 
        if(handle_id.equalsIgnoreCase("checkStock"))
        {
        
            String productId = request.getParameter("productName");
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            
            tradingStockTransferBeanObj = new TradingStockTransferBean();
            tradingStockTransferBeanObj.setProductId(productId);
            int searchFound = 0;
            try {
                con = DbHandler.getDBConnection();
                proc = con.prepareCall("{ call Trading_Operation.trading_View_Stock_transfer(?,?,?,?,?,?) }");
                proc.setString(1, productId);
                proc.setString(2, fromDate);
                proc.setString(3, toDate);
                proc.setString(4, pacsId);
                proc.registerOutParameter(5, OracleTypes.CURSOR);
                proc.registerOutParameter(6, java.sql.Types.VARCHAR);
                proc.execute();
                message = proc.getString(6);
                rs = (ResultSet) proc.getObject(5);

                while (rs.next()) {
                    searchFound = 1;
                    tradingStockTransferBeanObj = new TradingStockTransferBean();
                    tradingStockTransferBeanObj.setProduct_name(rs.getString(1));
                    tradingStockTransferBeanObj.setProduct_code(rs.getString(2));
                    tradingStockTransferBeanObj.setFromPacsId(rs.getString(3));
                    tradingStockTransferBeanObj.setToPacsId(rs.getString(4));
                    tradingStockTransferBeanObj.setSellingRate(rs.getString(5));
                    tradingStockTransferBeanObj.setQuantity(rs.getString(6));
                    tradingStockTransferBeanObj.setTotal(rs.getString(7));
                    tradingStockTransferBeanObj.setTransportationType(rs.getString(8));
                    tradingStockTransferBeanObj.setTransportationCost(rs.getString(9));
                    tradingStockTransferBeanObj.setTransferDate(rs.getString(10));

                    alTradingStockTransferBean.add(tradingStockTransferBeanObj);
                    request.setAttribute("displayFlag", "Y");
                }

                if (searchFound == 0) {

                    message = "No Transfer Record Exists for the selected criteria";
                    request.setAttribute("message", message);

                }

            } catch (SQLException ex) {
                Logger.getLogger(TradingStockTransferServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex.toString());
            } finally {

                try {
                    proc.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
            }

                request.setAttribute("alTradingStockTransferBeanApend", alTradingStockTransferBean);
                request.setAttribute("fromDate", fromDate);
                request.setAttribute("toDate", toDate);
            request.getRequestDispatcher("/Trading_JSP/TradingStockTransfer.jsp").forward(request, response);
        
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
