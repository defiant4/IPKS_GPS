
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.GlProductOperationBean;
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
public class GlProductOperationServlet extends HttpServlet {

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

        GlProductOperationBean oGlProductOperationBean = new GlProductOperationBean();

        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oGlProductOperationBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.Upsert_gl_product(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oGlProductOperationBean.getStatus());
                proc.setString(2, oGlProductOperationBean.getApplicableFor());
                proc.setString(3, oGlProductOperationBean.getGlCode());
                proc.setString(4, oGlProductOperationBean.getGlName());
                proc.setString(5, oGlProductOperationBean.getGlDescription());
                proc.setString(6, oGlProductOperationBean.getProductType());
                proc.setString(7, oGlProductOperationBean.getInttCategory());
                proc.setString(8, oGlProductOperationBean.getSegmentCode());
                proc.setString(9, oGlProductOperationBean.getComponent1());
                proc.setString(10, oGlProductOperationBean.getComponent2());
                proc.setString(11, oGlProductOperationBean.getGlType());
                proc.setString(12, oGlProductOperationBean.getGl_product_id());
                proc.setString(13, ServletName);

                proc.registerOutParameter(14, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(14);

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
                request.getRequestDispatcher("/glProductOperation.jsp").forward(request, response);

            }

        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oGlProductOperationBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select id, status, action, to_char(eff_date,'dd/mm/yyyy') as eff_date , gl_code, gl_name, gl_desc, product_type, interest_cat, segment_code, comp1, comp2, gl_type from gl_product where gl_code= '" + oGlProductOperationBean.getBglCodeSearch() + "'");

                while (rs.next()) {

                    oGlProductOperationBean.setGl_product_id(rs.getString("id"));
                    oGlProductOperationBean.setStatus(rs.getString("status"));
                    oGlProductOperationBean.setApplicableFor(rs.getString("action"));
                    oGlProductOperationBean.setEffectDate(rs.getString("eff_date"));
                    oGlProductOperationBean.setGlCode(rs.getString("gl_code"));
                    oGlProductOperationBean.setGlName(rs.getString("gl_name"));
                    oGlProductOperationBean.setGlDescription(rs.getString("gl_desc"));
                    oGlProductOperationBean.setProductType(rs.getString("product_type"));
                    oGlProductOperationBean.setInttCategory(rs.getString("interest_cat"));
                    oGlProductOperationBean.setSegmentCode(rs.getString("segment_code"));
                    oGlProductOperationBean.setComponent1(rs.getString("comp1"));
                    oGlProductOperationBean.setComponent2(rs.getString("comp2"));
                    oGlProductOperationBean.setGlType(rs.getString("gl_type"));

                    SeachFound = 1;

                }

                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "GL Code not exists in the system";
                request.setAttribute("message", message);
            }
            request.setAttribute("oGlProductOperationBeanObj", oGlProductOperationBean);
            request.setAttribute("displayFlag", "Y");
            request.getRequestDispatcher("/glProductOperation.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oGlProductOperationBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.Upsert_gl_product(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oGlProductOperationBean.getStatusAmend());
                proc.setString(2, oGlProductOperationBean.getApplicableForAmend());
                proc.setString(3, oGlProductOperationBean.getGlCodeAmend());
                proc.setString(4, oGlProductOperationBean.getGlNameAmend());
                proc.setString(5, oGlProductOperationBean.getGlDescriptionAmend());
                proc.setString(6, oGlProductOperationBean.getProductTypeAmend());
                proc.setString(7, oGlProductOperationBean.getInttCategoryAmend());
                proc.setString(8, oGlProductOperationBean.getSegmentCodeAmend());
                proc.setString(9, oGlProductOperationBean.getComponent1Amend());
                proc.setString(10, oGlProductOperationBean.getComponent2Amend());
                proc.setString(11, oGlProductOperationBean.getGlTypeAmend());
                proc.setString(12, oGlProductOperationBean.getGl_product_id());
                proc.setString(13, ServletName);

                proc.registerOutParameter(14, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(14);

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
                request.getRequestDispatcher("/glProductOperation.jsp").forward(request, response);

            }

        } else if ("StatusSearch".equalsIgnoreCase(ServletName)) {

            String bglCodeActivation = request.getParameter("bglCodeActivation");
            String vFlag = request.getParameter("BglstatusFlag");

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.gl_product_Activation(?,?,?)}");
                } catch (SQLException ex) {
                    Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, bglCodeActivation);
                proc.setString(2, vFlag);
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
                request.getRequestDispatcher("/glProductOperation.jsp").forward(request, response);

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
