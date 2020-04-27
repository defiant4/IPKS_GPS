/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Controller.UploadServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import DataEntryBean.AssetRegisterBean;
import LoginDb.DbHandler;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Tcs Helpdesk10
 */
public class AssetRegisterServlet extends HttpServlet {

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
        Connection connection = null;
        ResultSet rs = null;
        Statement statement = null;
        CallableStatement proc = null;
        int searchFound = 0;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");
        
            AssetRegisterBean oAssetRegisterBean = new AssetRegisterBean();
           
            ArrayList<AssetRegisterBean> alAssetRegisterBean = new ArrayList<AssetRegisterBean>();
            try {
                BeanUtils.populate(oAssetRegisterBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(AssetRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(AssetRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection = DbHandler.getDBConnection();
                try {
                    proc = connection.prepareCall("{ call ASSET_OPERATION.asset_Register(?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(AssetRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oAssetRegisterBean.getAsset_mst_id());
                proc.setString(2, pacsId);

                proc.registerOutParameter(3, OracleTypes.CURSOR);
                proc.registerOutParameter(4, java.sql.Types.VARCHAR);

                proc.executeUpdate();

                rs = (ResultSet) proc.getObject(3);

                while (rs.next()) {
                    searchFound = 1;
                    oAssetRegisterBean = new AssetRegisterBean();
                    oAssetRegisterBean.setDetail_id(rs.getString("ID"));
                    oAssetRegisterBean.setAsset_id(rs.getString("ASSET_ID"));
                    oAssetRegisterBean.setDescription(rs.getString("DESCRIPTION"));
                    oAssetRegisterBean.setInt_value(rs.getString("INITIAL_VALUE"));
                    oAssetRegisterBean.setPres_val(rs.getString("PRESENT_VALUE"));
                    oAssetRegisterBean.setMode_of_aqr(rs.getString("ACQUIREMENT"));
                    oAssetRegisterBean.setEntry_date(rs.getString("entry_date"));
                    oAssetRegisterBean.setStatus(rs.getString("ACTIVE_FLAG"));
                    
                                      
                    alAssetRegisterBean.add(oAssetRegisterBean);
                    
                    request.setAttribute("displayFlag", "Y");

                }

                oAssetRegisterBean.setAsset_type(request.getParameter("asset_type"));
                oAssetRegisterBean.setAsset_subtypoe(request.getParameter("asset_subtype"));
                oAssetRegisterBean.setAsset_mst_id(request.getParameter("asset_mst_id"));
                

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (searchFound == 0) {
                message = "No data exists for selected item";
                request.setAttribute("message", message);
            }
            
            request.setAttribute("oAssetRegisterBean", oAssetRegisterBean);
            request.setAttribute("alAssetRegisterBean", alAssetRegisterBean);
            request.setAttribute("message", message);

            request.getRequestDispatcher("/Asset_JSP/assetRegister.jsp").forward(request, response);
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
