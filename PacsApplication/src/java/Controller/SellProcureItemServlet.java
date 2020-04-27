/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.GPSSellProcurementBean;
import DataEntryBean.GovtOrderCreationExpenseBean;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DataEntryBean.SellProcureItemBean;
import LoginDb.DbHandler;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
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
public class SellProcureItemServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {

        HttpSession session = request.getSession(false);
        Connection con = null;
        CallableStatement proc = null;
        ResultSet rs = null;
        String message = "";
        String orderId = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");
        long num = (long) Math.floor(Math.random() * 8100000000000L) + 2100000000000L;
        String sellId = String.valueOf(num);

        SellProcureItemBean oSellProcureItemBean = null;
        GovtOrderCreationExpenseBean oGovtOrderCreationExpenseBean = null;
        ArrayList<GovtOrderCreationExpenseBean> alGovtOrderCreationExpenseBean = new ArrayList<GovtOrderCreationExpenseBean>();

        GPSSellProcurementBean oGPSSellProcurementBean = new GPSSellProcurementBean();
        ArrayList<GPSSellProcurementBean> alGPSSellProcurementBean = null;

        String handle_id = request.getParameter("handle_id");
        String sell = request.getParameter("sellTo");
        String deliver = request.getParameter("deliveredTo");
        String addr = request.getParameter("addr");
        String orderCode = request.getParameter("govProcCode");
        orderId = request.getParameter("govtProcId");
        String expenseGrandTotal = request.getParameter("expense_total");

