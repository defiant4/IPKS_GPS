/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.PacsManagementBean;
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
 * @author Tcs Helpdesk10
 */
public class PacsManagementServlet extends HttpServlet {

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

        PacsManagementBean oPacsManagementBean = new PacsManagementBean();

        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oPacsManagementBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.Upsert_pacs_master(?,?,?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oPacsManagementBean.getPacsCode());
                proc.setString(2, oPacsManagementBean.getPacsName());
                proc.setString(3, oPacsManagementBean.getDccb());
                proc.setString(4, oPacsManagementBean.getCbsBranchCode());
                proc.setString(5, oPacsManagementBean.getAddressLine1());
                proc.setString(6, oPacsManagementBean.getAddressLine2());
                proc.setString(7, oPacsManagementBean.getAddressLine3());
                proc.setString(8, oPacsManagementBean.getDistrictCode());
                proc.setString(9, oPacsManagementBean.getLiveFlag());
                proc.setString(10, oPacsManagementBean.getCmnPrkBglNo());
                proc.setString(11, oPacsManagementBean.getPacsConsAccNo());
                proc.setString(12, ServletName);

                proc.execute();

                message = " New PACS Created Successfully";

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
                request.getRequestDispatcher("/pacsManagement.jsp").forward(request, response);

            }

        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oPacsManagementBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select pacs_id,pacs_name,eff_date,dccb_code,cbs_br_code,CMN_PRK_BGLNO,PACS_CONS_ACCNO,addr1,addr2,addr3,district_code,state_code,micr_code,live_flag from pacs_master where pacs_id='" + oPacsManagementBean.getPacsCodeSearch() + "' and pacs_id!='99999' and pacs_name!='GLOBAL' ");

                while (rs.next()) {

                    oPacsManagementBean.setEffectDate(rs.getString("EFF_DATE"));
                    oPacsManagementBean.setPacsName(rs.getString("PACS_NAME"));
                    oPacsManagementBean.setPacsCode(rs.getString("PACS_ID"));
                    oPacsManagementBean.setDccb(rs.getString("DCCB_CODE"));
                    oPacsManagementBean.setCbsBranchCode(rs.getString("CBS_BR_CODE"));
                    oPacsManagementBean.setCmnPrkBglNo(rs.getString("CMN_PRK_BGLNO"));
                    oPacsManagementBean.setPacsConsAccNo(rs.getString("PACS_CONS_ACCNO"));
                    oPacsManagementBean.setAddressLine1(rs.getString("ADDR1"));
                    oPacsManagementBean.setAddressLine2(rs.getString("ADDR2"));
                    oPacsManagementBean.setAddressLine3(rs.getString("ADDR3"));
                    oPacsManagementBean.setDistrictCode(rs.getString("DISTRICT_CODE"));
                    oPacsManagementBean.setLiveFlag(rs.getString("LIVE_FLAG"));

                    SeachFound = 1;
                    //Displayflag needs to be set to Y here
                    request.setAttribute("displayFlag", "Y");

                }
                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (SeachFound == 0) {
                message = "PACS Code not exists in the system";
                request.setAttribute("message", message);
            }
            request.setAttribute("oPacsManagementBeanObj", oPacsManagementBean);
            request.getRequestDispatcher("/pacsManagement.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oPacsManagementBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.Upsert_pacs_master(?,?,?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oPacsManagementBean.getPacsCodeAmend());
                proc.setString(2, oPacsManagementBean.getPacsNameAmend());
                proc.setString(3, oPacsManagementBean.getDccbAmend());
                proc.setString(4, oPacsManagementBean.getCbsBranchCodeAmend());
                proc.setString(5, oPacsManagementBean.getAddressLine1Amend());
                proc.setString(6, oPacsManagementBean.getAddressLine2Amend());
                proc.setString(7, oPacsManagementBean.getAddressLine3Amend());
                proc.setString(8, oPacsManagementBean.getDistrictCodeAmend());
                proc.setString(9, oPacsManagementBean.getLiveFlagAmend());
                proc.setString(10, oPacsManagementBean.getCmnPrkBglNoAmend());
                proc.setString(11, oPacsManagementBean.getPacsConsAccNoAmend());

                proc.setString(12, ServletName);

                proc.execute();

                message = "PACS Updated Successfully";

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
                request.getRequestDispatcher("/pacsManagement.jsp").forward(request, response);

            }

        }

       //else if ("StatusSearch".equalsIgnoreCase(ServletName)) 
       /*{

         String bglCodeActivation=request.getParameter("bglCodeActivation");
         String vFlag=request.getParameter("BglstatusFlag");
            
         try {
         con = DbHandler.getDBConnection();
         try {
         proc = con.prepareCall("{ call parameter.gl_product_Activation(?,?,?)}");
         } catch (SQLException ex) {
         Logger.getLogger(PacsManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
         }

         proc.setString(1, bglCodeActivation);
         proc.setString(2,vFlag);
         proc.registerOutParameter(3, java.sql.Types.VARCHAR);
                
         proc.execute();
                

         message = proc.getString(3);

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
         request.getRequestDispatcher("/pacsManagement.jsp").forward(request, response);

         }

         }*/
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
