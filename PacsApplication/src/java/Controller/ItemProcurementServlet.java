/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DataEntryBean.ItemProcurementBean;
import LoginDb.DbHandler;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 590685
 */
/**
 *
 * @author Tcs Helpdesk10
 */
public class ItemProcurementServlet extends HttpServlet {

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
        Connection con = null;
        CallableStatement proc = null;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");
        ItemProcurementBean oItemProcurementBean = null;
        long num = (long)Math.floor(Math.random()*900000000000L)+ 100000000000L;
        String procurementId = String.valueOf(num);
        String musterRollId = request.getParameter("musterRollId");
        String orderId = request.getParameter("govtOrderId");

       

        int counter = Integer.parseInt(request.getParameter("rowCounter"));
        ArrayList<ItemProcurementBean> alItemProcurementBean = new ArrayList<ItemProcurementBean>();
        for (int i = 1; i <= counter; i++) {
            try {

                String item_type = request.getParameter("item_type" + i);
                String item_subtype = request.getParameter("item_subtype" + i);
                String rate_per_unit = request.getParameter("rate_per_unit" + i);
                String qty_unit = request.getParameter("qty_unit" + i);
                String qty = request.getParameter("qty" + i);
                String total = request.getParameter("total" + i);
                String commodityId = request.getParameter("commodityId" + i);

                if (commodityId != null) {
                    oItemProcurementBean = new ItemProcurementBean();
                    oItemProcurementBean.setCommodityId(commodityId);
                    oItemProcurementBean.setItemType(item_type);
                    oItemProcurementBean.setItemSubType(item_subtype);
                    oItemProcurementBean.setRatePerUnit(rate_per_unit);
                    oItemProcurementBean.setQtyunit(qty_unit);
                    oItemProcurementBean.setQty(qty);
                    oItemProcurementBean.setTotal(total);

                    alItemProcurementBean.add(oItemProcurementBean);
                }
            } catch (Exception e) {
            }
        }
        if (alItemProcurementBean.size() > 0) {

            for (int j = 0; j < alItemProcurementBean.size(); j++) {

                oItemProcurementBean = alItemProcurementBean.get(j);

                try {
                    con = DbHandler.getDBConnection();
                    try {
                        proc = con.prepareCall("{ call GPS_OPERATION.item_procurement_entry(?,?,?,?,?,?,?,?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    proc.setString(1, musterRollId);
                    proc.setString(2, orderId);
                    proc.setString(3, oItemProcurementBean.getQty());
                    proc.setString(4, oItemProcurementBean.getTotal());
                    proc.setString(5, pacsId);
                    proc.setString(6, oItemProcurementBean.getCommodityId());
                    proc.setString(7, procurementId);
                    proc.registerOutParameter(8, java.sql.Types.VARCHAR);

                    proc.execute();

                    message = proc.getString(8);

                } catch (SQLException ex) {
                    Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println(ex.toString());
                    }
                }

            }

        }
        
        request.setAttribute("message", message);
if(message==null)
        request.getRequestDispatcher("/GPS_JSP/ItemProcurement.jsp").forward(request, response);
else 
    request.getRequestDispatcher("/GPS_JSP/ItemProcureChallan.jsp").forward(request, response);


    }

    // <editor-fold defaultstate="collapsed" name="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
     * Returns a short nameription of the servlet.
     *
     * @return a String containing servlet nameription
     */
    @Override
    public String getServletInfo() {
        return "Short nameription";
    }// </editor-fold>

}
