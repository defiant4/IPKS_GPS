/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.TradingSaleItemEntryBean;
import DataEntryBean.TrandinStockRegisterBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
public class TradingSaleItemEntry extends HttpServlet {

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
        String optionValue = request.getParameter("checkOption");
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        Date today = Calendar.getInstance().getTime();
        String saleId = df.format(today);
        TradingSaleItemEntryBean tradingSaleItemEntryBeanObj = null;
        ResultSet rs = null;
        ArrayList<TradingSaleItemEntryBean> alTradingSaleItemEntryBean = new ArrayList<TradingSaleItemEntryBean>();
        
        if (optionValue.equals("member")) {
            String memberId = request.getParameter("memberId");
            
            int counter = Integer.parseInt(request.getParameter("rowCounter"));
            
            for (int i = 1; i <= counter; i++) {
                try {
                    
                    String productId = request.getParameter("product_id" + i);
                    String stockId = request.getParameter("stockId" + i);
                    String price = request.getParameter("price" + i);
                    String quantity = request.getParameter("quantity" + i);
                    String linetotal = request.getParameter("total" + i);
                    String p_order_id = request.getParameter("p_order_id" + i);
                    
                    if (productId != null) {
                        tradingSaleItemEntryBeanObj = new TradingSaleItemEntryBean();
                        tradingSaleItemEntryBeanObj.setProductId(productId);
                        tradingSaleItemEntryBeanObj.setMemberId(memberId);
                        tradingSaleItemEntryBeanObj.setPrice(price);
                        tradingSaleItemEntryBeanObj.setQuantity(quantity);
                        tradingSaleItemEntryBeanObj.setTotal(linetotal);
                        tradingSaleItemEntryBeanObj.setStockId(stockId);
                        tradingSaleItemEntryBeanObj.setSaleId(saleId);
                        tradingSaleItemEntryBeanObj.setP_order_id(p_order_id);
                        
                        alTradingSaleItemEntryBean.add(tradingSaleItemEntryBeanObj);
                    }
                } catch (Exception e) {
                }
            }
            if (alTradingSaleItemEntryBean.size() > 0) {
                
                for (int j = 0; j < alTradingSaleItemEntryBean.size(); j++) {
                    
                    tradingSaleItemEntryBeanObj = alTradingSaleItemEntryBean.get(j);
                    try {
                        con = DbHandler.getDBConnection();
                        try {
                            proc = con.prepareCall("{ call Trading_Operation.trading_Sale_entry(?,?,?,?,?,?,?,?,?,?,?) }");
                        } catch (SQLException ex) {
                            Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        
                        proc.setString(1, tradingSaleItemEntryBeanObj.getProductId());
                        proc.setString(2, tradingSaleItemEntryBeanObj.getPrice());
                        proc.setString(3, tradingSaleItemEntryBeanObj.getQuantity());
                        proc.setString(4, tradingSaleItemEntryBeanObj.getTotal());
                        proc.setString(5, tradingSaleItemEntryBeanObj.getMemberId());
                        proc.setString(6, tradingSaleItemEntryBeanObj.getStockId());
                        proc.setString(7, tradingSaleItemEntryBeanObj.getSaleId());
                        proc.setString(8, tradingSaleItemEntryBeanObj.getP_order_id());
                        proc.setString(9, pacsId);
                        proc.setString(10, handle_id);
                        
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
        } else if (optionValue.equals("nonmember")) {
            String custName = request.getParameter("custName");
            String contactNo = request.getParameter("contactNo");
            String address = request.getParameter("address");
            String dob = request.getParameter("dob");
            
            int counter = Integer.parseInt(request.getParameter("rowCounter"));
            
            for (int i = 1; i <= counter; i++) {
                try {
                    
                    String productId = request.getParameter("product_id" + i);
                    String stockId = request.getParameter("stockId" + i);
                    String price = request.getParameter("price" + i);
                    String quantity = request.getParameter("quantity" + i);
                    String linetotal = request.getParameter("total" + i);
                    String p_order_id = request.getParameter("p_order_id" + i);
                    
                    if (productId != null) {
                        tradingSaleItemEntryBeanObj = new TradingSaleItemEntryBean();
                        tradingSaleItemEntryBeanObj.setProductId(productId);
                        tradingSaleItemEntryBeanObj.setMemberName(custName);
                        tradingSaleItemEntryBeanObj.setMemberContact(contactNo);
                        tradingSaleItemEntryBeanObj.setMemberAddress(address);
                        tradingSaleItemEntryBeanObj.setMemberDOB(dob);
                        tradingSaleItemEntryBeanObj.setPrice(price);
                        tradingSaleItemEntryBeanObj.setQuantity(quantity);
                        tradingSaleItemEntryBeanObj.setTotal(linetotal);
                        tradingSaleItemEntryBeanObj.setStockId(stockId);
                        tradingSaleItemEntryBeanObj.setSaleId(saleId);
                        tradingSaleItemEntryBeanObj.setP_order_id(p_order_id);
                        
                        alTradingSaleItemEntryBean.add(tradingSaleItemEntryBeanObj);
                    }
                } catch (Exception e) {
                }
            }
            if (alTradingSaleItemEntryBean.size() > 0) {
                
                for (int j = 0; j < alTradingSaleItemEntryBean.size(); j++) {
                    
                    tradingSaleItemEntryBeanObj = alTradingSaleItemEntryBean.get(j);
                    try {
                        con = DbHandler.getDBConnection();
                        try {
                            proc = con.prepareCall("{ call Trading_Operation.trading_Sale_entry_non_member(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                        } catch (SQLException ex) {
                            Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        
                        proc.setString(1, tradingSaleItemEntryBeanObj.getProductId());
                        proc.setString(2, tradingSaleItemEntryBeanObj.getPrice());
                        proc.setString(3, tradingSaleItemEntryBeanObj.getQuantity());
                        proc.setString(4, tradingSaleItemEntryBeanObj.getTotal());
                        proc.setString(5, tradingSaleItemEntryBeanObj.getMemberName());
                        proc.setString(6, tradingSaleItemEntryBeanObj.getMemberContact());
                        proc.setString(7, tradingSaleItemEntryBeanObj.getMemberAddress());
                        proc.setString(8, tradingSaleItemEntryBeanObj.getMemberDOB());
                        proc.setString(9, tradingSaleItemEntryBeanObj.getStockId());
                        proc.setString(10, tradingSaleItemEntryBeanObj.getSaleId());
                        proc.setString(11, tradingSaleItemEntryBeanObj.getP_order_id());
                        proc.setString(12, pacsId);
                        proc.setString(13, handle_id);
                        
                        proc.registerOutParameter(14, java.sql.Types.VARCHAR);
                        
                        proc.execute();
                        
                        message = proc.getString(14);
                        
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
        }
        request.setAttribute("message", message);
        request.getRequestDispatcher("/Trading_JSP/SellItem.jsp").forward(request, response);
        
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
