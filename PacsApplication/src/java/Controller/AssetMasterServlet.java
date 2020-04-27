package Controller;

import DataEntryBean.AssetMasterBean;
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
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author Tcs Helpdesk10
 */
public class AssetMasterServlet extends HttpServlet {

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
        /*response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         try {
             
         out.println("<!DOCTYPE html>");
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet GlProductOperationServlet</title>");            
         out.println("</head>");
         out.println("<body>");
         out.println("<h1>Servlet GlProductOperationServlet at " + request.getContextPath() + "</h1>");
         out.println("</body>");
         out.println("</html>");
         } finally {
         out.close();
         }*/
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

        AssetMasterBean oAssetMasterBean = new AssetMasterBean();

        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oAssetMasterBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(AssetMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(AssetMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call assetMaster.upsert_assetMaster(?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(AssetMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oAssetMasterBean.getAsset_type());
                proc.setString(2, oAssetMasterBean.getAsset_type_desc());
                proc.setString(3, oAssetMasterBean.getAsset_sub_type());
                proc.setString(4, oAssetMasterBean.getAsset_subtype_desc());
                proc.setString(5, oAssetMasterBean.getLong_desc());
                proc.setString(6, oAssetMasterBean.getDepr_rate());
              
                proc.setString(7, ServletName);
                proc.registerOutParameter(8, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(8);

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
                request.getRequestDispatcher("/Asset_JSP/assetMaster.jsp").forward(request, response);

            }

        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oAssetMasterBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(AssetMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(AssetMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(AssetMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select am.id,am.ASSET_TYPE,"
                                                        +"type_desc,"
                                                        +"asset_subtype," 
                                                        +"subtype_desc," 
                                                        +"description," 
                                                        +"depr_rate"
                                                        +" from asset_master am"
                        + " where  ASSET_TYPE= '" + oAssetMasterBean.getAsset_typeSearch() + "' AND asset_subtype='" + oAssetMasterBean.getAsset_subtypeSearch() + "'");

                while (rs.next()) {

                    oAssetMasterBean.setAsset_id(rs.getString("id"));
                    oAssetMasterBean.setAsset_type(rs.getString("asset_type"));
                    oAssetMasterBean.setAsset_type_desc(rs.getString("type_desc"));
                    oAssetMasterBean.setAsset_sub_type(rs.getString("asset_subtype"));
                    oAssetMasterBean.setAsset_subtype_desc(rs.getString("subtype_desc"));
                    oAssetMasterBean.setLong_desc(rs.getString("description"));
                    oAssetMasterBean.setDepr_rate(rs.getString("depr_rate"));
                    

                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");
                }
                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Asset Type or Asset SubType not exists in the system";
                request.setAttribute("message", message);
            }

            request.setAttribute("oAssetMasterBeanObj", oAssetMasterBean);
            request.getRequestDispatcher("/Asset_JSP/assetMaster.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oAssetMasterBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call assetMaster.upsert_assetMaster(?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                proc.setString(1, oAssetMasterBean.getAsset_typeAmend());
                proc.setString(2, oAssetMasterBean.getAsset_type_descAmend());
                proc.setString(3, oAssetMasterBean.getAsset_subtypeAmend());
                proc.setString(4, oAssetMasterBean.getAsset_subtype_descAmend());
                proc.setString(5, oAssetMasterBean.getLong_descAmend());
                proc.setString(6, oAssetMasterBean.getDepr_rateAmend());
               
                proc.setString(7, ServletName);

                proc.registerOutParameter(8, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(8);

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
                request.getRequestDispatcher("/Asset_JSP/assetMaster.jsp").forward(request, response);

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
