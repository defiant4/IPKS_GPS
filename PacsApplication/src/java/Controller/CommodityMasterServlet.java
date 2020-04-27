/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.CommodityMasterBean;
//import LoginDb.DbHandler;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author 1249241
 */
public class CommodityMasterServlet extends HttpServlet {

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
        //processRequest(request, response);

        Connection con = null;
        CallableStatement proc = null;
        String message = "";

        String ServletName = request.getParameter("handle_id");

        CommodityMasterBean oCommodityMasterBean = new CommodityMasterBean();
        String commodityID = request.getParameter("CommodityIdAmend");
        if(commodityID == null)
        {
            commodityID="";
        }

        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oCommodityMasterBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call GPS_Operation.commodity_entry(?,?,?,?,?,?,?,?,?) }");//change as required
                } catch (SQLException ex) {
                    Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oCommodityMasterBean.getItemType());
                proc.setString(2, oCommodityMasterBean.getItemDesc());
                proc.setString(3, oCommodityMasterBean.getSubType());
                proc.setString(4, oCommodityMasterBean.getSubtypeDesc());
                proc.setString(5, oCommodityMasterBean.getQtyUnit());
                proc.setString(6, oCommodityMasterBean.getPacsid());
                proc.setString(7, ServletName);
                proc.setString(8, commodityID);
                

                proc.registerOutParameter(9, java.sql.Types.VARCHAR);
                proc.execute();

                message = proc.getString(9);

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/GPS_JSP/CommodityMaster.jsp").forward(request, response);

            }
        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oCommodityMasterBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select ID,ITEM_TYPE,TYPE_DESC,ITEM_SUBTYPE,SUBTYPE_DESC,UNIT from GPS_COMMODITY_MASTER where ID= '" + commodityID + "'");

                while (rs.next()) {

                    oCommodityMasterBean.setCommodityId(rs.getString("ID"));
                    oCommodityMasterBean.setItemType(rs.getString("ITEM_TYPE"));
                    
                    oCommodityMasterBean.setItemDesc(rs.getString("TYPE_DESC"));
                    oCommodityMasterBean.setSubType(rs.getString("ITEM_SUBTYPE"));
                    oCommodityMasterBean.setSubtypeDesc(rs.getString("SUBTYPE_DESC"));
                     oCommodityMasterBean.setQtyUnit(rs.getString("UNIT"));
                     
                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");

                }

                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Item does not exists in the system";
                request.setAttribute("message", message);
            }
            request.setAttribute("oCommodityMasterBean", oCommodityMasterBean);
            request.setAttribute("commodityID", commodityID);

            request.getRequestDispatcher("/GPS_JSP/CommodityMaster.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oCommodityMasterBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call GPS_Operation.commodity_entry(?,?,?,?,?,?,?,?,?) }");// change as required
                } catch (SQLException ex) {
                    Logger.getLogger(CommodityMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oCommodityMasterBean.getItemType_Amend());
                proc.setString(2, oCommodityMasterBean.getItemDesc_Amend());
                proc.setString(3, oCommodityMasterBean.getSubtypeAmend());
                proc.setString(4, oCommodityMasterBean.getSubtypeDescAmend());
                proc.setString(5, oCommodityMasterBean.getQtyUnitAmend());
                proc.setString(6, oCommodityMasterBean.getPacsid());
                proc.setString(7, ServletName);
                proc.setString(8, commodityID);
                

                proc.registerOutParameter(9, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(9);

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/GPS_JSP/CommodityMaster.jsp").forward(request, response);

            }

        }

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
