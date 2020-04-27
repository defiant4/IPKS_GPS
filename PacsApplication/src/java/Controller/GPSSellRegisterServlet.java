/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.GPSSellRegisterBean;
import DataEntryBean.PurchaseDetailBean;
import DataEntryBean.pdsStockRegisterBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
public class GPSSellRegisterServlet extends HttpServlet {

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
        ResultSet rs = null;
        ArrayList<GPSSellRegisterBean> alGPSSellRegisterBean = new ArrayList<GPSSellRegisterBean>();
        String message = "";
        int searchFound = 0;
        String pacsId = (String) session.getAttribute("pacsId");
        String itemCode = request.getParameter("itemTypeId");
        String itemSubTypeCode = request.getParameter("itemSubTypeId");
        String itemtypeDesc = request.getParameter("itemtypeDesc");
        String itemsubtypeDesc = request.getParameter("itemsubtypeDesc");
        String fromDate = request.getParameter("fromdate");
        String toDate = request.getParameter("todate");
        GPSSellRegisterBean gPSSellRegisterBeanObj = null;
        
        gPSSellRegisterBeanObj=new GPSSellRegisterBean();
                gPSSellRegisterBeanObj.setToDate(toDate);
                gPSSellRegisterBeanObj.setFromDate(fromDate);
                gPSSellRegisterBeanObj.setItemCode(itemCode);
                 gPSSellRegisterBeanObj.setItemSubTypeCode(itemSubTypeCode);
                try {
                con = DbHandler.getDBConnection();
                proc = con.prepareCall("{ call GPS_Operation.sell_register_check(?,?,?,?,?,?,?) }");
                proc.setString(1, gPSSellRegisterBeanObj.getItemCode());
                proc.setString(2, gPSSellRegisterBeanObj.getItemSubTypeCode());
                proc.setString(3, gPSSellRegisterBeanObj.getFromDate());
                proc.setString(4, gPSSellRegisterBeanObj.getToDate());
                proc.setString(5, pacsId);
                proc.registerOutParameter(6, OracleTypes.CURSOR);
                proc.registerOutParameter(7, java.sql.Types.VARCHAR);
                proc.execute();
                message = proc.getString(7);
                rs = (ResultSet) proc.getObject(6);

                while (rs.next()) {
                    searchFound = 1;
                    gPSSellRegisterBeanObj = new GPSSellRegisterBean();
                    gPSSellRegisterBeanObj.setSellTo(rs.getString(1));
                    gPSSellRegisterBeanObj.setDeliveredTo(rs.getString(2));
                    gPSSellRegisterBeanObj.setProcurementCode(rs.getString(3));
                    gPSSellRegisterBeanObj.setQuantity(rs.getString(4));
                    gPSSellRegisterBeanObj.setPrice(rs.getString(5));
                    gPSSellRegisterBeanObj.setTotal(rs.getString(6));
                    gPSSellRegisterBeanObj.setExpense(rs.getString(7));
                    gPSSellRegisterBeanObj.setSellDate(rs.getString(8));
                    
                    alGPSSellRegisterBean.add(gPSSellRegisterBeanObj);
                    request.setAttribute("displayFlag", "Y");
                }
                gPSSellRegisterBeanObj.setItemCode(itemtypeDesc);
                gPSSellRegisterBeanObj.setItemSubTypeCode(itemsubtypeDesc);
                gPSSellRegisterBeanObj.setFromDate(fromDate);
                gPSSellRegisterBeanObj.setToDate(toDate);
                

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

            request.setAttribute("alGPSSellRegisterBean", alGPSSellRegisterBean);
            request.setAttribute("gPSSellRegisterBeanObj", gPSSellRegisterBeanObj);
            request.getRequestDispatcher("/GPS_JSP/sellregister.jsp").forward(request, response);

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
    }// </editor-fold>
}