        if (handle_id.equalsIgnoreCase("calculate")) {

            con = DbHandler.getDBConnection();
            float totalExpense = 0;
            try {

                int counter = 0;
                counter = Integer.parseInt(request.getParameter("rowCounter"));
                int totalQty = 0;
                for (int i = 1; i <= counter; i++) {
                    String sell_qty = request.getParameter("sell_qty" + i);
                    totalQty = totalQty + Integer.parseInt(sell_qty);
                }
                System.out.print(totalQty);

                proc = con.prepareCall("select ed.expense_head,ed.expense_rate,ed.expense_rate*'" + totalQty + "' from order_expense_detail ed where ed.order_id='" + orderId + "' ");
                rs = proc.executeQuery();
                while (rs.next()) {
                    oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
                    oGovtOrderCreationExpenseBean.setExpense_head(rs.getString(1));

                    oGovtOrderCreationExpenseBean.setExpense_rate_per_unit(rs.getString(2));
                    oGovtOrderCreationExpenseBean.setExpense_total_individual(rs.getString(3));
                    totalExpense = totalExpense + Float.parseFloat(rs.getString(3));

                    alGovtOrderCreationExpenseBean.add(oGovtOrderCreationExpenseBean);
                    request.setAttribute("displayFlag", "Y");
                }
                int rowCounter = Integer.parseInt(request.getParameter("rowCounter"));
                alGPSSellProcurementBean = new ArrayList<GPSSellProcurementBean>();
                for (int i = 1; i <= rowCounter; i++) {
                    try {

                        String item_desc = request.getParameter("item_desc" + i);
                        String subtype_desc = request.getParameter("subtype_desc" + i);
                        String procId = request.getParameter("procId" + i);
                        String item_unit = request.getParameter("item_unit" + i);
                        String item_rateperunit = request.getParameter("item_rateperunit" + i);
                        String qty = request.getParameter("qty" + i);
                        String sell_qty = request.getParameter("sell_qty" + i);
                        String total = request.getParameter("total" + i);
                        String commodityId = request.getParameter("commodityId" + i);
                        String item_type = request.getParameter("item_type" + i);
                        String item_subtype = request.getParameter("item_subtype" + i);

                        oGPSSellProcurementBean = new GPSSellProcurementBean();
                        oGPSSellProcurementBean.setCommodityId(commodityId);
                        oGPSSellProcurementBean.setItem_desc(item_desc);
                        oGPSSellProcurementBean.setSubtype_desc(subtype_desc);
                        oGPSSellProcurementBean.setProcId(procId);
                        oGPSSellProcurementBean.setItem_unit(item_unit);
                        oGPSSellProcurementBean.setItem_rateperunit(item_rateperunit);
                        oGPSSellProcurementBean.setQty(qty);
                        oGPSSellProcurementBean.setSell_qty(sell_qty);
                        oGPSSellProcurementBean.setTotal(total);
                        oGPSSellProcurementBean.setItem_type(item_type);
                        oGPSSellProcurementBean.setItem_subtype(item_subtype);

                        alGPSSellProcurementBean.add(oGPSSellProcurementBean);

                    } catch (Exception e) {
                    }
                }

            } catch (SQLException ex) {
                Logger.getLogger(SellProcureItemServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                    Logger.getLogger(SellProcureItemServlet.class.getName()).log(Level.SEVERE, null, ex);
                    System.out.println(ex.toString());
                }
            }

            oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
            oGovtOrderCreationExpenseBean.setSell(sell);
            oGovtOrderCreationExpenseBean.setDeliver(deliver);
            oGovtOrderCreationExpenseBean.setAddress(addr);
            oGovtOrderCreationExpenseBean.setGovtOrderId(orderId);
            oGovtOrderCreationExpenseBean.setGovtOrderCode(orderCode);
            oGovtOrderCreationExpenseBean.setExpense_total_grand(String.valueOf(totalExpense));

        } else if (handle_id.equalsIgnoreCase("Create")) {

            con = DbHandler.getDBConnection();

            int counter = Integer.parseInt(request.getParameter("rowCounter_afterCalculate"));
            ArrayList<SellProcureItemBean> alSellProcureItemBean = new ArrayList<SellProcureItemBean>();
            for (int i = 0; i < counter; i++) {
                try {

                    String procId = request.getParameter("procIdAfterCalc" + i);
                    String item_type = request.getParameter("item_typeAfterCalc" + i);
                    String item_subtype = request.getParameter("item_subtypeAfterCalc" + i);
                    String item_unit = request.getParameter("item_unitAfterCalc" + i);
                    String item_rateperunit = request.getParameter("item_rateperunitAfterCalc" + i);
                    String qty = request.getParameter("qtyAfterCalc" + i);
                    String sell_qty = request.getParameter("sell_qtyAfterCalc" + i);
                    String total = request.getParameter("totalAfterCalc" + i);
                    String commodityId = request.getParameter("commodityIdAfterCalc" + i);

                    oSellProcureItemBean = new SellProcureItemBean();
                    oSellProcureItemBean.setProcId(procId);
                    oSellProcureItemBean.setItemType(item_type);
                    oSellProcureItemBean.setSubType(item_subtype);
                    oSellProcureItemBean.setItemUnit(item_unit);
                    oSellProcureItemBean.setItemRatePerUnit(item_rateperunit);
                    oSellProcureItemBean.setQty(qty);
                    oSellProcureItemBean.setSellQty(sell_qty);
                    oSellProcureItemBean.setItemTotal(total);
                    oSellProcureItemBean.setCommodityId(commodityId);

                    alSellProcureItemBean.add(oSellProcureItemBean);

                } catch (Exception e) {
                }
            }
            if (alSellProcureItemBean.size() > 0) {

                oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
                try {
                    con = DbHandler.getDBConnection();
                    proc = con.prepareCall("{ call GPS_Operation.item_sell_entry(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                    for (int j = 0; j < alSellProcureItemBean.size(); j++) {
                        oSellProcureItemBean = alSellProcureItemBean.get(j);
                        proc.setString(1, sell);
                        proc.setString(2, deliver);
                        proc.setString(3, addr);
                        proc.setString(4, orderCode);
                        proc.setString(5, orderId);
                        proc.setString(6, oSellProcureItemBean.getProcId());
                        proc.setString(7, oSellProcureItemBean.getItemType());
                        proc.setString(8, oSellProcureItemBean.getSubType());
                        proc.setString(9, oSellProcureItemBean.getItemUnit());
                        proc.setString(10, oSellProcureItemBean.getItemRatePerUnit());
                        proc.setString(11, oSellProcureItemBean.getSellQty());
                        proc.setString(12, oSellProcureItemBean.getItemTotal());
                        proc.setString(13, oSellProcureItemBean.getCommodityId());
                        proc.setString(14, expenseGrandTotal);
                        proc.setString(15, sellId);
                        proc.setString(16, pacsId);

                        proc.addBatch();

                    }
                    proc.executeBatch();
                    message = "Sale Register Succesfully. Sale ID is: "+ sellId;

                } catch (SQLException ex) {
                    Logger.getLogger(SellProcureItemServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                        Logger.getLogger(SellProcureItemServlet.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println(ex.toString());
                    }
                }

            }

        }
        request.setAttribute("alGPSSellProcurementBean", alGPSSellProcurementBean);
        request.setAttribute("oGovtOrderCreationExpenseBean", oGovtOrderCreationExpenseBean);
        request.setAttribute("alGovtOrderCreationExpenseBean", alGovtOrderCreationExpenseBean);
        if (!message.equals("")) {
            request.setAttribute("message", message);
            request.getRequestDispatcher("/GPS_JSP/SellItemChallan.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/GPS_JSP/SellProcureItem.jsp").forward(request, response);
        }

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
        try {
            processRequest(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(SellProcureItemServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(SellProcureItemServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
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
