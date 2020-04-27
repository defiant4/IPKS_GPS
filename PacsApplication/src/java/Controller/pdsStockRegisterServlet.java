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
import DataEntryBean.pdsStockRegisterBean;
import LoginDb.DbHandler;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author 1249241
 */
public class pdsStockRegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
        pdsStockRegisterBean opdsStockRegisterBean = null;
        ResultSet rs = null;
        ArrayList<pdsStockRegisterBean> alpdsStockRegisterBeanApend = new ArrayList<pdsStockRegisterBean>();


        if (handle_id.equalsIgnoreCase("Create")) {

            int counter = Integer.parseInt(request.getParameter("rowCounter"));


            ArrayList<pdsStockRegisterBean> alpdsStockRegisterBean = new ArrayList<pdsStockRegisterBean>();
            for (int i = 1; i <= counter; i++) {
                try {

                    String productId = request.getParameter("product_id" + i);
                    String price = request.getParameter("price" + i);
                    String quantity = request.getParameter("quantity" + i);
                    String linetotal = request.getParameter("total" + i);
                    String purchaseDate = request.getParameter("purchaseDate" + i);

                    if (productId != null) {
                        opdsStockRegisterBean = new pdsStockRegisterBean();
                        opdsStockRegisterBean.setProductId(productId);
                        opdsStockRegisterBean.setPrice(price);
                        opdsStockRegisterBean.setQuantity(quantity);
                        opdsStockRegisterBean.setTotal(linetotal);
                        opdsStockRegisterBean.setPurchaseDate(purchaseDate);

                        alpdsStockRegisterBean.add(opdsStockRegisterBean);
                    }
                } catch (Exception e) {
                }
            }
            if (alpdsStockRegisterBean.size() > 0) {

                for (int j = 0; j < alpdsStockRegisterBean.size(); j++) {

                    opdsStockRegisterBean = alpdsStockRegisterBean.get(j);

                    try {
                        con = DbHandler.getDBConnection();
                        try {
                            proc = con.prepareCall("{ call pds_StockRegister.Insert_PDS_STOCKREGISTER(?,?,?,?,?,?,?) }");
                        } catch (SQLException ex) {
                            Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        proc.setString(1, opdsStockRegisterBean.getPurchaseDate());
                        proc.setString(2, opdsStockRegisterBean.getProductId());
                        proc.setString(3, opdsStockRegisterBean.getPrice());
                        proc.setString(4, opdsStockRegisterBean.getQuantity());
                        proc.setString(5, opdsStockRegisterBean.getTotal());
                        proc.setString(6, pacsId);

                        proc.registerOutParameter(7, java.sql.Types.VARCHAR);

                        proc.execute();

                        message = proc.getString(7);

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
            request.getRequestDispatcher("/pds_stock_register.jsp").forward(request, response);


        } else if (handle_id.equalsIgnoreCase("checkStock")) {
            

                String toDate = request.getParameter("toDate");
                String fromDate = request.getParameter("fromDate");
                String productName = request.getParameter("productName");
                opdsStockRegisterBean=new pdsStockRegisterBean();
                opdsStockRegisterBean.setToDate(toDate);
                opdsStockRegisterBean.setFromDate(fromDate);
                opdsStockRegisterBean.setProductId(productName);
                int searchFound = 0;
                try {
                con = DbHandler.getDBConnection();
                proc = con.prepareCall("{ call pds_StockRegister.pds_stockView(?,?,?,?,?,?) }");
                proc.setString(1, opdsStockRegisterBean.getProductId());
                proc.setString(2, opdsStockRegisterBean.getToDate());
                proc.setString(3, opdsStockRegisterBean.getFromDate());
                proc.setString(4, pacsId);
                proc.registerOutParameter(5, OracleTypes.CURSOR);
                proc.registerOutParameter(6, java.sql.Types.VARCHAR);
                proc.execute();
                message = proc.getString(6);
                rs = (ResultSet) proc.getObject(5);

                while (rs.next()) {
                    searchFound = 1;
                    opdsStockRegisterBean = new pdsStockRegisterBean();
                    opdsStockRegisterBean.setProductName(rs.getString("PRODUCT_NAME"));
                    opdsStockRegisterBean.setProductId(rs.getString("PRODUCT_CODE"));
                    opdsStockRegisterBean.setUnit(rs.getString("UNIT"));
                    opdsStockRegisterBean.setPurchaseDate(rs.getString("STOCK_ENTRY_DATE"));
                    opdsStockRegisterBean.setPrice(rs.getString("PRICE"));
                    opdsStockRegisterBean.setQuantity(rs.getString("QUANTITY_BASE"));
                    opdsStockRegisterBean.setQuantityAbled(rs.getString("QUANTITY_ABLED"));
                    opdsStockRegisterBean.setQuantityAvailable(rs.getString("QUANTITY_AVL"));
                    opdsStockRegisterBean.setStockId(rs.getString("STOCK_ID"));
                    

                    alpdsStockRegisterBeanApend.add(opdsStockRegisterBean);
                    request.setAttribute("displayFlag", "Y");
                }

                if (searchFound==0){

                 message="No Stock Exists for the selected criteria";
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

            request.setAttribute("alpdsStockRegisterBeanApend", alpdsStockRegisterBeanApend);
            request.getRequestDispatcher("/pds_stock_register.jsp").forward(request, response);

        }

    }// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
