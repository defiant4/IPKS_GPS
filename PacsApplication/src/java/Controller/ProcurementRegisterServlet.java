    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.ProcurementRegisterBean;
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
 * @author Tcs Helpdesk10
 */
public class ProcurementRegisterServlet extends HttpServlet {

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
        ArrayList<ProcurementRegisterBean> alProcurementRegisterBean = new ArrayList<ProcurementRegisterBean>();
        String message = "";
        int searchFound = 0;
        String pacsId = (String) session.getAttribute("pacsId");
        String itemCode = request.getParameter("itemTypeId");
        String itemtype = request.getParameter("itemtype");
        String itemSubTypeCode = request.getParameter("itemSubTypeId");
        String itemsubtype = request.getParameter("itemsubtype");
        String fromDate = request.getParameter("fromdate");
        String toDate = request.getParameter("todate");
        ProcurementRegisterBean ProcurementRegisterBeanObj = null;

        ProcurementRegisterBeanObj = new ProcurementRegisterBean();
        ProcurementRegisterBeanObj.setToDate(toDate);
        ProcurementRegisterBeanObj.setFromDate(fromDate);
        ProcurementRegisterBeanObj.setItemCode(itemCode);
        ProcurementRegisterBeanObj.setItemSubTypeCode(itemSubTypeCode);
        try {
            con = DbHandler.getDBConnection();
            proc = con.prepareCall("{ call GPS_Operation.procurement_register_check(?,?,?,?,?,?,?) }");
            proc.setString(1, ProcurementRegisterBeanObj.getItemCode());
            proc.setString(2, ProcurementRegisterBeanObj.getItemSubTypeCode());
            proc.setString(3, ProcurementRegisterBeanObj.getFromDate());
            proc.setString(4, ProcurementRegisterBeanObj.getToDate());
            proc.setString(5, pacsId);
            proc.registerOutParameter(6, OracleTypes.CURSOR);
            proc.registerOutParameter(7, java.sql.Types.VARCHAR);
            proc.execute();
            message = proc.getString(7);
            rs = (ResultSet) proc.getObject(6);

            while (rs.next()) {
                searchFound = 1;
                ProcurementRegisterBeanObj = new ProcurementRegisterBean();
                ProcurementRegisterBeanObj.setProcurementCode(rs.getString(1));
                ProcurementRegisterBeanObj.setProcurementId(rs.getString(2));
                ProcurementRegisterBeanObj.setProcurementDate(rs.getString(3));
                ProcurementRegisterBeanObj.setItemCodeAmmend(rs.getString(4));
                ProcurementRegisterBeanObj.setItemSubTypeCodeAmmend(rs.getString(5));
                ProcurementRegisterBeanObj.setUnit(rs.getString(6));
                ProcurementRegisterBeanObj.setRatePerUnit(rs.getString(7));
                ProcurementRegisterBeanObj.setBaseQty(rs.getString(8));
                ProcurementRegisterBeanObj.setQtyAvailable(rs.getString(9));

                alProcurementRegisterBean.add(ProcurementRegisterBeanObj);
                request.setAttribute("displayFlag", "Y");
            }
            ProcurementRegisterBeanObj.setItemCode(itemtype);
            ProcurementRegisterBeanObj.setItemSubTypeCode(itemsubtype);
            ProcurementRegisterBeanObj.setFromDate(fromDate);
            ProcurementRegisterBeanObj.setToDate(toDate);

            if (searchFound == 0) {

                message = "No Stock Exists for the selected criteria";
                request.setAttribute("message", message);

            }

        } catch (SQLException ex) {
            Logger.getLogger(ProcurementRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.toString());
        } finally {

            try {
                proc.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
        }

        request.setAttribute("alProcurementRegisterBean", alProcurementRegisterBean);
        request.setAttribute("ProcurementRegisterBeanObj", ProcurementRegisterBeanObj);
        request.getRequestDispatcher("/GPS_JSP/ProcurementRegister.jsp").forward(request, response);

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
