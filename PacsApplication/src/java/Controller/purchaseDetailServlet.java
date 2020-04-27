/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.PurchaseDetailBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tcs Help desk122
 */
public class purchaseDetailServlet extends HttpServlet {

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
        Connection conn = DbHandler.getDBConnection();
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        ArrayList<PurchaseDetailBean> alPurchaseDetailBean = null;
        String message = "";
        int searchFound = 0;
        String memberId = request.getParameter("custId");
        PurchaseDetailBean purchaseDetailBeanObj = null;
        
        String headerQry = "select md.member_id,md.name,pm.product_name,pm.product_code,r.quantity,r.price,r.total,to_char(r.purchase_date,'DD/MM/YYYY') "
                + " from PDS_raise_requisition r,pds_product_mst pm,pds_members_details md "
                + " where r.member_id=md.member_id and pm.id=r.product_id and md.member_id='" + memberId + "'";
        
        try{
            alPurchaseDetailBean = new ArrayList<PurchaseDetailBean>();
            pstmt = conn.prepareStatement(headerQry);
            resultSet = pstmt.executeQuery();
            while(resultSet.next()){
                searchFound = 1;
                purchaseDetailBeanObj = new PurchaseDetailBean();
                purchaseDetailBeanObj.setMemberId(resultSet.getString(1));
                purchaseDetailBeanObj.setMemberName(resultSet.getString(2));
                purchaseDetailBeanObj.setProductName(resultSet.getString(3));
                purchaseDetailBeanObj.setProductCode(resultSet.getString(4));
                purchaseDetailBeanObj.setQuantity(resultSet.getString(5));
                purchaseDetailBeanObj.setPrice(resultSet.getString(6));
                purchaseDetailBeanObj.setTotal(resultSet.getString(7));
                purchaseDetailBeanObj.setPurchaseDate(resultSet.getString(8));
                alPurchaseDetailBean.add(purchaseDetailBeanObj);
                request.setAttribute("displayFlag", "Y");
            }
            
            
        }
        catch (Exception e) {
                }
        
        finally{
            if (searchFound == 0) {
                message = "No details exists for selected member ID";
                request.setAttribute("message", message);
            }
            request.setAttribute("alPurchaseDetailBean",alPurchaseDetailBean);
            request.getRequestDispatcher("/purchasedetail.jsp").forward(request, response);
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
