/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DataEntryBean.AssetEntryBean;
import LoginDb.DbHandler;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Tcs Helpdesk10
 */
public class AssetEntryServlet extends HttpServlet {

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
        AssetEntryBean oAssetEntryBean = null;
        ResultSet rs = null;
        ArrayList<AssetEntryBean> alAssetEntryBeanApend = new ArrayList<AssetEntryBean>();
        
         int counter = Integer.parseInt(request.getParameter("rowCounter"));
         
         
            for (int i = 1; i <= counter; i++) {
                try {

                    String asset_type = request.getParameter("asset_type" + i);
                    String asset_subtype = request.getParameter("asset_subtype" + i);
                    String asset_id = request.getParameter("asset_id" + i);
                    String description = request.getParameter("description" + i);
                    String curr_val = request.getParameter("curr_val" + i);
                    String mode_of_aqr = request.getParameter("mode_of_aqr" + i);
                    String asset_mst_id = request.getParameter("asset_mst_id" + i);

                    if (asset_type != null) {
                        oAssetEntryBean = new AssetEntryBean();
                        oAssetEntryBean.setAsset_type(asset_type);
                        oAssetEntryBean.setAsset_subtype(asset_subtype);
                        oAssetEntryBean.setAsset_id(asset_id);
                        oAssetEntryBean.setDescription(description);
                        oAssetEntryBean.setCurr_val(curr_val);
                        oAssetEntryBean.setMode_of_aqr(mode_of_aqr);
                        oAssetEntryBean.setAsset_mst_id(asset_mst_id);
                        alAssetEntryBeanApend.add(oAssetEntryBean);
                    }
                } catch (Exception e) {
                }
            }
            if (alAssetEntryBeanApend.size() > 0) {

                for (int j = 0; j < alAssetEntryBeanApend.size(); j++) {

                    oAssetEntryBean = alAssetEntryBeanApend.get(j);

                    try {
                        con = DbHandler.getDBConnection();
                        try {
                            proc = con.prepareCall("{ call ASSET_OPERATION.asset_entry(?,?,?,?,?,?,?) }");
                        } catch (SQLException ex) {
                            Logger.getLogger(pdsStockRegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        
                        proc.setString(1, oAssetEntryBean.getAsset_id());
                        proc.setString(2, oAssetEntryBean.getAsset_mst_id());
                        proc.setString(3, oAssetEntryBean.getDescription());
                        proc.setString(4, oAssetEntryBean.getCurr_val());
                        proc.setString(5, oAssetEntryBean.getMode_of_aqr());
                        proc.setString(6, pacsId);

                        proc.registerOutParameter(7, java.sql.Types.VARCHAR);

                        proc.execute();

                        message = proc.getString(7);

                    } catch (SQLException ex) {
                        Logger.getLogger(AssetEntryServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                            Logger.getLogger(AssetEntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                            System.out.println(ex.toString());
                        }
                    }
                }
            }
            request.setAttribute("message", message);
            request.getRequestDispatcher("/Asset_JSP/assetEntry.jsp").forward(request, response);
        
        
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
