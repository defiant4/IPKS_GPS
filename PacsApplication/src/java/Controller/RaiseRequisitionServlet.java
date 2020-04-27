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
import DataEntryBean.raiseRequisitionBean;
import LoginDb.DbHandler;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 590685
 */
public class RaiseRequisitionServlet extends HttpServlet {

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
        raiseRequisitionBean oraiseRequisitionBean = null;
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        Date today = Calendar.getInstance().getTime();
        String requisitionId = df.format(today);
        String memberId = request.getParameter("custId").toString();
        session.setAttribute("memberId", memberId);

        if (handle_id.equalsIgnoreCase("Create")) {

            int counter = Integer.parseInt(request.getParameter("rowCounter"));
            
            ArrayList<raiseRequisitionBean> alraiseRequisitionBean = new ArrayList<raiseRequisitionBean>();
            for (int i = 1; i <= counter; i++) {
                try {

                    String product_id = request.getParameter("product_id" + i);
                    String price = request.getParameter("price" + i);
                    String quantity = request.getParameter("quantity" + i);
                    String linetotal = request.getParameter("linetotal" + i);
                    String stock_id = request.getParameter("stock_id" + i);
                    String stock_quantity = request.getParameter("stock_quantity" + i);

                    if (product_id != null) {
                        oraiseRequisitionBean = new raiseRequisitionBean();
                        oraiseRequisitionBean.setProduct_id(product_id);
                        oraiseRequisitionBean.setPrice(price);
                        oraiseRequisitionBean.setQuantity(quantity);
                        oraiseRequisitionBean.setLinetotal(linetotal);
                        oraiseRequisitionBean.setStock_id(stock_id);
                        oraiseRequisitionBean.setStock_quantity(stock_quantity);
                        oraiseRequisitionBean.setRequisitionId(requisitionId);
                                
                        alraiseRequisitionBean.add(oraiseRequisitionBean);
                    }
                } catch (Exception e) {
                }
            }

            if (alraiseRequisitionBean.size() > 0) {

                for (int j = 0; j < alraiseRequisitionBean.size(); j++) {

                    oraiseRequisitionBean = alraiseRequisitionBean.get(j);

                    try {
                        con = DbHandler.getDBConnection();
                        try {
                            proc = con.prepareCall("{ call PDS_RAISE_REQ.Upsert_raise_requisition(?,?,?,?,?,?,?,?,?,?,?) }");
                        } catch (SQLException ex) {
                            Logger.getLogger(RaiseRequisitionServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        proc.setString(1, oraiseRequisitionBean.getProduct_id());
                        proc.setString(2, oraiseRequisitionBean.getPrice());
                        proc.setString(3, oraiseRequisitionBean.getQuantity());
                        proc.setString(4, oraiseRequisitionBean.getLinetotal());
                        proc.setString(5, oraiseRequisitionBean.getStock_id());
                        proc.setString(6, oraiseRequisitionBean.getStock_quantity());
                        proc.setString(7, oraiseRequisitionBean.getRequisitionId());
                        proc.setString(8, handle_id);
                        proc.setString(9, pacsId);
                        proc.setString(10, memberId);

                        proc.registerOutParameter(11, java.sql.Types.VARCHAR);

                        proc.execute();

                        message = proc.getString(11);

                    } catch (SQLException ex) {
                        Logger.getLogger(RaiseRequisitionServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                            Logger.getLogger(RaiseRequisitionServlet.class.getName()).log(Level.SEVERE, null, ex);
                            System.out.println(ex.toString());
                        }
                    }

                }
            }
        }

        request.setAttribute("message", message);
        request.setAttribute("requisitionId", requisitionId);
        request.setAttribute("memberId", memberId);
        if (message.equals("Required quantity is not in stock")) {
            request.getRequestDispatcher("/pds_raise_requisition.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/Invoice.jsp").forward(request, response);
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
